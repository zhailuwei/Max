//
//  MainViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/9/1.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "MainViewController.h"
#import "MainCell.h"
#import "SecondCell.h"
#import "ThirdCell.h"
#import "FourCell.h"
#import "FiveCell.h"
#import "SixCell.h"
#import "SevenCell.h"
#import "ClickViewController.h"
#import "GuideViewController.h"
#import "SmallViewController.h"
#import "ShopViewController.h"
#import "WriteViewController.h"
#import "PrizeViewController.h"
#import "FindViewController.h"
#import "ScrollViewController.h"
#import "DetailModel.h"
#import "ReHeight.pch"
#import "Reachability.h"

@interface MainViewController ()  <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *collect;
@property (nonatomic, retain) NSMutableArray *collectArr;
@property (nonatomic, retain) UIScrollView *scroll;
@property (nonatomic, retain) UISegmentedControl *segment;

@end

@implementation MainViewController

/**
 *  精选页面(一个collectionView套七个tableView)
 */

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"KNOTIFIACTION" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"KNOTIFIACTION1" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"KNOTIFIACTION6" object:nil];
    [_scroll release];
    [_collect release];
    [_collectArr release];
    [_segment release];
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.collectArr = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
#pragma mark - 消息中心传值
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifiAction:) name:@"KNOTIFIACTION" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifiAction1:) name:@"KNOTIFIACTION1" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifiAction2:) name:@"KNOTIFIACTION2" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifiAction3:) name:@"KNOTIFIACTION3" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notAction:) name:@"KNOTIFIACTION6" object:nil];
    [self createCollection];
    [self createButton];
}
-(void)createNavigation
{
    self.title = @"礼物说";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.85 green:0.32 blue:0.65 alpha:1.000];
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.backgroundColor = [UIColor clearColor];
    leftButton.frame = CGRectMake(10 * OffWidth , 0, 30 * OffWidth, 30 * OffHeight);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:leftButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.backgroundColor = [UIColor clearColor];
    rightButton.frame = CGRectMake(310 * OffWidth, 0, 20 * OffWidth, 20 * OffHeight);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"19.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rightButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}
//用消息中心点击轮播图进入下一页
- (void)notAction:(NSNotification *)noti
{
    NSDictionary *dic = noti.userInfo;
    UIButton *bu = [dic objectForKey:@"bu"];
    NSMutableArray *arr = [dic objectForKey:@"arr"];
    DetailModel *model = [arr objectAtIndex:bu.tag - 1];
    ScrollViewController *sc = [[ScrollViewController alloc]init];
    sc.numID = model.target_id;
    [self.navigationController pushViewController:sc animated:YES];
    
}
- (void)leftClick:(UIButton *)button
{
    MainViewController *main = [[MainViewController alloc]init];
    [self.navigationController pushViewController:main animated:YES];
    [main release];
}

- (void)buttonClick:(UIButton *)button
{
    FindViewController *find = [[FindViewController alloc]init];
    [self.navigationController pushViewController:find animated:YES];
    [find release];
}
#pragma mark - 消息中心跳转页面
- (void)notifiAction:(NSNotification *)noti
{
    NSLog(@"%@", noti);
    SmallViewController *small = [[SmallViewController alloc]init];
    [self.navigationController pushViewController:small animated:YES];
    [small release];
}
- (void)notifiAction1:(NSNotification *)noti
{
    NSLog(@"%@", noti);
    ShopViewController *shop = [[ShopViewController alloc]init];
    [self.navigationController pushViewController:shop animated:YES];
    [shop release];
}

- (void)notifiAction2:(NSNotification *)noti
{
    NSLog(@"%@", noti);
    WriteViewController *write = [[WriteViewController alloc]init];
    [self.navigationController pushViewController:write animated:YES];
    [write release];
}

- (void)notifiAction3:(NSNotification *)noti
{
    NSLog(@"%@", noti);
    PrizeViewController *prize = [[PrizeViewController alloc]init];
    [self.navigationController pushViewController:prize animated:YES];
    [prize release];
}



#pragma mark-
#pragma mark -创建精选等小标题(利用scrollView上套segment)
/**
 *  创建精选等小标题(利用scrollView上套segment)
 */
- (void)createButton
{
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(10*OffWidth, 10*OffHeight, [UIScreen mainScreen].bounds.size.width - 20*OffWidth, 30 * OffHeight)];
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = YES;
    _scroll.delegate = self;
    
    _scroll.backgroundColor = [UIColor clearColor];
    _scroll.contentSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 20) * 7, 0);
    [self.view addSubview:_scroll];
    [_scroll release];
    

    
    NSArray *arr = [NSArray arrayWithObjects:@"精选", @"穿搭", @"礼物", @"美护", @"美食", @"鞋包", @"娱乐", nil];

    self.segment = [[UISegmentedControl alloc]initWithItems:arr];
    _segment.frame = CGRectMake(10 * OffWidth, 10*OffHeight, [UIScreen mainScreen].bounds.size.width - 20*OffWidth, 30 * OffHeight);
    _segment.selectedSegmentIndex = 0;
    _segment.tintColor = [UIColor colorWithRed:1.000 green:0.45 blue:0.812 alpha:1.000];
    [_segment addTarget:self action:@selector(changePosition:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segment];
    [_segment release];
}

/**
 *  改变当前页
 *
 *  @param segment 每一个小标题
 */
- (void)changePosition:(UISegmentedControl *)segment
{
    NSInteger index = segment.selectedSegmentIndex;
    CGPoint point = CGPointMake(index * self.view.frame.size.width, 0);
    [_scroll setContentOffset:point animated:YES];
    
    _collect.contentOffset = CGPointMake(index * self.view.frame.size.width, 0);
   
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _segment.selectedSegmentIndex = scrollView.contentOffset.x / self.view.frame.size.width;
    
}

- (void)createCollection
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height) collectionViewLayout:layout];
    self.collect.backgroundColor = [UIColor whiteColor];
    _collect.dataSource = self;
    _collect.delegate = self;
    _collect.contentSize = CGSizeMake(self.view.frame.size.width * 7, 0);
    [self.view addSubview:_collect];
    _collect.pagingEnabled = YES;
    
    [_collect registerClass:[MainCell class] forCellWithReuseIdentifier:@"main"];
    
    [_collect registerClass:[SecondCell class] forCellWithReuseIdentifier:@"second"];
    [_collect registerClass:[ThirdCell class] forCellWithReuseIdentifier:@"third"];
    [_collect registerClass:[FourCell class] forCellWithReuseIdentifier:@"four"];
    [_collect registerClass:[FiveCell class] forCellWithReuseIdentifier:@"five"];
    [_collect registerClass:[SixCell class] forCellWithReuseIdentifier:@"six"];
    [_collect registerClass:[SevenCell class] forCellWithReuseIdentifier:@"seven"];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0) {
        MainCell *main = [collectionView dequeueReusableCellWithReuseIdentifier:@"main" forIndexPath:indexPath];
        main.target = self;
        main.action = @selector(CellClick1:);
        
        return main;
    }
    else if (indexPath.item == 1){
        SecondCell *second = [collectionView dequeueReusableCellWithReuseIdentifier:@"second" forIndexPath:indexPath];
        second.target = self;
        second.action = @selector(CellClick2:);
        return second;
    }else if (indexPath.item == 2){
        ThirdCell *third = [collectionView dequeueReusableCellWithReuseIdentifier:@"third" forIndexPath:indexPath];
        third.target = self;
        third.action = @selector(CellClick3:);
        return third;
    }else if (indexPath.item == 3){
        FourCell *four = [collectionView dequeueReusableCellWithReuseIdentifier:@"four" forIndexPath:indexPath];
        four.target = self;
        four.action = @selector(CellClick4:);
        return four;
    }else if (indexPath.item == 4){
        FiveCell *five = [collectionView dequeueReusableCellWithReuseIdentifier:@"five" forIndexPath:indexPath];
        five.target = self;
        five.action = @selector(CellClick5:);
        return five;
    }else if (indexPath.item == 5){
        SixCell *six = [collectionView dequeueReusableCellWithReuseIdentifier:@"six" forIndexPath:indexPath];
        six.target = self;
        six.action = @selector(CellClick6:);
        return six;
    }else{
        SevenCell *seven = [collectionView dequeueReusableCellWithReuseIdentifier:@"seven" forIndexPath:indexPath];
        seven.target = self;
        seven.action = @selector(CellClick7:);
        return seven;
    }
    
}

/**
 *  点击进入精选界面每个cell的详情界面
 *
 *  @param cell 精选界面的每个cell
 */
- (void)CellClick1:(CellModel * )model
{
    ClickViewController *click = [[ClickViewController alloc]init];
    click.model = model;
    click.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:click animated:YES];

    [click release];
    
}
/**
 *  点击进入穿搭界面每个cell的详情界面
 *
 *  @param sender 穿搭界面的每个cell
 */
- (void)CellClick2:(NSString *)url
{
    
    [self clickWithUrl:url];
    
}
/**
 *  点击进入礼物界面每个cell的详情界面
 *
 *  @param sender 礼物界面的每个cell
 */
- (void)CellClick3:(NSString *)url
{
    [self clickWithUrl:url];
}
/**
 *  点击进入美护界面的每个cell的详情界面
 *
 *  @param sender 美护界面的每个cell
 */

- (void)CellClick4:(NSString *)url
{
    [self clickWithUrl:url];
}

/**
 *  点击进入美食界面的每个cell的详情界面
 *
 *  @param sender 美食界面的每个cell
 */
- (void)CellClick5:(NSString *)url
{
    
    [self clickWithUrl:url];
}

/**
 *  点击进入鞋包界面的每个cell的详情界面
 *
 *  @param sender 鞋包界面的每个cell
 */
- (void)CellClick6:(NSString *)url
{
    
    [self clickWithUrl:url];
}

/**
 *  点击进入娱乐界面的每个cell的详情界面
 *
 *  @param sender 娱乐界面的每个cell
 */
- (void)CellClick7:(NSString *)url
{
    [self clickWithUrl:url];
}

- (void)clickWithUrl:(NSString *)url
{
    GuideViewController *guide = [[GuideViewController alloc]init];
    guide.urlStr = url;
    
    [self.navigationController pushViewController:guide animated:YES];
    [guide release];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
