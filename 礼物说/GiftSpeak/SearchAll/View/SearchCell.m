//
//  SearchCell.m
//  GiftSpeak
//
//  Created by dllo on 15/8/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SearchCell.h"
#import "ReHeight.pch"

@implementation SearchCell

- (void)dealloc
{
    [_mainImage release];
    [_shortTitleLabel release];
    [_titleLabel release];
    [_leftImage release];
    [_rightImage release];
    [_circleImage release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.mainImage = [[UIImageView alloc]init];
        self.mainImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_mainImage];
        
        
        self.shortTitleLabel = [[UILabel alloc]init];
        self.shortTitleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_shortTitleLabel];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleLabel];
        
        self.leftImage = [[UIImageView alloc]init];
        self.leftImage.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_leftImage];
        
        
        self.rightImage = [[UIImageView alloc]init];
        self.rightImage.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_rightImage];
        
        self.circleImage = [[UIImageView alloc]init];
        self.circleImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_circleImage];
        
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.contentView.frame.size.width;
    CGFloat h = self.contentView.frame.size.height;
    
    self.mainImage.frame = CGRectMake(10 * OffWidth, 0, (w - 20) * OffWidth, (h - 10) * OffHeight);
    
    self.shortTitleLabel.frame = CGRectMake(130 * OffWidth, 30 * OffHeight, 150 * OffWidth, 30 * OffHeight);
    self.shortTitleLabel.textColor = [UIColor whiteColor];
    self.shortTitleLabel.font = [UIFont systemFontOfSize:20];
    
    self.leftImage.frame = CGRectMake(30 * OffWidth, 70 * OffHeight, 130 * OffWidth, 5 * OffHeight);
    self.leftImage.image = [UIImage imageNamed:@"24.png"];
    
    self.rightImage.frame = CGRectMake(180 * OffWidth, 70 * OffHeight, 130 * OffWidth, 5 * OffHeight);
    self.rightImage.image = [UIImage imageNamed:@"24.png"];
    
    self.circleImage.frame = CGRectMake(160 * OffWidth, 65 * OffHeight, 20 * OffWidth, 20 * OffHeight);
    self.circleImage.image = [UIImage imageNamed:@"25.png"];
    
    
    self.titleLabel.frame = CGRectMake(100 * OffWidth, 95* OffHeight, 250 * OffWidth, 30 * OffHeight);
    self.titleLabel.font = [UIFont systemFontOfSize:15];
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
