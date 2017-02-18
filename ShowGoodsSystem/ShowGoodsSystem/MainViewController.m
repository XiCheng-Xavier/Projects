

//
//  MainViewController.m
//  ShowGoodsSystem
//
//  Created by 熙 程 on 14-4-9.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize masterNavBar;
@synthesize blowupScrollView;
@synthesize backgroundView;


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
    masterNavBar.layer.borderColor = [[UIColor grayColor]CGColor];//设置navigationBar
    masterNavBar.layer.borderWidth = 0.5;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];//接收detailViewController传来的信息
    [center addObserver:self selector:@selector(createBlowUpView:) name:@"blowUp" object:nil];
    blowupScrollView.delegate = self;

}


-(void)createBlowUpView:(NSNotification *)notification
{
    NSDictionary *dic = [notification userInfo];
    NSArray *arr = [notification object];
    //UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[dic objectForKey:@"tag"]]];
    backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [backgroundView setBackgroundColor:[UIColor grayColor]];
    blowupScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    blowupScrollView.delegate = self;
    blowupScrollView.showsHorizontalScrollIndicator = NO;
    blowupScrollView.showsVerticalScrollIndicator = NO;
    blowupScrollView.directionalLockEnabled = YES;
    blowupScrollView.pagingEnabled = YES;
    
    [blowupScrollView setContentSize:CGSizeMake(blowupScrollView.frame.size.width*arr.count,blowupScrollView.frame.size.height)];
    for (int i = 0; i<arr.count; i++) {
        UIImageView *tempImageView = [[UIImageView alloc]initWithFrame:CGRectMake(blowupScrollView.frame.size.width*i, 0,blowupScrollView.frame.size.width, blowupScrollView.frame.size.height)];
        [tempImageView setImage:[UIImage imageNamed:[arr objectAtIndex:i]]];
        [blowupScrollView addSubview:tempImageView];
    }
    
    //设置scrollview起始页面
    CGRect frame = blowupScrollView.frame;
    frame.origin.x = frame.size.width * [[dic objectForKey:@"touchIndex"] intValue];
    frame.origin.y = 0;
    [blowupScrollView scrollRectToVisible:frame animated:YES];
    
    [backgroundView addSubview:blowupScrollView];
    [self.view addSubview:backgroundView];
    //添加page control
    //    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 750, self.view.frame.size.width, 80)];
    //    pageControl.hidesForSinglePage = YES;
    //    pageControl.userInteractionEnabled = NO;
    //    pageControl.backgroundColor = [UIColor redColor];
    //    [scrollView addSubview:pageControl];
    
    UITapGestureRecognizer *restoreTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [restoreTap setNumberOfTapsRequired:1];
    [blowupScrollView addGestureRecognizer:restoreTap];
}

-(void)removeView
{
    [backgroundView removeFromSuperview];
}

-(IBAction)gotoShopppingcart:(id)sender
{
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"gotoShoppingcart" object:nil];
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
