//
//  SecondCell.m
//  GiftSpeak
//
//  Created by dllo on 15/9/1.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SecondCell.h"
#import "ClothCell.h"
#import "ClothModel.h"
#import "AsynURLConnection.h"
#import "DefineURL.h"
#import "UIImageView+WebCache.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"
#import "ReHeight.pch"
@interface SecondCell () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSMutableArray *tableArr;

@end
@implementation SecondCell

/**
 *  穿搭cell(铺tableView)
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
        
        [self myConnection];
        [self createTableView];
    }
    return self;
}


- (void)myConnection
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"20" forKey:@"limit"];
    [dic setObject:@"0" forKey:@"offset"];
    
    [AsynURLConnection asynWithURL:LWS_Cloth parmaters:dic block:^(NSData *data) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *root = [dict objectForKey:@"data"];
        NSArray *array = [root objectForKey:@"items"];
        [self.tableArr removeAllObjects];
        for (NSDictionary *dic in array) {
            ClothModel *model = [[ClothModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.tableArr addObject:model];
            [model release];
        }
        [self.table reloadData];
    }];
}
- (void)createTableView
{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64*OffHeight, self.contentView.frame.size.width, self.contentView.frame.size.height) style:UITableViewStylePlain];
    self.table.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_table];
    _table.dataSource = self;
    _table.delegate = self;
    _table.rowHeight = 170 * OffHeight;
    [_table release];
    self.table.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.table.header beginRefreshing];
        [self myConnection];
    }];
    self.table.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.table.footer beginRefreshing];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"20" forKey:@"limit"];
        [dic setObject:@"20" forKey:@"offset"];
        [AsynURLConnection asynWithURL:LWS_Cloth parmaters:dic block:^(NSData *data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *root = [dict objectForKey:@"data"];
            NSArray *array = [root objectForKey:@"items"];
            for (NSDictionary *dic in array) {
                ClothModel *model = [[ClothModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.tableArr addObject:model];
                [model release];
            }
            [self.table reloadData];
            [self.table.footer endRefreshing];
        }];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClothCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cloth"];
    if (cell == nil) {
        cell = [[ClothCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cloth"];
    }
    ClothModel *model = [self.tableArr objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellAccessoryNone;
     [cell.mainImage sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]];
    NSString *string = [NSString stringWithFormat:@"%@", model.likes_count];
    cell.likeLabel.text = string;
    cell.titleLabel.text = model.title;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClothModel *model = [self.tableArr objectAtIndex:indexPath.row];
    [self.target performSelector:self.action withObject:model.url];
}
@end
