//
//  DetailModel.m
//  GiftSpeak
//
//  Created by dllo on 15/8/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

//轮播图的内容
- (void)dealloc
{
    [_id release];
    [_brand_id release];
    [_image_url release];
    [_cover_image_url release];
    [_likes_count release];
    [_subtitle release];
    [_title release];
    [_order release];
    [_target_url release];
    [_target_id release];
    [_desc release];
    [_icon_url release];
    [_name release];
    [_published_at release];
    [super dealloc];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
}

@end
