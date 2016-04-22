//
//  CollectionViewCell.m
//  GiftSpeak
//
//  Created by dllo on 15/9/1.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "CollectionViewCell.h"
#import "MyButtonOfDivide.h"
#import "ReHeight.pch"

@implementation CollectionViewCell

/**
 *  分类界面中礼物界面右侧tableView中每个cell套collectionView的collectionView的cell
 */
- (void)dealloc
{
    [_imageButton release];
    [_buttonLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageButton = [MyButtonOfDivide buttonWithType:UIButtonTypeSystem];
        
        [self.contentView addSubview:_imageButton];
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        self.buttonLabel = [[UILabel alloc]init];
        _buttonLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_buttonLabel];
        [_buttonLabel release];
        _buttonLabel.textAlignment = 1;
        _imageButton.frame = CGRectMake(0 , 0  , 50 * OffWidth, 50 * OffHeight);
        _buttonLabel.frame = CGRectMake(0 , 50 * OffHeight, 70 * OffWidth, 30 * OffHeight);
        
    }
    return self;
}


@end
