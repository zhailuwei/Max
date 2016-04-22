//
//  ClickCell.h
//  GiftSpeak
//
//  Created by dllo on 15/8/31.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DivideViewController.h"
@class HotModel;
@protocol ClickCellDelegate;

@class ClickView;

@interface ClickCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, retain) ClickView *click;

@property (nonatomic, retain) NSMutableArray *collectArr;

@property (nonatomic, retain) NSMutableArray *arr;

@property (nonatomic, retain) UICollectionView *collect;

@property (nonatomic, retain) NSNumber *ID;

@property (nonatomic, retain) DivideViewController *divide;

@property (nonatomic, retain) HotModel *model;

@property (nonatomic, assign) id<ClickCellDelegate>delegate;

@end

@protocol ClickCellDelegate <NSObject>

- (void)sendMessage:(NSNumber *)ID;

@end
