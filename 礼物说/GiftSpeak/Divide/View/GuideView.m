//
//  GuideView.m
//  GiftSpeak
//
//  Created by dllo on 15/8/22.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "GuideView.h"
#import "DivideButton.h"
#import "DivideCell.h"
#import "DivideModel.h"
#import "AsynURLConnection.h"
#import "DefineURL.h"
#import "UIButton+WebCache.h"
#import "CellModel.h"
#import "CellView.h"
#import "StyleCell.h"
#import "StyleModel.h"
#import "WejuViewController.h"
#import "QixiViewController.h"
#import "SearchViewController.h"
#import "ReHeight.pch"


@interface GuideView () <UITableViewDataSource, UITableViewDelegate,StyleCellDelegate>

@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSMutableArray *tableArr;    //必备文具的数组
@property (nonatomic, retain) NSMutableArray *GiftArr;     //七夕礼物数组
@property (nonatomic, retain) NSMutableArray *cellArr;     //每个cell的数组
@property (nonatomic, retain) NSMutableDictionary *dataDic;   // 必备文具字典
@property (nonatomic, retain) NSMutableDictionary *rootDic;   //七夕礼物合辑字典

@property (nonatomic, retain) NSMutableArray *channelArr;   //每个channel数组

@property (nonatomic, retain) NSMutableArray *groupsArr;    //根据channel_groups得到的数组

@end

@implementation GuideView

// 通过button点击下面切换界面的攻略自定义View

- (void)dealloc
{
    [_table release];
    [_tableArr release];
    [_dataDic release];
    [_GiftArr release];
    
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableArr = [NSMutableArray array];
        
       
        self.GiftArr = [NSMutableArray array];
        
        self.cellArr = [NSMutableArray array];
        
        self.channelArr = [NSMutableArray array];
        
        self.dataDic = [NSMutableDictionary dictionary];
        
        self.rootDic = [NSMutableDictionary dictionary];
        
        self.groupsArr = [NSMutableArray array];
        
        [self myConnection];
        
        [self createTableView];

        
    }
    return self;
}

- (void)myConnection
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"2" forKey:@"gender"];
    [dic setObject:@"2" forKey:@"generation"];
    [dic setObject:@"20" forKey:@"limit"];
    [dic setObject:@"0" forKey:@"offset"];
    
    [AsynURLConnection asynWithURL:LWS_Divide_WJ parmaters:dic block:^(NSData *data) {
        [self.tableArr removeAllObjects];
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.dataDic = [root objectForKey:@"data"];
        NSArray *array = [_dataDic objectForKey:@"posts"];
        
        for (NSDictionary *dic in array) {
            DivideModel *model = [[DivideModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.tableArr addObject:model];
            [model release];
            
        }
        [self.table reloadData];
    }];
    [AsynURLConnection asynWithURL:LWS_Divide_HJ parmaters:dic block:^(NSData *data) {
        
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.rootDic = [root objectForKey:@"data"];
        NSArray *array = [_dataDic objectForKey:@"posts"];
        
        for (NSDictionary *dic in array) {
            DivideModel *model = [[DivideModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.GiftArr addObject:model];
            [model release];
            
        }
        [self.table reloadData];
        
        
    }];
    
    
    [AsynURLConnection asynWithURL:LWS_Divide_Cell parmaters:nil block:^(NSData *data) {
        
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dic = [root objectForKey:@"data"];
        self.groupsArr = [dic objectForKey:@"channel_groups"];  // 取出四个字典及内容
        
        for (NSDictionary *dict in _groupsArr) {
           NSArray *arr = [dict objectForKey:@"channels"];
            NSMutableArray *arr2 = [NSMutableArray array];
            for (NSDictionary *each in arr) {
                
                StyleModel *model = [[StyleModel alloc]init];
                [model setValuesForKeysWithDictionary:each];
                NSLog(@"%@", model.name);
                [arr2 addObject:model];
                [model release];
                
            }
            [self.cellArr addObject:arr2];  //cellArr是四个大的数组,里面是不同数量的model

        }
        
        [self.table reloadData];
        
        
    }];
    
        
}

- (void)createTableView
{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    
    self.table.backgroundColor = [UIColor whiteColor];
    _table.dataSource = self;
    _table.delegate = self;
    [self addSubview:_table];
    _table.rowHeight = 250 * OffHeight;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_table release];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_cellArr.count == 0) {
        return 0;
    }
    if (section == 0) {
        return 1;
    }else{
        return self.groupsArr.count;
    }
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  分类界面上方必备文具等
     */
    if (indexPath.section == 0) {
        DivideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"divide"];
    if (cell == nil) {
        cell = [[DivideCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"divide"];
    }
    
    NSString *string = [self.dataDic objectForKey:@"banner_image_url"];
        [cell.leftButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]
];
    
    NSString *str = [self.rootDic objectForKey:@"banner_image_url"];
    [cell.rightButton sd_setBackgroundImageWithURL:[NSURL URLWithString:str ] forState:UIControlStateNormal  placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]
];
        
    [cell.leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.searchButton addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
    }else {

        /**
         *  分类界面下方的每个cell(品类等)
         */
        
        StyleCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
        if (cell == nil) {
            cell = [[StyleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
            
            cell.arr = self.cellArr[indexPath.row];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
        
       NSString *str = [[self.groupsArr objectAtIndex:indexPath.row] objectForKey:@"name"];
       cell.titleLabel.text = str;
        //把 每一个含不同model数的数组传到自定义cell中
       cell.delegate = self;

       return cell;
        
        
    }
        
        
}

// 协议回调(将每个小按钮的id值传到DivideViewController)
-(void)passValue:(NSNumber *)ID
{
    [self.delegate passValue:ID];
  
}

- (void)leftClick:(DivideButton *)button
{

    WejuViewController *wenju = [[WejuViewController alloc]init];
    wenju.divide = self.divide;
    [self addSubview:wenju.view];
    
}

- (void)rightClick:(id)sender
{
    
    QixiViewController *qixi = [[QixiViewController alloc]init];
    qixi.divide = self.divide;
    [self addSubview:qixi.view];
    
    
}

- (void)searchClick:(id)sender
{
    SearchViewController *search = [[SearchViewController alloc]init];
    [self addSubview:search.view];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150 * OffHeight;
    }else{
        NSArray *arr = self.cellArr[indexPath.row];
        return ((arr.count + 3) / 5 * 90 + 70) * OffHeight;
    }
}








@end
