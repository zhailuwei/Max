//
//  ShopViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/8/28.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopCell.h"
#import "AsynURLConnection.h"
#import "DefineURL.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "DetailModel.h"
#import "ReHeight.pch"

@interface ShopViewController ()  <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSMutableArray *tableArr;
@property (nonatomic, retain) NSMutableArray *imageArr;
@property (nonatomic, retain) NSMutableArray *arrat;   //将图片分成四个一组后放入的数组

@end

@implementation ShopViewController

/**
 *  好店推荐的详情界面
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
        self.imageArr = [NSMutableArray array];
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.title = @"品牌专区";
    
    [self myConnection];
    
    [self createTable];
    
    
}

- (void)myConnection
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"20" forKey:@"limit"];
    [dic setObject:@"0" forKey:@"offset"];
    
    [AsynURLConnection asynWithURL:LWS_JXBT_Shop parmaters:dic block:^(NSData *data) {
        [self.tableArr removeAllObjects];
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
          NSDictionary *dict = [root objectForKey:@"data"];
        NSArray *array = [dict objectForKey:@"brands"];
            for (NSDictionary *dic in array) {
            DetailModel *model = [[DetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            NSArray *arr = [dic objectForKey:@"image_urls"];
            [self.imageArr addObjectsFromArray:arr];
            [self.tableArr addObject:model];
            [model release];
        }
        
        [self.table reloadData];
        
    }];
   
}

- (void)createTable
{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height - 64) * OffHeight) style:UITableViewStylePlain];
    self.table.backgroundColor = [UIColor whiteColor];
    _table.dataSource = self;
    _table.delegate = self;
    _table.rowHeight = 170 * OffHeight;
    [self.view addSubview:_table];
    [_table release];
    self.table.allowsSelection = NO;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shop"];
    if (cell == nil) {
        cell = [[ShopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shop"];
    }
    
    DetailModel *model = [self.tableArr objectAtIndex:indexPath.row];
        
    [cell.topImage sd_setImageWithURL:[NSURL URLWithString:model.icon_url] placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]];
    
    cell.titleLabel.text = model.name;
    
    cell.smallTitleLabel.text = model.desc;
    cell.selected = UITableViewCellAccessoryNone;
//    cell.backgroundColor = [UIColor redColor];
    self.arrat = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray array];

    /**
     *  将图片数组分成五个一组,然后将数组用方法传到cell中赋值
     */
    for (int i = 0; i < _imageArr.count; i++) {
        if (i % 5 == 0  ) {
            [self.arrat addObject:array];
            array = [NSMutableArray array];
            
        }
        
        [array addObject:_imageArr[i]];
    }
    
    
   [cell passValue:[self.arrat objectAtIndex:indexPath.row]];

    NSArray *arr = [self.arrat objectAtIndex:indexPath.row];
    NSString *str = [arr firstObject];
    [cell.bigImage sd_setImageWithURL:[NSURL URLWithString:str]];
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
