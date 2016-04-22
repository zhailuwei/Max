//
//  StyleCell.m
//  GiftSpeak
//
//  Created by dllo on 15/8/25.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "StyleCell.h"
#import "CellView.h"
#import "StyleModel.h"
#import "UIButton+WebCache.h"
#import "PressViewController.h"
#import "MyButtonOfDivide.h"
#import "ReHeight.pch"


@implementation StyleCell

//分类界面下方的每一个自定义cell(品类,对象等)

- (void)dealloc
{
    [_circle release];
    [_ID release];
    [_titleLabel release];
    [super dealloc];
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.arr = [NSMutableArray array];
        self.titleLabel = [[UILabel alloc]init];
        
        self.titleLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_titleLabel];
        
            
    }
    
    return self;
    
}



//给自定义view设置大小和内容
- (void)setArr:(NSMutableArray *)arr
{
    
    if (_arr != arr) {
        [_arr release];
        _arr = [arr retain];
    }
    
    for (int i = 0; i < self.arr.count; i++) {
        NSInteger x = i % 5;
        NSInteger y = i / 5;
        
        StyleModel *model = [self.arr objectAtIndex:i];
            
        CellView *view = [[CellView alloc]initWithFrame:CGRectMake((x * 70 + 10) * OffWidth, (y * 90 + 50) * OffHeight, 60 * OffWidth, 80 * OffHeight)];
        [self.contentView addSubview:view];
        
        /**
         *  将imageButton的lid属性,让它等于传过来的model的id
         */
        view.imageButton.lid = model.id;
        [view release];
            
        [view.imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.icon_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]
];
        
        [view.imageButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        view.imageButton.userInteractionEnabled = YES;
        
        view.buttonLabel.text = model.name;
            
        
    }

    
}
 
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 20 * OffHeight);
    self.titleLabel.textColor = [UIColor purpleColor];
        
    
}


//
/**
 *  button添加的点击事件,将每个小按钮的id值传到GuideView中
 *
 *  @param button MyButtonOfDivide
 */

- (void)buttonClick:(MyButtonOfDivide *)button
{
    NSLog(@"111");
    [self.delegate passValue:button.lid];
    NSLog(@"%@", self.ID);
    
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
