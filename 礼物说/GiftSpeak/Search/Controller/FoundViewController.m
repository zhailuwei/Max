//
//  FoundViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/9/5.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "FoundViewController.h"
#import "AsynURLConnection.h"
#import "DefineURL.h"
#import "TextCell.h"
#import "TextModel.h"
#import "UIImageView+WebCache.h"
#import "ReHeight.pch"


@interface FoundViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) UICollectionView *collect;
@property (nonatomic, retain) NSMutableArray *collectArr;
@property (nonatomic, retain) NSMutableArray *array;

@end

@implementation FoundViewController

/**
 *  点击搜索后进入的搜索界面
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
    
    [self myConnection];
    
    [self createCollect];
    
}

- (void)myConnection
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_searchtext forKey:@"keyword"];
    [dic setObject:@"20" forKey:@"limit"];
    [dic setObject:@"0" forKey:@"offset"];
    [dic setObject:@"" forKey:@"sort"];
    
    [AsynURLConnection asynWithURL:LWS_Search parmaters:dic block:^(NSData *data) {
        [self.collectArr removeAllObjects];
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dict = [root objectForKey:@"data"];
        NSArray *array = [dict objectForKey:@"items"];
        
        NSMutableArray *arr = [NSMutableArray array];
        if ([array isEqualToArray:arr]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有找到相关产品" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
        for (NSDictionary *dic in array) {
            TextModel *model = [[TextModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.collectArr addObject:model];
            [model release];
        }
        
        [self.collect reloadData];
        
        
    }];
    
    
}




- (void)createCollect
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(170 * OffWidth, 150 * OffHeight);
    layout.minimumInteritemSpacing = 10 * OffHeight;
    layout.minimumLineSpacing = 10 * OffWidth;
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    
    self.collect.backgroundColor = [UIColor whiteColor];
    _collect.dataSource = self;
    _collect.delegate = self;
    [self.view addSubview:_collect];
    
    [_collect registerClass:[TextCell class] forCellWithReuseIdentifier:@"text"];
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"text" forIndexPath:indexPath];
    
    TextModel *model = [self.collectArr objectAtIndex:indexPath.item];    
    
     [cell.mainImage sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]];
    
    NSString *string = [NSString stringWithFormat:@"%@", model.likes_count];
    cell.likeLabel.text = string;
    cell.moneyLabel.text = model.price;
    
    cell.text = self.searchtext;
    
    NSMutableAttributedString *dataStr = [cell colorData:model.name];
    cell.titleLabel.attributedText = dataStr;
    
    
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
