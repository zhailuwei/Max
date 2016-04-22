//
//  PresentView.m
//  GiftSpeak
//
//  Created by dllo on 15/8/22.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "PresentView.h"
#import "ToolViewController.h"
#import "DefineURL.h"
#import "AsynURLConnection.h"
#import "UIImageView+WebCache.h"
#import "HotModel.h"
#import "HotCell.h"
#import "ClickCell.h"
#import "ReHeight.pch"
#import "ItemViewController.h"

@interface PresentView () <UITableViewDataSource, UITableViewDelegate,ClickCellDelegate>

@property (nonatomic, retain) UITableView *table;        //左边滚动的tableView
@property (nonatomic, retain) NSMutableArray *tableArr;  //左边滚动的数组

@property(nonatomic, retain)NSMutableArray *heightArr;

@property (nonatomic, retain) UITableView *scrollTable;
@property (nonatomic, retain) NSMutableArray *scrollArr;  // 右边滚动的tableView
@property (nonatomic, retain) NSMutableArray *groupsArr;   //根据categories取出的数组





@end


@implementation PresentView

/**
 *  通过button点击下面切换界面的礼物自定义View
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
        
        self.heightArr = [NSMutableArray array];
        self.tableArr = [NSMutableArray array];
        
        self.scrollArr = [NSMutableArray array];
        [self myConnection];
        
        [self createButton];
        
        [self createScroll];
        
        [self createTableView];
        
    }
    
    return self;
}

- (void)myConnection
{
    [AsynURLConnection asynWithURL:LWS_Divide_Present_Hot parmaters:nil block:^(NSData *data) {
        [self.tableArr removeAllObjects];
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dict = [root objectForKey:@"data"];
        NSArray *array = [dict objectForKey:@"categories"];
        
        for (NSDictionary *dic in array) {

                HotModel *model = [[HotModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.tableArr addObject:model];
                [model release];
                
            }
        
        [self.table reloadData];
        
    }];
    
    
    [AsynURLConnection asynWithURL:LWS_Divide_Present_Hot parmaters:nil block:^(NSData *data) {
        
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dic = [root objectForKey:@"data"];
        self.groupsArr = [dic objectForKey:@"categories"];  // 取出四个字典及内容
        
        for (NSDictionary *dict in _groupsArr) {
            NSArray *arr = [dict objectForKey:@"subcategories"];
            NSMutableArray *arr2 = [NSMutableArray array];
            for (NSDictionary *each in arr) {
                
                HotModel *model = [[HotModel alloc]init];
                [model setValuesForKeysWithDictionary:each];
                NSLog(@"%@", model.name);
                [arr2 addObject:model];
                [model release];
                
            }
            [self.scrollArr addObject:arr2];  //scrollArr是四个大的数组,里面是不同数量的model
            
        }
        
        [self.scrollTable reloadData];
        
        
    }];

    
    
       
    
    
}

- (void)createButton
{
   
    self.titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.titleButton.frame = CGRectMake(20 * OffWidth, 5*OffHeight, 80 * OffWidth, 35 * OffHeight);
    [self.titleButton setTitle:@"选礼神器" forState:UIControlStateNormal];
    self.titleButton.backgroundColor = [UIColor clearColor];
    [self.titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_titleButton];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(5 * OffWidth, 10*OffHeight, 20 * OffWidth, 20 * OffHeight)];
    image.image = [UIImage imageNamed:@"6.png"];
    [self addSubview:image];
    [image release];
    
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeSystem];
    clickButton.backgroundColor = [UIColor whiteColor];
    [clickButton setBackgroundImage:[UIImage imageNamed:@"23.png"] forState:UIControlStateNormal];
    clickButton.frame = CGRectMake(350 * OffWidth, 10*OffHeight, 20 * OffWidth, 15 * OffHeight);
    [clickButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clickButton];
    
    
    
}


- (void)createScroll
{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 40 * OffHeight, 80 * OffWidth, self.frame.size.height) style:UITableViewStylePlain];
    self.table.backgroundColor = [UIColor whiteColor];
    [self addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    _table.rowHeight = 50 * OffHeight;
    [_table release];
    
}

- (void)createTableView
{
    self.scrollTable = [[UITableView alloc]initWithFrame:CGRectMake(80 * OffWidth, 40 * OffHeight, (self.frame.size.width - 80) * OffWidth, self.frame.size.height) style:UITableViewStylePlain];
    self.scrollTable.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scrollTable];
    _scrollTable.dataSource = self;
    _scrollTable.delegate = self;
    _scrollTable.rowHeight = 600 * OffHeight;
    [_scrollTable release];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.table) {
        
        HotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hot"];
        if (cell == nil) {
            cell = [[[HotCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hot"]autorelease];
        }
        if(_tableArr.count != 0){
        HotModel *model = [self.tableArr objectAtIndex:indexPath.row];
        [cell.scrollButton setTitle:model.name forState:UIControlStateNormal];
        cell.scrollButton.tag = indexPath.row + 1;
        [cell.scrollButton addTarget:self action:@selector(scrollButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else if (tableView == self.scrollTable){
        
        ClickCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil) {
            cell = [[ClickCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;

        }
        
        NSString *str = [[self.groupsArr objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.titleLabel.text = str;
        
        cell.collectArr = [NSMutableArray arrayWithArray:self.scrollArr[indexPath.row]];
        
        cell.delegate = self;
        return cell;
        
    }
    else{
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.table) {
        
        return 50 * OffHeight;
    }else if (tableView == self.scrollTable){
        NSArray *arr = self.scrollArr[indexPath.row];
        
        CGFloat height = (((arr.count + 3) / 3) * 100) * OffHeight;
        NSString *str = [NSString stringWithFormat:@"%lf",height];
        [_heightArr addObject:str];
        
        return height;

    }else{
        return 100 * OffHeight;
    }
}

- (void)buttonClick:(UIButton *)button
{
    ToolViewController *tool = [[ToolViewController alloc]init];
    tool.tool = self.tool;
    [self addSubview:tool.view];
    
}

/**
 *  当tableView滚动时,zuoce跟着滚动
 *
 *  @param button 左侧tableViewcell里的button
 */
- (void)scrollButtonAction:(UIButton *)button
{
    NSArray *arr = self.scrollArr[button.tag - 1];

    NSLog(@"arr.count = %lu", (unsigned long)arr.count);
    CGFloat he = 0;
    for (int i = 0; i < button.tag-1; i++) {
        CGFloat h = [[_heightArr objectAtIndex:i] floatValue];
        he += h;
        
    }
    _scrollTable.contentOffset = CGPointMake(0, he);
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat  lon= _scrollTable.contentOffset.y ;
    CGFloat h = 0;
    NSInteger k = 0;
    for (int i = 0; i < 17; i++) {
        
        if (lon >=  h) {
            h += [[_heightArr objectAtIndex:i]floatValue];
            k = i;
        }
    }
    _table.contentOffset = CGPointMake(0, k * 50);
   

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        if (tableView == self.table) {
         NSArray *arr = self.scrollArr[indexPath.row];
        _scrollTable.contentOffset = CGPointMake(0, ((arr.count *(arr.count + 1) / 2 + 3) / 3) * 100);
        
    }
}

//将button的id值传到ItemViewController中
- (void)sendMessage:(NSNumber *)ID
{
    ItemViewController *item = [[ItemViewController alloc]init];
    item.numID = ID;
    [self addSubview:item.view];
}






@end
