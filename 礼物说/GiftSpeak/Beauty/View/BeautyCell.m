//
//  BeautyCell.m
//  GiftSpeak
//
//  Created by dllo on 15/8/22.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "BeautyCell.h"
#import "ReHeight.pch"

@implementation BeautyCell

- (void)dealloc
{
    [_likeImage release];
    [_likeLabel release];
    [_mainImage release];
    [_titleLabel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.mainImage = [[UIImageView alloc]init];
        self.mainImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_mainImage];
        
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleLabel];
        
        
        self.likeImage = [[UIImageView alloc]init];
        self.likeImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_likeImage];
        
        self.likeLabel = [[UILabel alloc]init];
        self.likeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_likeLabel];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = self.contentView.frame.size.width;
    self.likeImage.frame = CGRectMake(280 * OffWidth, 50 * OffHeight, 30 * OffWidth, 30 * OffHeight);
    self.likeImage.image = [UIImage imageNamed:@"21.png"];
    
    self.likeLabel.frame = CGRectMake(310 * OffWidth, 50 * OffHeight, 60 * OffWidth, 30 * OffHeight);
    self.likeLabel.font = [UIFont systemFontOfSize:15];
    self.likeLabel.textColor = [UIColor whiteColor];
    self.mainImage.frame = CGRectMake(10*OffWidth, 10, w-20*OffWidth, 150 * OffHeight);
    self.mainImage.layer.cornerRadius = 10;
    self.mainImage.clipsToBounds = YES;
    self.titleLabel.frame = CGRectMake(15 * OffWidth, 100 * OffHeight, w - 30 *OffWidth, 30 * OffHeight);
    //    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
}
@end
