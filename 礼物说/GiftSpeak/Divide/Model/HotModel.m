//
//  HotModel.m
//  GiftSpeak
//
//  Created by dllo on 15/8/31.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel

/**
 *  分类界面中得礼物界面的热门分类以及右侧小图标的model
 */

- (void)dealloc
{
    [_icon_url release];
    [_id release];
    [_name release];
    [_parent_id release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
