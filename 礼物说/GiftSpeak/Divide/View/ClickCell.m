//
//  ClickCell.m
//  GiftSpeak
//
//  Created by dllo on 15/8/31.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ClickCell.h"
#import "UIButton+WebCache.h"
#import "HotModel.h"
#import "MyButtonOfDivide.h"
#import "CollectionViewCell.h"
#import "ReHeight.pch"
#import "ClickCell.h"

@interface ClickCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@end

@implementation ClickCell

/**
 *  分类界面中礼物界面的右侧滚动tableView的cell
 */


- (void)dealloc
{
    [_collect release];
    [_collectArr release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView setBackgroundColor:[UIColor grayColor]];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(80 * OffWidth, 80 * OffHeight);
        layout.minimumInteritemSpacing = 10 * OffWidth;
        self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, ([[UIScreen mainScreen] bounds].size.width - 80) * OffWidth,(_collectArr.count * 90) * OffHeight) collectionViewLayout:layout];
        self.collect.backgroundColor = [UIColor whiteColor];
        _collect.dataSource = self;
        _collect.delegate = self;
        [self.contentView addSubview:_collect];
        [_collect release];
        
        
        [_collect registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"click1"];
        
    }
    return self;
}
-(void)setCollectArr:(NSMutableArray *)collectArr
{
    if (_collectArr != collectArr) {
        [_collectArr release];
        _collectArr = [collectArr retain];

        
        [_collect setFrame:CGRectMake(0,0, ([[UIScreen mainScreen] bounds].size.width - 80) * OffWidth,((((_collectArr.count + 3) / 3)  * 100) * OffHeight))];
        
    }
    [self.collect reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"click1" forIndexPath:indexPath];
    
       
    HotModel *model = [self.collectArr objectAtIndex:indexPath.item];
    
    [cell.imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.icon_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ZhanWei.jpg"]];
    
    
    [cell.imageButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.imageButton.lid = model.id;
    
    
    cell.buttonLabel.text = model.name;
    
    return cell;
    
}


- (void)buttonAction:(MyButtonOfDivide *)button
{

    [self.delegate sendMessage:button.lid];
    
    
}

//将button的id值传到PresentView中
- (void)sendMessage:(NSNumber *)ID
{
    [self.delegate sendMessage:ID];
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
