//
//  QIxiModel.m
//  GiftSpeak
//
//  Created by dllo on 15/8/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "QIxiModel.h"

@implementation QIxiModel

- (void)dealloc
{
    [_banner_image_url release];
    [_cover_image_url release];
    [_id release];
    [_likes_count release];
    [_share_msg release];
    [_short_title release];
    [_title release];
    [_url release];
    [super dealloc];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
