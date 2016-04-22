//
//  MineCell.m
//  GiftSpeak
//
//  Created by dllo on 15/8/28.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "MineCell.h"
#import "ReHeight.pch"

@implementation MineCell
/**
 *  第一个section的cell
 */
- (void)dealloc
{
    [_titleLabel release];
    [_image release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
        
        
        self.image = [[UIImageView alloc]init];
        self.image.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_image];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(30 * OffWidth, 5 * OffHeight, 200 * OffWidth, 30 * OffHeight);
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.image.frame = CGRectMake(5 * OffWidth, 5 * OffHeight, 20 * OffWidth, 20 * OffHeight);
    self.image.backgroundColor = [UIColor clearColor];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
