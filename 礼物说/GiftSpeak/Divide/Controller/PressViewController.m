//
//  PressViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/8/31.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "PressViewController.h"
#import "AsynURLConnection.h"
#import "DefineURL.h"
#import "UIImageView+WebCache.h"
#import "StyleModel.h"
#import "PressCell.h"
#import "ReHeight.pch"


@interface PressViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSMutableArray *tableArr;

@end

@implementation PressViewController

/**
 *  分类界面的攻略界面下面每一个小按钮点进去的界面
 */


- (void)dealloc
{
    [_table release];
    [_tableArr release];
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tableArr = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self myConnection];
    
    [self createTableView];
}


- (void)myConnection
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"20" forKey:@"limit"];
    [dic setObject:@"0" forKey:@"offset"];
    
    NSString *urlStr = [LWS_Divide_GL stringByReplacingOccurrencesOfString:@"110" withString:[NSString stringWithFormat:@"%@", self.numID]];
    
    [AsynURLConnection asynWithURL:urlStr parmaters:dic block:^(NSData *data) {
        
        [self.tableArr removeAllObjects];
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dict = [root objectForKey:@"data"];
        NSArray *itemArr = [dict objectForKey:@"items"];
        
        for (NSDictionary *dic in itemArr) {
            StyleModel *model = [[StyleModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.tableArr addObject:model];
            [model release];
        }
        [self.table reloadData];
        
    }];
    
}

- (void)createTableView
{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.table.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_table];
    _table.dataSource = self;
    _table.delegate = self;
    _table.rowHeight = 170 * OffHeight;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_table release];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"press"];
    if (cell == nil) {
        cell = [[PressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"press"];
    }
    
    StyleModel *model = [self.tableArr objectAtIndex:indexPath.row];
        
    [cell.mainImage sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]];
    
    NSString *str = [NSString stringWithFormat:@"%@", model.likes_count];
    cell.likeLabel.text = str;
    
    cell.titleLabel.text = model.title;
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    return cell;
    
    
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
