//
//  SaveModel.m
//  GiftSpeak
//
//  Created by dllo on 15/9/6.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SaveModel.h"

@implementation SaveModel

- (void)dealloc
{
    [_cover_image_url release];
    [_title release];
    [_url release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
