//
//  ClickViewController.m
//  GiftSpeak
//
//  Created by dllo on 15/8/31.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ClickViewController.h"
#import "DefineURL.h"
#import "ReHeight.pch"
#import "GiftDataBase.h"
#import "CellModel.h"
#import "SaveModel.h"
@interface ClickViewController ()

@end

@implementation ClickViewController

/**
 *  精选界面的每个cell点进去的内容
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"攻略详情";

    
    [self createWebView];
    [self createButton];
}

- (void)createWebView
{
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height - 100) * OffHeight)];
    webview.backgroundColor = [UIColor whiteColor];

    NSURL *url = [NSURL URLWithString:_model.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
    webview.scalesPageToFit = YES;
    [self.view addSubview:webview];
    [webview release];
    
    
}

- (void)createButton
{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height - 100) * OffHeight , self.view.frame.size.width, 100 * OffHeight)];
    label.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    NSArray *arr = [GiftDataBase selectAll];
    if ([arr isEqual:[NSNull null]]) {
        
        UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];

        saveButton.frame = CGRectMake(250 * OffWidth, (self.view.frame.size.height - 100) * OffHeight, 30 * OffWidth, 30 * OffHeight);
        saveButton.backgroundColor = [UIColor clearColor];
        [saveButton setBackgroundImage:[UIImage imageNamed:@"4.png"] forState:UIControlStateNormal];
        [saveButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:saveButton];
        

        UILabel *saveLabel = [[UILabel alloc]initWithFrame:CGRectMake(290 * OffWidth, (self.view.frame.size.height - 100) * OffHeight, 60 * OffWidth, 30 * OffHeight)];
        
        saveLabel.text = @"喜欢";
        saveLabel.textColor = [UIColor redColor];
        [self.view addSubview:saveLabel];
    }else
    {
        SaveModel *model = [GiftDataBase selectWith:_model.url];
        if (model) {
            UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
            saveButton.frame = CGRectMake(250 * OffWidth, (self.view.frame.size.height - 100) * OffHeight, 30 * OffWidth, 30 * OffHeight);
            saveButton.backgroundColor = [UIColor clearColor];
            [saveButton setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
            [saveButton addTarget:self action:@selector(buttonClic:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:saveButton];
            
            UILabel *saveLabel = [[UILabel alloc]initWithFrame:CGRectMake(290 * OffWidth, (self.view.frame.size.height - 100) * OffHeight, 60 * OffWidth, 30 * OffHeight)];
            saveLabel.text = @"喜欢";
            saveLabel.textColor = [UIColor redColor];
            [self.view addSubview:saveLabel];
            
        }else
        {
            UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
            saveButton.frame = CGRectMake(250 * OffWidth, (self.view.frame.size.height - 100) * OffHeight, 30 * OffWidth, 30 * OffHeight);
            saveButton.backgroundColor = [UIColor clearColor];
            [saveButton setBackgroundImage:[UIImage imageNamed:@"4.png"] forState:UIControlStateNormal];
            [saveButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:saveButton];
            
            UILabel *saveLabel = [[UILabel alloc]initWithFrame:CGRectMake(290 * OffWidth, (self.view.frame.size.height - 100) * OffHeight, 60 * OffWidth, 30 * OffHeight)];
            saveLabel.text = @"喜欢";
            saveLabel.textColor = [UIColor redColor];
            [self.view addSubview:saveLabel];
       
        }
        
        
   
    }
    
    

    
}


- (void)buttonClick:(UIButton *)button
{
    button.selected = !button.selected;
    if ([button isSelected] == YES) {
        
        [button setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
        
        SaveModel *model = [[SaveModel alloc]init];
        model.url = self.model.url;
        model.cover_image_url = self.model.cover_image_url;
        model.title = self.model.title;
        
        [GiftDataBase insertWithModel:model];
    }else if(button.selected == NO)
    {
         [button setBackgroundImage:[UIImage imageNamed:@"4.png"] forState:UIControlStateNormal];
        SaveModel *model = [[SaveModel alloc]init];
        model.url = self.model.url;
        model.cover_image_url = self.model.cover_image_url;
        model.title = self.model.title;
        [GiftDataBase deleteWithCityModel1:model];

   
    }
    
}
- (void)buttonClic:(UIButton *)button
{
    button.selected = !button.selected;
    if ([button isSelected] == YES) {
        
        [button setBackgroundImage:[UIImage imageNamed:@"4.png"] forState:UIControlStateNormal];
        
        SaveModel *model = [[SaveModel alloc]init];
        model.url = self.model.url;
        model.cover_image_url = self.model.cover_image_url;
        model.title = self.model.title;
        [GiftDataBase deleteWithCityModel1:model];
       
    }else if(button.selected == NO)
    {
        [button setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
        SaveModel *model = [[SaveModel alloc]init];
        model.url = self.model.url;
        model.cover_image_url = self.model.cover_image_url;
        model.title = self.model.title;
        
        [GiftDataBase insertWithModel:model];
        
        
    }
    

    
}
- (void)buyClick:(UIButton *)button
{
    NSLog(@"去购买");
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
