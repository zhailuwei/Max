//
//  TitleModel.m
//  GiftSpeak
//
//  Created by dllo on 15/8/24.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "TitleModel.h"

@implementation TitleModel

//首页上方美好小物标题
- (void)dealloc
{
    [_icon_url release];
    [_title release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
}

@end
