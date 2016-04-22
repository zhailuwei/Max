//
//  CellModel.m
//  GiftSpeak
//
//  Created by dllo on 15/8/24.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

//每个cell的内容
- (void)dealloc
{
//    [_id release];
    [_banner_image_url release];
    [_cover_image_url release];
    [_subtitle release];
    [_title release];
    [_type release];
    [_updated_at release];
    [_content_url release];
    [_share_msg release];
    [_short_title release];
    [_likes_count release];
    [_url release];
    [_published_at release];
    [super dealloc];
    

    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
