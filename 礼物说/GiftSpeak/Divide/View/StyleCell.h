//
//  StyleCell.h
//  GiftSpeak
//
//  Created by dllo on 15/8/25.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StyleModel;
@protocol StyleCellDelegate;
//
#import "PressViewController.h"
@class CellView;

@interface StyleCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, retain) CellView *circle;

@property(nonatomic, retain) NSMutableArray * arr;

@property (nonatomic, retain) NSNumber *ID;

@property (nonatomic, retain) DivideViewController *divide;

@property (nonatomic, retain) StyleModel *model;

@property (nonatomic, assign) id<StyleCellDelegate>delegate;


@end

@protocol StyleCellDelegate <NSObject>

- (void)passValue:(NSNumber *)ID;

@end
