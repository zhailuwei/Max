//
//  ClearCell.m
//  GiftSpeak
//
//  Created by dllo on 15/9/12.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ClearCell.h"
#import "ReHeight.pch"

@implementation ClearCell

- (void)dealloc
{
    [_titleLabel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imageButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _imageButton.frame = CGRectMake(5 * OffWidth, 5 * OffHeight, self.contentView.frame.size.width, 100 * OffHeight);
        self.imageButton.backgroundColor = [UIColor clearColor];
        _imageButton.userInteractionEnabled = NO;
        [self.contentView addSubview:_imageButton];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30 * OffWidth, 0 * OffHeight, 150 * OffWidth, self.contentView.frame.size.height)];
                           
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
