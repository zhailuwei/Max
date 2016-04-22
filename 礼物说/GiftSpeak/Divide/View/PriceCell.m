//
//  PriceCell.m
//  GiftSpeak
//
//  Created by dllo on 15/9/2.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "PriceCell.h"
#import "SingleButton.h"
#import "ReHeight.pch"
#import "ReHeight.pch"

@implementation PriceCell
/**
 *   选礼神器界面中点击价格的界面的cell
 */
- (void)dealloc
{
    [_imageButton release];
    [_likeImage release];
    [_likeLabel release];
    [_moneyImage release];
    [_moneyLabel release];
    [_titleLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageButton = [SingleButton buttonWithType:UIButtonTypeSystem];
        _imageButton.frame = CGRectMake(5 * OffWidth, 5 * OffHeight, self.contentView.frame.size.width, 100 * OffHeight);
        self.imageButton.backgroundColor = [UIColor clearColor];
        _imageButton.userInteractionEnabled = NO;
        [self.contentView addSubview:_imageButton];
        
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 * OffWidth, 110 * OffHeight, self.contentView.frame.size.width, 20 * OffHeight)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleLabel];
        
        
        self.moneyImage = [[UIImageView alloc]initWithFrame:CGRectMake(5 * OffWidth, 135 * OffHeight, 20 * OffWidth, 20 * OffHeight)];
        self.moneyImage.image = [UIImage imageNamed:@"22.png"];
        [self.contentView addSubview:_moneyImage];
        
        
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(30 * OffWidth, 135 * OffHeight, 50 * OffWidth, 20 * OffHeight)];
        self.moneyLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_moneyLabel];
        self.moneyLabel.font = [UIFont systemFontOfSize:13];
        self.moneyLabel.textColor = [UIColor redColor];
        
        
        self.likeImage = [[UIImageView alloc]initWithFrame:CGRectMake(120 * OffWidth, 135 * OffHeight, 20 * OffWidth, 20 * OffHeight)];
        self.likeImage.image = [UIImage imageNamed:@"21.png"];
        [self.contentView addSubview:_likeImage];
        
        
        
        self.likeLabel = [[UILabel alloc]initWithFrame:CGRectMake(140 * OffWidth, 135 * OffHeight, 40 * OffWidth, 20 * OffHeight)];
        self.likeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_likeLabel];
        self.likeLabel.font = [UIFont systemFontOfSize:13];
        
        
        
        
        
        
    }
    
    return self;
}


@end
