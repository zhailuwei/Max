//
//  CollectionViewCell.h
//  GiftSpeak
//
//  Created by dllo on 15/9/1.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyButtonOfDivide;

@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) MyButtonOfDivide *imageButton;
@property (nonatomic, retain) UILabel *buttonLabel;
@end
