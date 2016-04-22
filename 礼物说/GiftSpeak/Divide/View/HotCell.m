//
//  HotCell.m
//  GiftSpeak
//
//  Created by dllo on 15/8/31.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "HotCell.h"

@implementation HotCell

/**
 *  分类界面中礼物界面的热门分类
 */

- (void)dealloc
{
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.scrollButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.scrollButton.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_scrollButton];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollButton.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    [self.scrollButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
