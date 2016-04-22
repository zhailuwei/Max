//
//  MainCell.m
//  GiftSpeak
//
//  Created by dllo on 15/9/1.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "MainCell.h"
#import "DetailCell.h"
#import "DetailModel.h"
#import "DetailView.h"
#import "AsynURLConnection.h"
#import "DefineURL.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "TitleModel.h"
#import "CellModel.h"
#import "SmallViewController.h"
#import "ShopViewController.h"
#import "WriteViewController.h"
#import "PrizeViewController.h"
#import "Reachability.h"
#import "Internet.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"
#import "ReHeight.pch"


@interface MainCell () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSMutableArray *tableArr;
@property (nonatomic, retain) NSMutableArray *scrollArr;
@property (nonatomic, retain) NSMutableArray *titleArr;


@end

@implementation MainCell

/**
 *  精选cell(铺tableView)
 */
- (void)dealloc
{
    [_table release];
    [_tableArr release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableArr = [NSMutableArray array];
        self.scrollArr = [NSMutableArray array];
        self.titleArr = [NSMutableArray array];
        
        [self createTableView];
    
        [self myConnection];
        
        [self startConnection];
        
        [self cellConnection];
        
        [self try];
        
    }
    return self;
}



- (void)try
{
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    /*
     *第一个参数:观察者,即在什么地方接受通知
     *第二个参数:收到通知后调用何种方法
     *第三个参数:通知的名字,也是通知的唯一的标示,编译器就通过这个找到通知的
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChange:) name:kReachabilityChangedNotification object:nil];
    [reach startNotifier];
}

- (void)reachabilityChange:(NSNotification *)note
{
    Reachability *reach = [note object];
    NSParameterAssert([reach isKindOfClass:[Reachability class]]);
    [self updataInterfaceWithReachability:reach];
}

- (void)updataInterfaceWithReachability:(Reachability *)reach
{
    
    NetworkStatus status = [reach currentReachabilityStatus];
    if (status == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络" message:@"请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [self myConnection];
        [alert show];
        [alert release];
        
    }
    else if (status == 2) {
        [self myConnection];
        NSLog(@"有网络WiFi");
    }else {
        [self myConnection];
        NSLog(@"有网络1");
    }
}




// 轮播图的数据解析
- (void)myConnection
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"iOS" forKey:@"channel"];
    
    NSString *judge = [Internet internetStatus];
    if ([judge isEqualToString:@"WiFi"]) {
        
    
    
    [AsynURLConnection asynWithURL:LWS_JXImage parmaters:dic block:^(NSData *data) {
        
        
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [self.scrollArr removeAllObjects];
        NSArray *LibArr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [LibArr firstObject];
        path = [NSString stringWithFormat:@"%@/%@",path, @"Jingxuan"];
        [data writeToFile:path atomically:YES];
        
        NSDictionary *dict = [root objectForKey:@"data"];
        NSArray *arr = [dict objectForKey:@"banners"];

        for (NSDictionary *dic in arr) {
            DetailModel *model = [[DetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.scrollArr addObject:model];
            [model release];
        }
    
        [self.table reloadData];
        [self setScrollValue];
        
        NSLog(@"WIFI");
        
    }];
        
    }else if ([judge isEqualToString:@"WWAN"]){
        [AsynURLConnection asynWithURL:LWS_JXImage parmaters:dic block:^(NSData *data) {
            
            NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [self.scrollArr removeAllObjects];

            NSArray *LibArr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            NSString *path = [LibArr firstObject];
            path = [NSString stringWithFormat:@"%@/%@",path, @"Jingxuan"];
            [data writeToFile:path atomically:YES];

            NSDictionary *dict = [root objectForKey:@"data"];
            NSArray *arr = [dict objectForKey:@"banners"];

            for (NSDictionary *dic in arr) {
                DetailModel *model = [[DetailModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.scrollArr addObject:model];
                [model release];
            }
            [self.table reloadData];
            [self setScrollValue];
            NSLog(@"WWAN");
        }];
        
    }else{
        
        NSArray *LibArr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [LibArr firstObject];
        path = [NSString stringWithFormat:@"%@/%@",path, @"Jingxuan"];
        NSLog(@"%@", path);
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:path]) {
            NSData *data = [NSData dataWithContentsOfFile:path];
            NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [self.scrollArr removeAllObjects];

            NSDictionary *dict = [root objectForKey:@"data"];
            NSArray *arr = [dict objectForKey:@"banners"];

            for (NSDictionary *dic in arr) {
                DetailModel *model = [[DetailModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.scrollArr addObject:model];
                [model release];
            }
            [self.table reloadData];
            [self setScrollValue];
            
            NSLog(@"本地数据");
            
        }else{
            NSLog(@"本地无网无数据");
        }
    }
}
#pragma mark -首页Button 按钮
// 美好小物等标题的数据解析
- (void)startConnection
{
    NSMutableDictionary *titleDic = [NSMutableDictionary dictionary];
    [titleDic setObject:@"2" forKey:@"gender"];
    [titleDic setObject:@"2 " forKey:@"generation"];
    NSString *judge = [Internet internetStatus];
    if ([judge isEqualToString:@"WiFi"]) {
    [AsynURLConnection asynWithURL:LWS_JXBT parmaters:titleDic block:^(NSData *data) {
        [self.titleArr removeAllObjects];
        NSDictionary *title = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *LibArr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [LibArr firstObject];
        path = [NSString stringWithFormat:@"%@/%@",path, @"title"];
        [data writeToFile:path atomically:YES];
        
        NSDictionary *each = [title objectForKey:@"data"];
        NSArray *sum = [each objectForKey:@"promotions"];
        [self.titleArr removeAllObjects];
        for (NSDictionary *dic in sum) {
            TitleModel *model = [[TitleModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.titleArr addObject:model];
            [model release];
        }
        [self.table reloadData];
        [self setButton];
        
    }];
    }else if ([judge isEqualToString:@"WWAN"]){
        [AsynURLConnection asynWithURL:LWS_JXBT parmaters:titleDic block:^(NSData *data) {
            
            NSDictionary *title = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *LibArr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            NSString *path = [LibArr firstObject];
            path = [NSString stringWithFormat:@"%@/%@",path, @"title"];
            [data writeToFile:path atomically:YES];
            
            NSDictionary *each = [title objectForKey:@"data"];
            NSArray *sum = [each objectForKey:@"promotions"];
            [self.titleArr removeAllObjects];

            for (NSDictionary *dic in sum) {
                TitleModel *model = [[TitleModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.titleArr addObject:model];
                [model release];
            }
            [self.table reloadData];
            [self setButton];
            
        }];

    }else{
        NSArray *LibArr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [LibArr firstObject];
        path = [NSString stringWithFormat:@"%@/%@",path, @"title"];
        NSLog(@"%@", path);
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:path]) {
            NSData *data = [NSData dataWithContentsOfFile:path];
         
            NSDictionary *title = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *each = [title objectForKey:@"data"];
            NSArray *sum = [each objectForKey:@"promotions"];
            [self.titleArr removeAllObjects];

            for (NSDictionary *dic in sum) {
                TitleModel *model = [[TitleModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.titleArr addObject:model];
                [model release];
            }
            [self.table reloadData];
            [self setButton];
    }
}
}
#pragma mark - 
#pragma mark - 精选界面的每个cell的数据解析

// 精选界面的每个cell的数据解析
- (void)cellConnection
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"2" forKey:@"gender"];
    [dic setObject:@"2" forKey:@"generation"];
    [dic setObject:@"20" forKey:@"limit"];
    [dic setObject:@"0" forKey:@"offset"];
    
    NSString *judge = [Internet internetStatus];
    if ([judge isEqualToString:@"WiFi"]) {

    
    [AsynURLConnection asynWithURL:LWS_JXFQ parmaters:dic block:^(NSData *data) {
        
        NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *LibArr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [LibArr firstObject];
        path = [NSString stringWithFormat:@"%@/%@",path, @"Cell"];
        [data writeToFile:path atomically:YES];
        NSDictionary *dataDic = [root objectForKey:@"data"];
        NSArray *itemArr = [dataDic objectForKey:@"items"];
        [self.tableArr removeAllObjects];
        for (NSDictionary *dic in itemArr) {
            CellModel *model = [[CellModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.tableArr addObject:model];
            [model release];
        }
        [self.table reloadData];
        
    }];
    
    }else if ([judge isEqualToString:@"WWAN"]){
        [AsynURLConnection asynWithURL:LWS_JXFQ parmaters:dic block:^(NSData *data) {
            
            NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *LibArr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            NSString *path = [LibArr firstObject];
            path = [NSString stringWithFormat:@"%@/%@",path, @"Cell"];
            [data writeToFile:path atomically:YES];
            NSDictionary *dataDic = [root objectForKey:@"data"];
            NSArray *itemArr = [dataDic objectForKey:@"items"];
            [self.tableArr removeAllObjects];

            for (NSDictionary *dic in itemArr) {
                CellModel *model = [[CellModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.tableArr addObject:model];
                [model release];
            }
            [self.table reloadData];
            
        }];

        
    }else{
        NSArray *LibArr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [LibArr firstObject];
        path = [NSString stringWithFormat:@"%@/%@",path, @"Cell"];
        NSLog(@"%@", path);
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath:path]) {
            NSData *data = [NSData dataWithContentsOfFile:path];

            NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            

            NSDictionary *dataDic = [root objectForKey:@"data"];
            NSArray *itemArr = [dataDic objectForKey:@"items"];
            [self.tableArr removeAllObjects];

            for (NSDictionary *dic in itemArr) {
                CellModel *model = [[CellModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.tableArr addObject:model];
                [model release];
            }
            [self.table reloadData];
    }
}
}


// 向headerView 中传数据
- (void)setScrollValue
{
    DetailView *header = (DetailView *)self.table.tableHeaderView;
    [header setImageWithModel:self.scrollArr];
}
#pragma mark-
#pragma mark - // 向button 中传数据
// 向button 中传数据

- (void)setButton
{
    DetailView *header = (DetailView *)self.table.tableHeaderView;
    [header setButtonImageWithModel:self.titleArr];
}

- (void)createTableView
{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 80*OffHeight, self.contentView.frame.size.width, self.contentView.frame.size.height - 64) style:UITableViewStylePlain];
    self.table.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_table];
    _table.dataSource = self;
    _table.delegate = self;
    _table.rowHeight = 200 * OffHeight;
    [_table release];

    [self.scrollArr removeAllObjects];
    self.table.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self cellConnection];
        [self.table.header endRefreshing];
    }];
    self.table.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self.table.footer beginRefreshing];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"2" forKey:@"generation"];
         [dic setObject:@"2" forKey:@"gender"];
        [dic setObject:@"20" forKey:@"limit"];
        [dic setObject:@"20" forKey:@"offset"];
    [AsynURLConnection asynWithURL:LWS_JXFQ parmaters:dic block:^(NSData *data) {
                NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

                NSDictionary *dataDic = [root objectForKey:@"data"];
                NSArray *itemArr = [dataDic objectForKey:@"items"];
                for (NSDictionary *dic in itemArr) {
                    
                    CellModel *model = [[CellModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.tableArr addObject:model];
                    [model release];
                }
                [self.table reloadData];
                [self.table.footer endRefreshing];

        }];
        
    }];
#pragma mark-
#pragma mark - 创建headerview
    // 创建headerView
    DetailView *detail = [[DetailView alloc]initWithFrame:CGRectMake(0, 60, _table.frame.size.width, 250 * OffHeight)];
    [self.contentView addSubview:detail];
    _table.tableHeaderView = detail;
    detail.target = self;
    detail.action = @selector(buttonClick:);
    [detail release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail"];
    if (cell == nil) {
        cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detail"];
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    CellModel *model = [self.tableArr objectAtIndex:indexPath.row];
    NSString *str = model.cover_image_url;
    
     [cell.mainImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]];
    
    cell.titleLabel.text = model.title;
    
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 8 || indexPath.row == 9 || indexPath.row == 10 || indexPath.row == 18)
    {
        NSString *date = [NSString stringWithFormat:@"%@",model.published_at];
        
        NSDateFormatter *formatter = [[[NSDateFormatter alloc]init]autorelease];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"MM-dd"];
        NSDate *confromTime = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[date intValue]];
        NSString *confromtimeStr = [formatter stringFromDate:confromTime];
        cell.dateLabel.text = confromtimeStr;
        
    }
    
    if (indexPath.row == 0) {
        NSString *date = [NSString stringWithFormat:@"%@",model.updated_at];
        
        NSDateFormatter *formatter = [[[NSDateFormatter alloc]init]autorelease];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"HH:00"];
        NSDate *update = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[date intValue]];
        NSString *updateStr = [formatter stringFromDate:update];
        cell.updateLabel.text = [NSString stringWithFormat:@"下次更新%@",updateStr];
        cell.clockImage.image = [UIImage imageNamed:@"17.png"];
        
    }
    if ([model.likes_count integerValue] != 0) {

        NSString *count = [NSString stringWithFormat:@"%@", model.likes_count];
        cell.likeLabel.text = count;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellModel *model = [self.tableArr objectAtIndex:indexPath.row];

    [self.target performSelector:self.action withObject:model];
}
#pragma mark - 点击 按钮事件
- (void)buttonClick:(UIButton *)button
{
    if (button.tag == 1) {

    [[NSNotificationCenter defaultCenter] postNotificationName:@"KNOTIFIACTION" object:nil userInfo:nil];
        
    }else if (button.tag == 2){
         [[NSNotificationCenter defaultCenter] postNotificationName:@"KNOTIFIACTION1" object:nil userInfo:nil];
    }else if (button.tag == 3){

    
         [[NSNotificationCenter defaultCenter] postNotificationName:@"KNOTIFIACTION2" object:nil userInfo:nil];
    }else{

         [[NSNotificationCenter defaultCenter] postNotificationName:@"KNOTIFIACTION3" object:nil userInfo:nil];
    }
    
}
@end
