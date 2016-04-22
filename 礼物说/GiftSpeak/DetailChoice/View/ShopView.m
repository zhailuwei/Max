//
//  ShopView.m
//  GiftSpeak
//
//  Created by dllo on 15/8/28.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ShopView.h"
#import "ReHeight.pch"

@implementation ShopView
//好店推荐点进去的四个小button定义成自定义view

- (void)dealloc
{
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.oneButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.oneButton.backgroundColor = [UIColor clearColor];
        [self addSubview:_oneButton];
        
        self.twoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.twoButton.backgroundColor = [UIColor clearColor];
        [self addSubview:_twoButton];
        
        
        self.threeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.threeButton.backgroundColor = [UIColor clearColor];
        [self addSubview:_threeButton];
        
        
        self.fourButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.fourButton.backgroundColor = [UIColor clearColor];
        [self addSubview:_fourButton];
        
        self.oneButton.frame = CGRectMake(5 * OffWidth, 0, 80 * OffWidth, 50 * OffHeight);
        
        self.twoButton.frame = CGRectMake(90 * OffWidth, 0, 80 * OffHeight, 50 * OffHeight);
        
        self.threeButton.frame = CGRectMake(5 * OffWidth, 55 * OffHeight, 80 * OffWidth, 50 * OffHeight);
        
        self.fourButton.frame = CGRectMake(90 * OffWidth, 55 * OffHeight, 80 * OffWidth, 50 * OffHeight);
    }
    return self;
}

@end
