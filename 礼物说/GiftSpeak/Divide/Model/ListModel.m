//
//  ListModel.m
//  GiftSpeak
//
//  Created by dllo on 15/9/2.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

- (void)dealloc
{
    [_id release];
    [_name release];
    [_order release];
    [_cover_image_url release];
    [_price release];
    [_favorites_count release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
