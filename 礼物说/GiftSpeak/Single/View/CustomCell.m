//
//  CustomCell.m
//  GiftSpeak
//
//  Created by dllo on 15/8/25.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "CustomCell.h"
#import "SingleButton.h"
#import "ReHeight.pch"

@implementation CustomCell
/**
 *  单品界面的cell
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
        _imageButton.frame = CGRectMake(5 * OffWidth, 5 * OffHeight, self.contentView.frame.size.width - 10 * OffWidth, 125 * OffHeight);
//        self.imageButton.backgroundColor = [UIColor clearColor];
        _imageButton.userInteractionEnabled = NO;
        [self.contentView addSubview:_imageButton];
        
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 * OffWidth, 130 * OffHeight, self.contentView.frame.size.width - 10 * OffWidth, 40 * OffHeight)];
        
        self.titleLabel.font = [UIFont systemFontOfSize:15 * OffHeight];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_titleLabel];
        
        
        self.moneyImage = [[UIImageView alloc]initWithFrame:CGRectMake(5 * OffWidth, 175 * OffHeight, 20 * OffWidth, 20 * OffHeight)];
        self.moneyImage.image = [UIImage imageNamed:@"22.png"];
        [self.contentView addSubview:_moneyImage];
        
        
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(23 * OffWidth, 175 * OffHeight, 50 * OffWidth, 20 * OffHeight)];
        self.moneyLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_moneyLabel];
        self.moneyLabel.font = [UIFont systemFontOfSize:15 * OffHeight];
        self.moneyLabel.textColor = [UIColor redColor];
        
        
        self.likeImage = [[UIImageView alloc]initWithFrame:CGRectMake(100 * OffWidth, 175 * OffHeight, 20 * OffWidth, 20 * OffHeight)];
        self.likeImage.image = [UIImage imageNamed:@"21.png"];
        [self.contentView addSubview:_likeImage];
        
        
        
        self.likeLabel = [[UILabel alloc]initWithFrame:CGRectMake(120 * OffWidth, 175 * OffHeight, 60 * OffWidth, 20 * OffHeight)];
        self.likeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_likeLabel];
        self.likeLabel.font = [UIFont systemFontOfSize:13];
        
        
       
        
        
        
    }
    
    return self;
}



    





@end
