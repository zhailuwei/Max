//
//  QixiViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/8/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "QixiViewController.h"
#import "QixiCell.h"
#import "QIxiModel.h"
#import "AsynURLConnection.h"
#import "DefineURL.h"
#import "UIImageView+WebCache.h"
#import "ReHeight.pch"

@interface QixiViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSMutableArray *tableArr;

@end

@implementation QixiViewController


/**
 *  分类界面的攻略中的七夕礼物合辑详情界面
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
    
    [self myConnection];
    [self createTable];
}


- (void)myConnection
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"2" forKey:@"gender"];
    [dic setObject:@"2" forKey:@"generation"];
    [dic setObject:@"20" forKey:@"limit"];
    [dic setObject:@"0" forKey:@"offset"];
    
    [AsynURLConnection asynWithURL:LWS_Divide_HJ parmaters:dic block:^(NSData *data) {
        [self.tableArr removeAllObjects];
        
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dict = [root objectForKey:@"data"];
        NSArray *array = [dict objectForKey:@"posts"];
        
        for (NSDictionary *dic in array) {
            QIxiModel *model = [[QIxiModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.tableArr addObject:model];
            [model release];
        }
        [self.table reloadData];
        
    }];
    
}


- (void)createTable
{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.height ) style:UITableViewStylePlain];
    self.table.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_table];
    _table.dataSource = self;
    _table.delegate = self;
    _table.rowHeight = 160 * OffHeight;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QixiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qixi"];
    if (cell == nil) {
        cell = [[QixiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"qixi"];
    }
    QIxiModel *model = [self.tableArr objectAtIndex:indexPath.row];
        
    [cell.mainImage sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]];
    
    NSString *string = [NSString stringWithFormat:@"%@", model.likes_count];
    cell.likeLabel.text = string;
    
    cell.titleLabel.text = model.title;
    
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
