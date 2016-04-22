//
//  AsynURLConnection.m
//  GiftSpeak
//
//  Created by dllo on 15/8/22.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "AsynURLConnection.h"
#import "SaveTools.h"
#import "Reachability.h"

@interface AsynURLConnection () <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@end

@implementation AsynURLConnection

- (void)dealloc
{
    Block_release(_finishBlock);
    [_receiveData release];
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.receiveData = [NSMutableData data];
        
    }
    
    return self;
}

// 判断网络是否连接成功
+ (BOOL)judgeConnection
{
    Reachability *reach = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    NetworkStatus status = [reach currentReachabilityStatus];
    if (status == NotReachable) { // 没网
        return NO;
    } else if (status == ReachableViaWWAN) { // 3G
        return YES;
        
    } else if (status == ReachableViaWiFi) { // wifi
        return YES;
    }
    return NO;
}


- (void)startConnection:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
}

+(instancetype)asynWithURL:(NSString *)url parmaters:(NSDictionary *)parmaters block:(void (^)(NSData *))block
{
    NSString *par = @"";
    for (NSString *key in parmaters) {
        if (par.length == 0) {
            par = [NSString stringWithFormat:@"?%@=%@", key, [parmaters objectForKey:key]];
        }else{
            par = [NSString stringWithFormat:@"%@&%@=%@", par, key, [parmaters objectForKey:key]];
        }
        
           }
     url = [NSString stringWithFormat:@"%@%@", url, par];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",url);
    NSString *urlStr = [NSString stringWithFormat:@"%ld", (unsigned long)[url hash]];
    
    NSString *path = [SaveTools pathWithName:urlStr directory:NSLibraryDirectory];
    NSLog(@"path ======= %@",path);
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        block(data);
    }
    
    BOOL judge = [AsynURLConnection judgeConnection];
    if (judge) {  //如果有网则请求数据
       
        AsynURLConnection *asyn = [[AsynURLConnection alloc]init];
        asyn.finishBlock = block;
        asyn.currentUrl= urlStr;
        [asyn startConnection:url];
        return asyn;
    }else{
        
        NSLog(@"无网络连接");

    }
    return nil;
    
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receiveData appendData:data];
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // 将网址名当成文件名进行存储
    [SaveTools saveDataWith:self.currentUrl directory:NSLibraryDirectory data:self.receiveData];
    
    self.finishBlock(self.receiveData);
    
}





@end
