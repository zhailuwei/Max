//
//  SearchModel.m
//  GiftSpeak
//
//  Created by dllo on 15/8/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

- (void)dealloc
{
    [_banner_image_url release];
    [_id release];
    [_subtitle release];
    [_title release];
    [super dealloc];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
