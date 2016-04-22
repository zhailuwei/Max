//
//  DivideModel.m
//  GiftSpeak
//
//  Created by dllo on 15/8/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "DivideModel.h"

@implementation DivideModel

//分类界面上方专题的model
- (void)dealloc
{
    [_id release];
    [_banner_image_url release];
    [_title release];
    [_cover_image_url release];
    [_name release];
    [_price release];
    [_favorites_count release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
