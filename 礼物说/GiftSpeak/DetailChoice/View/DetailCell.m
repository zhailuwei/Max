//
//  DetailCell.m
//  GiftSpeak
//
//  Created by dllo on 15/8/22.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "DetailCell.h"
#import "ReHeight.pch"

@implementation DetailCell

//精选下方每个cell的界面 
- (void)dealloc
{
    [_dateLabel release];
    [_likeImage release];
    [_likeLabel release];
    [_mainImage release];
    [_clockImage release];
    [_updateLabel release];
    [super dealloc];
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.dateLabel = [[UILabel alloc]init];
        self.dateLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_dateLabel];
//        self.dateLabel.font = [UIFont boldSystemFontOfSize:25];
        [_dateLabel release];
        
        
        self.likeImage = [[UIImageView alloc]init];
        self.likeImage.backgroundColor = [UIColor clearColor];
        [self addSubview:_likeImage];
        [self.likeImage release];
        
        self.mainImage = [[UIImageView alloc]init];
        self.mainImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_mainImage];
        [self.mainImage release];
        
        self.likeLabel = [[UILabel alloc]init];
        self.likeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_likeLabel];
        
        
        self.clockImage = [[UIImageView alloc]init];
        self.clockImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_clockImage];
        [self.clockImage release];
        
        self.updateLabel = [[UILabel alloc]init];
        self.updateLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_updateLabel];
        [_updateLabel release];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleLabel];
        [self.titleLabel release];
    
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.contentView.frame.size.width;
    
    self.dateLabel.frame = CGRectMake(10*OffWidth, 0, 150 * OffWidth, 40 * OffHeight);
    self.dateLabel.font = [UIFont systemFontOfSize:17];
    
    self.likeImage.frame = CGRectMake(280 * OffWidth, 50 * OffHeight, 30 * OffWidth, 30 * OffHeight);
    self.likeImage.image = [UIImage imageNamed:@"21.png"];
    
    self.likeLabel.frame = CGRectMake(310 * OffWidth, 50 * OffHeight, 60 * OffWidth, 30 * OffHeight);
    self.likeLabel.font = [UIFont systemFontOfSize:15];
    self.likeLabel.textColor = [UIColor whiteColor];
    
    self.mainImage.frame = CGRectMake(10*OffWidth, 40 * OffHeight, w - 20*OffWidth, 150 * OffHeight);
    self.mainImage.layer.cornerRadius = 10;
    self.mainImage.clipsToBounds = YES;
    
    self.clockImage.frame = CGRectMake(190 * OffWidth, 5*OffHeight, 30 * OffWidth, 30 * OffHeight);
    
    
    self.updateLabel.frame = CGRectMake(230 * OffWidth, 0, 140 * OffWidth, 40 * OffHeight);
    self.updateLabel.font = [UIFont systemFontOfSize:15];
    self.updateLabel.textColor = [UIColor orangeColor];
    
    
    self.titleLabel.frame = CGRectMake(20 * OffWidth, 130 * OffHeight, w, 60 * OffHeight);
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    
}
@end
