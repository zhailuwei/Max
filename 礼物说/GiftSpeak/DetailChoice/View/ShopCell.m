//
//  ShopCell.m
//  GiftSpeak
//
//  Created by dllo on 15/8/28.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ShopCell.h"
#import "ShopView.h"
#import "DetailModel.h"
#import "UIButton+WebCache.h"
#import "ReHeight.pch"

@implementation ShopCell

//好店推荐点进去的详情界面的cell

- (void)dealloc
{
    [_topImage release];
    [_smallTitleLabel release];
    [_titleLabel release];
    [_imageButton release];
    [_rightLabel release];
    [_bigImage release];
    [_arr release];
    [super dealloc];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

        
        self.topImage = [[UIImageView alloc]init];
        self.topImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_topImage];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleLabel];
        
        self.smallTitleLabel = [[UILabel alloc]init];
        self.smallTitleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_smallTitleLabel];
        
        self.imageButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.imageButton.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_imageButton];
        
        self.rightLabel = [[UILabel alloc]init];
        self.rightLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_rightLabel];
        
        
        self.bigImage = [[UIImageView alloc]init];
        self.bigImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_bigImage];

        
        self.shop = [[ShopView alloc]init];
        self.shop.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_shop];
        
    }
    
    return self;
}



- (void)passValue:(NSArray *)array
{
    self.arr = [NSMutableArray array];
    
        for (int i = 0; i < array.count ; i++) {
    
    [_shop.oneButton sd_setBackgroundImageWithURL:[NSURL URLWithString:array[1]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]];
            
            
    [_shop.twoButton sd_setBackgroundImageWithURL:[NSURL URLWithString:array[2]]  forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]];
    
    [_shop.threeButton sd_setBackgroundImageWithURL:[NSURL URLWithString:array[3]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]];
    
    [_shop.fourButton sd_setBackgroundImageWithURL:[NSURL URLWithString:array[4]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]];
        }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.topImage.frame = CGRectMake(5 * OffWidth, 5 * OffHeight, 30 * OffWidth, 40 * OffHeight);
    
    self.titleLabel.frame = CGRectMake(40 * OffWidth, 5 * OffHeight, 120 * OffWidth, 20 * OffHeight);
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    
    self.smallTitleLabel.frame = CGRectMake(40 * OffWidth, 25 * OffHeight, 140 * OffWidth, 20 * OffHeight);
    self.smallTitleLabel.font = [UIFont systemFontOfSize:10];
    
    
    self.bigImage.frame = CGRectMake(200 * OffWidth, 50 * OffHeight, 160 * OffWidth, 105 * OffHeight);
    
    self.rightLabel.frame = CGRectMake(280 * OffWidth, 10 * OffHeight, 60 * OffWidth, 20 * OffHeight);
    self.rightLabel.text = @"品牌主页";
    self.rightLabel.font = [UIFont systemFontOfSize:13];
    
    
    self.shop.frame = CGRectMake(10 * OffWidth, 50 * OffHeight, 180 * OffWidth, 105 * OffHeight);
}


@end
