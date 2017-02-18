//
//  MineViewController.m
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-19.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController
@synthesize sayHelloTextView;
@synthesize registerButton;
@synthesize loginButton;
@synthesize gridCollectButton;
@synthesize cardsbagButton;
@synthesize searchHistoryButton;
@synthesize myOrderButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, 320, 50)];
    [self.view setFrame:CGRectMake(0, -14, 320,568)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置navigationBar字体大小、颜色
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    //设置navigationBar背景色
    [self.navigationController.navigationBar setBarTintColor: [UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1]];
    [self.navigationController.navigationBar setTranslucent:NO];//设置不透明
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; // 其上默认按钮（比如返回按钮）颜色
    //设置textView
    sayHelloTextView.text = @"\r\n                                      晚上好！\r\n                 不知不觉夜已深，朋友请注意休息";
    sayHelloTextView.font =[UIFont systemFontOfSize:12];
    [sayHelloTextView setEditable:NO];
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
