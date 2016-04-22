//
//  AsynURLConnection.h
//  GiftSpeak
//
//  Created by dllo on 15/8/22.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsynURLConnection : NSObject

@property (nonatomic, retain) NSMutableData *receiveData;

@property (nonatomic, copy) void (^finishBlock)(NSData *data);
@property (nonatomic, copy) NSString *currentUrl;

+ (instancetype)asynWithURL:(NSString *)url parmaters:(NSDictionary *)parmaters block:(void(^)(NSData *data))block;

- (void)startConnection:(NSString *)urlStr;

@end
