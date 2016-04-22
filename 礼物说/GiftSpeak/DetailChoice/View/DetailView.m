//
//  DetailView.m
//  GiftSpeak
//
//  Created by dllo on 15/8/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "DetailView.h"
#import "AsynURLConnection.h"
#import "DefineURL.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
#import "DetailModel.h"
#import "UIButton+WebCache.h"
#import "TitleModel.h"
#import "ScrollViewController.h"
#import "ReHeight.pch"

@interface DetailView () <UIScrollViewDelegate>
@property (nonatomic, retain) NSMutableArray *tableArr;
@property (nonatomic, retain) NSMutableArray *scrollArr;
@property(nonatomic,retain)NSMutableArray *buttonArr;

@end

@implementation DetailView

// 首页轮播图和美好小物四个标题的自定义View

- (void)dealloc
{
    [_page release];
    [_scroll release];
    [_buttonArr release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableArr = [NSMutableArray array];
        self.scrollArr = [NSMutableArray array];
        self.buttonArr = [NSMutableArray array];
        [self createScroll];
        
        }
    
    return self;
}


- (void)createScroll
{
    
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 150 * OffHeight)];
    _scroll.backgroundColor = [UIColor redColor];
    [self addSubview:_scroll];
    _scroll.contentOffset = CGPointMake(_scroll.frame.size.width, 0);
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(150 * OffWidth, 130 * OffHeight, 100 * OffWidth, 20 * OffHeight)]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ;
    self.page.backgroundColor = [UIColor clearColor];
   
    _page.currentPage = 0;
    _page.currentPageIndicatorTintColor = [UIColor redColor];
    _page.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_page];
   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(click:) userInfo:nil repeats:YES];
    [_scroll release];
    
}

//轮播图赋值
- (void)setImageWithModel:(NSArray *)array
{
    
    [_tableArr removeAllObjects];
    NSArray *subArray = [self.scroll subviews];
    for (UIButton *bu in subArray) {
        [bu removeFromSuperview];
    }
    [_tableArr addObjectsFromArray:array];
    
    for (int i = 0; i < _tableArr.count; i++) {
        DetailModel *model = [_tableArr objectAtIndex:i];
    
        UIScrollView *scroll1 = [[UIScrollView alloc]initWithFrame:CGRectMake(i * _scroll.frame.size.width, 0, _scroll.frame.size.width, 150 * OffHeight)];
        scroll1.backgroundColor = [UIColor whiteColor];
        [_scroll addSubview:scroll1];
    
    
        UIButton *image = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, scroll1.frame.size.width, scroll1.frame.size.height)];
        [image sd_setBackgroundImageWithURL:[NSURL URLWithString:model.image_url] forState:UIControlStateNormal];
        image.tag = i + 1;
        [image addTarget:self action:@selector(tapClick:) forControlEvents:UIControlEventTouchUpInside];
        [scroll1 addSubview:image];
        [image release];
}
    _scroll.contentSize = CGSizeMake(self.frame.size.width * _tableArr.count, 0);
    _page.numberOfPages = _tableArr.count;
}
#pragma mark -给美好小物等四个标题添加图片文字(传值)
//给美好小物等四个标题添加图片文字(传值)
- (void)setButtonImageWithModel:(NSArray *)arr
{
    
//    [self.buttonArr removeAllObjects]
    for (int i = 0; i < 4; i++) {
        TitleModel *model = [arr objectAtIndex:i];
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeSystem];
        imageButton.frame = CGRectMake(i * 90*OffWidth + 15 * OffWidth, 155 * OffHeight, 60 * OffWidth, 60 * OffHeight);
        [imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.icon_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]];
        imageButton.layer.cornerRadius = 30*OffWidth;
        imageButton.clipsToBounds = YES;
        [imageButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        imageButton.tag = i + 1;
        [self addSubview:imageButton];
        
        UILabel *buttonLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * 90*OffWidth + 15 * OffWidth,220 * OffHeight, 80 * OffWidth, 30 * OffHeight)];
        buttonLabel.font = [UIFont boldSystemFontOfSize:13];
        buttonLabel.text = model.title;
        [self addSubview:buttonLabel];
        [buttonLabel release];
    }
    
    
    
    
}

//轮播图加计时器循环滚动
- (void)click:(id)sender
{
    if (self.scroll.contentOffset.x == (self.tableArr.count - 1) * _scroll.frame.size.width) {
        
        self.scroll.contentOffset = CGPointMake(0, 0);
        
        self.page.currentPage = 0;
    }else{
        _scroll.contentOffset = CGPointMake(_scroll.contentOffset.x + _scroll.frame.size.width, 0);
        NSInteger count = _scroll.contentOffset.x / _scroll.frame.size.width;
        
        self.page.currentPage = count;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    NSInteger index = _scroll.contentOffset.x / self.frame.size.width;
    
    if (index == 0) {
        _scroll.contentOffset = CGPointMake(_scroll.frame.size.width * (_scrollArr.count - 2), 0);
        _page.currentPage = _tableArr.count - 2;
    }else if (index == _tableArr.count - 1){
        _scroll.contentOffset = CGPointMake(_scroll.frame.size.width, 0);
        _page.currentPage = 0;
    }else{
        _scroll.contentOffset = CGPointMake(_scroll.frame.size.width * index, 0);
        _page.currentPage = index - 2;
    }
    
}
#pragma mark - 用消息中心点击轮播图将button 和 数组传到MainViewController中
//用消息中心点击轮播图将button 和 数组传到MainViewController中
- (void)tapClick:(UIButton *)tap
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"KNOTIFIACTION6" object:nil userInfo:@{@"bu":tap, @"arr": _tableArr}];
}

/**
 *  美好小物等标题的点击事件进入相应界面(利用target/action将button传到viewcontroller中)
 *
 *  @param button 美好小物等四个标题button
 */
- (void)buttonClick:(UIButton *)button
{
    NSLog(@"click!");
    [self.target performSelector:self.action withObject:button];
}
@end
