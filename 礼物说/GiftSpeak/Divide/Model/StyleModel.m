//
//  StyleModel.m
//  GiftSpeak
//
//  Created by dllo on 15/8/25.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "StyleModel.h"

@implementation StyleModel
//分类界面中攻略的每一个cell的model

- (void)dealloc
{
    [_icon_url release];
    [_id release];
    [_name release];
    [_cover_image_url release];
    [_title release];
    [_likes_count release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
