//
//  DivideCell.m
//  GiftSpeak
//
//  Created by dllo on 15/8/25.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "DivideCell.h"
#import "DivideButton.h"
#import "DivideModel.h"
#import "ReHeight.pch"

@implementation DivideCell

//分类界面的上方专题的整个cell
- (void)dealloc
{
    [_titleLabel release];
    [super dealloc];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleLabel];
        
        self.searchButton = [DivideButton buttonWithType:UIButtonTypeSystem];
        self.searchButton.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_searchButton];
        
        self.image = [[UIImageView alloc]init];
        self.image.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_image];
        
        self.leftButton = [DivideButton buttonWithType:UIButtonTypeSystem];
        self.leftButton.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_leftButton];
        
        
        self.rightButton = [DivideButton buttonWithType:UIButtonTypeSystem];
        self.rightButton.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_rightButton];
        
        
        
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = (self.frame.size.width - 10 * OffWidth) / 2;
    
    self.titleLabel.frame = CGRectMake(5 * OffWidth, 5 * OffHeight, 40 * OffWidth, 30 * OffHeight);
    self.titleLabel.text = @"专题";
    
    self.leftButton.frame = CGRectMake(5 * OffWidth, 40 * OffHeight, w, 80 * OffHeight);
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    
    self.rightButton.frame = CGRectMake(w + 10 * OffWidth, 40 * OffHeight, w, 80 * OffHeight);
    
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    self.searchButton.frame = CGRectMake(280 * OffWidth, 10 * OffHeight, 70 * OffWidth, 20 * OffHeight);
    [self.searchButton setTitle:@"查看全部" forState:UIControlStateNormal];
    self.searchButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.searchButton.titleLabel.textColor = [UIColor blackColor];
    
    self.image.frame = CGRectMake(350 * OffWidth, 10 * OffHeight, 20 * OffWidth, 20 * OffHeight);
    self.image.image = [UIImage imageNamed:@"23.png"];
    
    
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
