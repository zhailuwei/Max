//
//  TextModel.m
//  GiftSpeak
//
//  Created by dllo on 15/9/5.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "TextModel.h"

@implementation TextModel

- (void)dealloc
{
    [_id release];
    [_cover_image_url release];
    [_likes_count release];
    [_price release];
    [_name release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
