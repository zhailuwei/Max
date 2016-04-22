//
//  ItemViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/9/9.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ItemViewController.h"
#import "ReHeight.pch"
#import "ItemCell.h"
#import "ItemModel.h"
#import "AsynURLConnection.h"
#import "DefineURL.h"
#import "UIButton+WebCache.h"

@interface ItemViewController ()  <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *collect;
@property (nonatomic, retain) NSMutableArray *collectArr;

@end

@implementation ItemViewController
/**
 *  分类界面的礼物界面的每个小按钮点进去的界面
 */

- (void)dealloc
{
    [_collect release];
    [_collectArr release];
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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createConnection];
    
    [self createCollection];
    
}


- (void)createConnection
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"20" forKey:@"limit"];
    [dic setObject:@"20" forKey:@"offset"];
    
    NSString *urlStr = [LWS_Divide_Present_Item stringByReplacingOccurrencesOfString:@"19" withString:[NSString stringWithFormat:@"%@", self.numID]];
    
    [AsynURLConnection asynWithURL:urlStr parmaters:dic block:^(NSData *data) {
        
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dict = [root objectForKey:@"data"];
        NSArray *array = [dict objectForKey:@"items"];
        
        for (NSDictionary *dic in array) {
            ItemModel *model = [[ItemModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.collectArr addObject:model];
            [model release];
            NSLog(@"%@", self.collectArr);
        }
        [self.collect reloadData];
        
        
        
    }];
    
    
    
}

- (void)createCollection
{
   
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(180 * OffWidth, 150 * OffHeight);
        layout.minimumInteritemSpacing = 10 * OffWidth;
        self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height - 64) * OffHeight) collectionViewLayout:layout];
        _collect.backgroundColor = [UIColor whiteColor];
        _collect.delegate = self;
        _collect.dataSource = self;
        [self.view addSubview:_collect];
        
        [_collect registerClass:[ItemCell class] forCellWithReuseIdentifier:@"item"];
        [_collect release];
        

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectArr.count ;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    
    ItemModel *model = [self.collectArr objectAtIndex:indexPath.item];
    
    [cell.imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.cover_image_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]
     ];
    
    cell.titleLabel.text = model.name;
    
    cell.moneyLabel.text = model.price;
    
    NSString *string = [NSString stringWithFormat:@"%@", model.favorites_count];
    cell.likeLabel.text = string;
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
