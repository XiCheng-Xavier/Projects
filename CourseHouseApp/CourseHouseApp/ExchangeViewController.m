//
//  ExchangeViewController.m
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-22.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "ExchangeViewController.h"

@interface ExchangeViewController ()

@end

@implementation ExchangeViewController
@synthesize searchButton;
@synthesize shakeButton;
@synthesize shakeViewController;
@synthesize searchViewController;


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
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    shakeViewController = [story instantiateViewControllerWithIdentifier:@"shake"];
    searchViewController = [story instantiateViewControllerWithIdentifier:@"search"];
    [self.view insertSubview:searchViewController.view atIndex:0];
    [self addChildViewController:shakeViewController];
    [shakeViewController didMoveToParentViewController:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSearchResult:) name:@"exchangeSearch" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailWebView:) name:@"toDetailWebView" object:nil];
}

//搜索结果列表
-(void)showSearchResult:(NSNotification *)notification
{
//    NSString *text = [notification object];
//
//    
//    resultController.keyWord = text;
//    resultController.frontTag = @"notification";
//    [searchViewController.view removeFromSuperview];
//    [resultController.view setFrame:CGRectMake(0, 57, 320, 374)];
//    [self.view insertSubview:resultController.view atIndex:0];
//    UIButton *returnButton = [self insertButton];
//    [returnButton addTarget:self action:@selector(returnToSearchView:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:returnButton];

}

//商品详细资料网页
-(void)showDetailWebView:(NSNotification *)notification
{
//    NSString *webURL = [notification object];
//    detailController.loadURL = webURL;
//    [detailController.view setFrame:CGRectMake(0, 57, 320, 374)];
//    [resultController.view removeFromSuperview];
//    [self.view insertSubview:detailController.view atIndex:0];
//    UIButton *returnButton = [self insertButton];
//    [returnButton addTarget:self action:@selector(returnToResultView:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:returnButton];
}
//-(void)returnToSearchView:(id)sender
//{
//    UIButton *tempButton =(UIButton *)sender;
//    [resultController.view removeFromSuperview];
//    [self.view insertSubview:searchViewController.view atIndex:0];
//    [tempButton removeFromSuperview];
//}
//
//-(void)returnToResultView:(id)sender
//{
//    UIButton *tempButton =(UIButton *)sender;
//    [detailController.view removeFromSuperview];
//    [self.view insertSubview:resultController.view atIndex:0];
//    [tempButton removeFromSuperview];
//}

-(IBAction)searchButtonClicked:(id)sender
{
    [searchButton setBackgroundImage:[UIImage imageNamed:@"clicked.png"] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1] forState:UIControlStateNormal];
    [shakeButton setBackgroundImage:[UIImage imageNamed:@"unclicked.png"] forState:UIControlStateNormal];
    [shakeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [shakeViewController.view removeFromSuperview];
    [self.view insertSubview:searchViewController.view atIndex:0];
}


-(IBAction)shakeButtonClicked:(id)sender
{
    [searchButton setBackgroundImage:[UIImage imageNamed:@"unclicked2.png"] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shakeButton setBackgroundImage:[UIImage imageNamed:@"clicked.png"] forState:UIControlStateNormal];
    [shakeButton setTitleColor:[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1]forState:UIControlStateNormal];
    
    [searchViewController.view removeFromSuperview];
    [self.view insertSubview:shakeViewController.view atIndex:0];
}

-(UIButton *)insertButton
{
    UIButton *returnButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 70, 50, 20)];
    [returnButton setTitle:@"返回" forState:UIControlStateNormal];
    [returnButton setBackgroundColor:[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1]];
    [returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //设置框架
    returnButton.layer.borderColor = [[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1] CGColor];
    [returnButton.layer setMasksToBounds:YES];
    [returnButton.layer setCornerRadius:4.0]; //设置矩形四个圆角半径
    [returnButton.layer setBorderWidth:1.0]; //边框宽度
    return returnButton;
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
