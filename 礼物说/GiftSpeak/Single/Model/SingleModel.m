//
//  SingleModel.m
//  GiftSpeak
//
//  Created by dllo on 15/8/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SingleModel.h"

@implementation SingleModel

- (void)dealloc
{
    [_cover_image_url release];
    [_id release];
    [_favorites_count release];
    [_image_urls release];
    [_name release];
    [_price release];
    [_url release];
    [super dealloc];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
