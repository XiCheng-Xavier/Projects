//
//  SearchViewController.m
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-14.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "SearchViewController.h"
#import "News.h"
#import "NewsListTableViewController.h"
#import "NewsViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize searchTextField;
@synthesize searchButton;
@synthesize cityChooseButton;
@synthesize label;
@synthesize hotspotBackgroundView;
@synthesize moreHotspotButton;
@synthesize tabBaritem;
@synthesize hotNewsImageView1;
@synthesize hotNewsImageView2;
@synthesize localNewsImageView1;
@synthesize localNewsImageView2;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [searchTextField resignFirstResponder];
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

    hotspotBackgroundView.layer.borderColor = [[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1] CGColor];
    hotspotBackgroundView.layer.borderWidth = 2;
    
    //设置tabBar颜色
    self.navigationController.navigationBarHidden = YES;
    
    CGRect frame = CGRectMake(0.0, 0, 320, 49);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    [v setBackgroundColor:[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1]];
    [self.tabBarController.tabBar insertSubview:v atIndex:1];
    [self.tabBarController.tabBar setSelectedImageTintColor:[UIColor colorWithRed:229.0/255 green:120.0/255 blue:41.0/255 alpha:1]];
    UITapGestureRecognizer *singleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:singleTouch];
    UITapGestureRecognizer *hotImg1Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotImg1Tap)];
    hotNewsImageView1.userInteractionEnabled = YES;
    [hotNewsImageView1 addGestureRecognizer:hotImg1Gesture];
    UITapGestureRecognizer *hotImg2Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotImg2Tap)];
    hotNewsImageView2.userInteractionEnabled = YES;
    [hotNewsImageView2 addGestureRecognizer:hotImg2Gesture];
    UITapGestureRecognizer *localImg1Gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(localImg1Tap)];
    localNewsImageView1.userInteractionEnabled = YES;
    [localNewsImageView1 addGestureRecognizer:localImg1Gesture];
    UITapGestureRecognizer *localImg2Gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(localImg2Tap)];
    localNewsImageView2.userInteractionEnabled = YES;
    [localNewsImageView2 addGestureRecognizer:localImg2Gesture];
    
}
//隐藏键盘
-(void)dismissKeyboard:(id)sender{
    [searchTextField resignFirstResponder];
}

//图片点击响应函数
-(void)hotImg1Tap
{
    imageTag = 0;
    [self performSegueWithIdentifier:@"toNews" sender:self];
}
-(void)hotImg2Tap
{
    imageTag = 1;
    [self performSegueWithIdentifier:@"toNews" sender:self];
}
-(void)localImg1Tap
{
    imageTag = 2;
    [self performSegueWithIdentifier:@"toNews" sender:self];
}
-(void)localImg2Tap
{
    imageTag = 3;
    [self performSegueWithIdentifier:@"toNews" sender:self];
}

//搜索函数
-(IBAction)goToSearchResult:(id)sender
{
    if ([searchTextField.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请输入搜索内容" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }else
    {
        [self performSegueWithIdentifier:@"gotoSearchResult" sender:self];
    }
}

//"更多"按钮函数
-(IBAction)moreHotNews:(id)sender
{
    buttonTag = 0;
    [self performSegueWithIdentifier:@"newsList" sender:self];
}
-(IBAction)moreLocalNews:(id)sender
{
    buttonTag = 1;
    [self performSegueWithIdentifier:@"newsList" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //设置搜索跳转
    if ([segue.identifier isEqualToString:@"gotoSearchResult"]) {
    ResultTableViewController *resultViewController =  [segue destinationViewController];
    resultViewController.keyWord = searchTextField.text;
    }
    //设置点击“更多”跳转
    if ([segue.identifier isEqualToString:@"newsList"]) {
        if (buttonTag == 0) {
            NewsListTableViewController *newsController = [segue destinationViewController];
            News *new = [[News alloc]init];
            newsController.newsArray = [new getHotNewsArray];
        }
        if (buttonTag == 1) {
            NewsListTableViewController *newsController = [segue destinationViewController];
            News *new = [[News alloc]init];
            newsController.newsArray = [new getLocalNewsArray];
        }

    }
    //设置点击图片跳转
    if ([segue.identifier isEqualToString:@"toNews"]) {
        if (imageTag == 0) {
            NewsViewController *newsViewController = [segue destinationViewController];
            NSMutableArray *tempArray = [[News alloc]getHotNewsArray];
            NSMutableDictionary *tempDictionary = [tempArray objectAtIndex:0];
            newsViewController.title = [tempDictionary objectForKey:@"title"];
            newsViewController.passage = [tempDictionary objectForKey:@"passage"];
        }
        if (imageTag == 1) {
            NewsViewController *newsViewController = [segue destinationViewController];
            NSMutableArray *tempArray = [[News alloc]getHotNewsArray];
            NSMutableDictionary *tempDictionary = [tempArray objectAtIndex:1];
            newsViewController.title = [tempDictionary objectForKey:@"title"];
            newsViewController.passage = [tempDictionary objectForKey:@"passage"];
        }
        if (imageTag == 2) {
            NewsViewController *newsViewController = [segue destinationViewController];
            NSMutableArray *tempArray = [[News alloc]getLocalNewsArray];
            NSMutableDictionary *tempDictionary = [tempArray objectAtIndex:0];
            newsViewController.title = [tempDictionary objectForKey:@"title"];
            newsViewController.passage = [tempDictionary objectForKey:@"passage"];
        }
        if (imageTag == 3) {
            NewsViewController *newsViewController = [segue destinationViewController];
            NSMutableArray *tempArray = [[News alloc]getLocalNewsArray];
            NSMutableDictionary *tempDictionary = [tempArray objectAtIndex:1];
            newsViewController.title = [tempDictionary objectForKey:@"title"];
            newsViewController.passage = [tempDictionary objectForKey:@"passage"];
        }

    }
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
