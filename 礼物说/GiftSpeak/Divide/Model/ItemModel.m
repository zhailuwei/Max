//
//  ItemModel.m
//  GiftSpeak
//
//  Created by dllo on 15/9/9.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel

- (void)dealloc
{
    [_cover_image_url release];
    [_name release];
    [_favorites_count release];
    [_price release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
