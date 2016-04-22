//
//  PressCell.m
//  GiftSpeak
//
//  Created by dllo on 15/8/31.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "PressCell.h"
#import "ReHeight.pch"

@implementation PressCell

- (void)dealloc
{
    [_mainImage release];
    [_likeImage release];
    [_likeLabel release];
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
        
        self.likeImage = [[UIImageView alloc]init];
        self.likeImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_likeImage];
        
        self.likeLabel = [[UILabel alloc]init];
        self.likeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_likeLabel];
        
        [self.titleLabel = [UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleLabel];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat w = self.contentView.frame.size.width;
    CGFloat h = self.contentView.frame.size.height;
    
    self.mainImage.frame = CGRectMake(10*OffWidth, 10*OffHeight, w-20*OffWidth, h - 20* OffHeight);
    self.mainImage.layer.cornerRadius = 10.0f;
    self.mainImage.clipsToBounds = YES;
    
    self.likeImage.frame = CGRectMake(280 * OffWidth, 50 * OffHeight, 30 * OffWidth, 30 * OffHeight);
    self.likeImage.image = [UIImage imageNamed:@"21.png"];
    
    self.likeLabel.frame = CGRectMake(310 * OffWidth, 50 * OffHeight, 60 * OffWidth, 30 * OffHeight);
    self.likeLabel.font = [UIFont systemFontOfSize:15];
    self.likeLabel.textColor = [UIColor whiteColor];
    
    self.titleLabel.frame = CGRectMake(15 * OffWidth, 130 * OffHeight, w-30*OffWidth, 30 * OffHeight);
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textColor = [UIColor whiteColor];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
