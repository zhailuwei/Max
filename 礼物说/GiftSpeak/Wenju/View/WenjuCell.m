//
//  WenjuCell.m
//  GiftSpeak
//
//  Created by dllo on 15/8/25.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "WenjuCell.h"
#import "ReHeight.pch"

@implementation WenjuCell

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
        
       
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleLabel];
        
        
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        self.button.backgroundColor = [UIColor grayColor];
        [self addSubview:_button];
        
        self.likeImage = [[UIImageView alloc]init];
        self.likeImage.backgroundColor = [UIColor clearColor];
        [self addSubview:_likeImage];
        
        self.likeLabel = [[UILabel alloc]init];
        self.likeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_likeLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.contentView.frame.size.width;
    CGFloat h = self.contentView.frame.size.height;
    
    self.mainImage.frame = CGRectMake(0, 0, w, (h - 10) * OffHeight);
    
    self.likeImage.frame = CGRectMake(300 * OffWidth, 5 * OffHeight, 20 * OffWidth, 20 * OffHeight);
    self.likeImage.image = [UIImage imageNamed:@"21.png"];
    
    self.likeLabel.frame = CGRectMake(320 * OffWidth, 5 * OffHeight, 40 * OffWidth, 20 * OffHeight);
    self.likeLabel.textColor = [UIColor whiteColor];
    self.likeLabel.font = [UIFont systemFontOfSize:13];
    
    self.titleLabel.frame = CGRectMake(5 * OffWidth, 120 * OffHeight, w, 30 * OffHeight);
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.button.frame = CGRectMake(300 * OffWidth, 5 * OffHeight, 60 * OffWidth, 20 * OffHeight);
    
    
 
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
