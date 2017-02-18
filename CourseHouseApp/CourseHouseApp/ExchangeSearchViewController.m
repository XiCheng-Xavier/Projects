//
//  ExchangeSearchViewController.m
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-23.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "ExchangeSearchViewController.h"

@interface ExchangeSearchViewController ()

@end

@implementation ExchangeSearchViewController
@synthesize searchTextField;
@synthesize searchButton;
@synthesize cityChooseButton;
@synthesize label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置组件属性
    //设置搜索按钮
    searchButton.layer.borderColor = [[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1] CGColor];
    [searchButton.layer setMasksToBounds:YES];
    [searchButton.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
    [searchButton.layer setBorderWidth:1.0]; //边框宽度
    //设置框架
    label.layer.borderColor = [[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1] CGColor];
    [label.layer setMasksToBounds:YES];
    [label.layer setCornerRadius:4.0]; //设置矩形四个圆角半径
    [label.layer setBorderWidth:2.0]; //边框宽度
    
    UITapGestureRecognizer *singleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:singleTouch];
}

-(IBAction)searchButtonClicked:(id)sender
{
    if ([searchTextField.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请输入搜索内容" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }else
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"exchangeSearch" object:searchTextField.text];
    }
    
}

-(void)dismissKeyboard:(id)sender{
    [searchTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
