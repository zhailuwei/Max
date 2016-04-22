//
//  Internet.m
//  GiftSpeak
//
//  Created by dllo on 15/9/3.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "Internet.h"
#import "Reachability.h"

@implementation Internet

+ (NSString *)internetStatus
{
    Reachability *reach = [Reachability reachabilityWithHostname:@"http://www.baidu.com"];
    NetworkStatus status = [reach currentReachabilityStatus];
    
    if (status == 0) {
        return @"NO";
    }else if (status == 1){
        return @"WWAN";
    }else if (status == 2){
        return @"WiFi";
    }
    return nil;
    
    
}

@end
