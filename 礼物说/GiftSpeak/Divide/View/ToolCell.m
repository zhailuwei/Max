//
//  ToolCell.m
//  GiftSpeak
//
//  Created by dllo on 15/8/29.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ToolCell.h"
#import "ReHeight.pch"

@implementation ToolCell

//分类界面选礼神器中得每一个item的cell

- (void)dealloc
{
    [_mainImage release];
    [_likeImage release];
    [_likeLabel release];
    [_moneyImage release];
    [_moneyLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(5 * OffWidth, 5 * OffHeight, self.contentView.frame.size.width, 100 * OffHeight)];
        _mainImage.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_mainImage];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 * OffWidth, 110 * OffHeight, self.contentView.frame.size.width, 20 * OffHeight)];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
        
        self.moneyImage = [[UIImageView alloc]initWithFrame:CGRectMake(5 * OffWidth, 135 * OffHeight, 20 * OffWidth, 20 * OffHeight)];
        self.moneyImage.backgroundColor = [UIColor whiteColor];
        self.moneyImage.image = [UIImage imageNamed:@"22.png"];
        [self.contentView addSubview:_moneyImage];
        
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(30 * OffWidth, 135 * OffHeight, 50 * OffWidth, 20 * OffHeight)];
        self.moneyLabel.backgroundColor = [UIColor whiteColor];
        self.moneyLabel.textColor = [UIColor redColor];
        self.moneyLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_moneyLabel];
        
        
        self.likeImage = [[UIImageView alloc]initWithFrame:CGRectMake(130 * OffWidth, 135 * OffHeight, 20 * OffWidth, 20 * OffHeight)];
        self.likeImage.backgroundColor = [UIColor whiteColor];
        self.likeImage.image = [UIImage imageNamed:@"21.png"];
        [self.contentView addSubview:_likeImage];
        
        self.likeLabel = [[UILabel alloc]initWithFrame:CGRectMake(150 * OffWidth, 135 * OffHeight, 30 * OffWidth, 20 * OffHeight)];
        self.likeLabel.backgroundColor = [UIColor whiteColor];
        self.likeLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_likeLabel];
        
    }
    return self;
    
}

@end
