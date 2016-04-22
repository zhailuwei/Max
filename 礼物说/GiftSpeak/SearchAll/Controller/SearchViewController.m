//
//  SearchViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/8/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCell.h"
#import "SearchModel.h"
#import "AsynURLConnection.h"
#import "DefineURL.h"
#import "UIImageView+WebCache.h"
#import "ReHeight.pch"

@interface SearchViewController ()  <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSMutableArray *tableArr;

@end

@implementation SearchViewController



/**
 *  分类界面的攻略中得查看全部界面
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self myConnection];
    
    [self createtable];
}

- (void)myConnection
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"6" forKey:@"limit"];
    [dic setObject:@"0" forKey:@"offset"];
    
    [AsynURLConnection asynWithURL:LWS_Divide_SearchAll parmaters:dic block:^(NSData *data) {
        
        [self.tableArr removeAllObjects];
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dict = [root objectForKey:@"data"];
        NSArray *array = [dict objectForKey:@"collections"];
        
        for (NSDictionary *dic in array) {
            SearchModel *model = [[SearchModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.tableArr addObject:model];
            [model release];
        }
        [self.table reloadData];
        
    }];
    
    
    
}

- (void)createtable
{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height - 64) * OffHeight) style:UITableViewStylePlain];
    self.table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_table];
    _table.dataSource = self;
    _table.delegate = self;
    _table.rowHeight = 150 * OffHeight;
    [_table release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"search"];
    if (cell == nil) {
        cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"search"];
    }
    
    SearchModel *model = [self.tableArr objectAtIndex:indexPath.row];
    
    [cell.mainImage sd_setImageWithURL:[NSURL URLWithString:model.banner_image_url] placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]];
    
    cell.shortTitleLabel.text = model.title;
    
    cell.titleLabel.text = model.subtitle;
    
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
