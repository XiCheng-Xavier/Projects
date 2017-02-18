//
//  GridViewController.m
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-18.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "GridViewController.h"

@interface GridViewController ()

@end

@implementation GridViewController
@synthesize barItem;
@synthesize searchBackgroundLabel;
@synthesize gridShopLabel;
@synthesize searchTextField;
@synthesize buttonsLabel;
@synthesize timeButton;
@synthesize soldNumberButton;
@synthesize goodsAmountButton;
@synthesize soldOutButton;
@synthesize itemsScrollView;

-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, 320, 50)];
    [self.view setFrame:CGRectMake(0, -14, 320,568)];
}

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
    //设置navigationBar背景色
    [self.navigationController.navigationBar setBarTintColor: [UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1]];
    [self.navigationController.navigationBar setTranslucent:NO];//设置不透明
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; // 其上默认按钮（比如返回按钮）颜色
    //设置navigationBar字体
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];

    //[barItem set];
    searchBackgroundLabel.layer.borderColor = [[UIColor blackColor] CGColor];
    [searchBackgroundLabel.layer setMasksToBounds:YES];
    [searchBackgroundLabel.layer setCornerRadius:9.0]; //设置矩形四个圆角半径
    [searchBackgroundLabel.layer setBorderWidth:1.5]; //边框宽度

    gridShopLabel.layer.borderColor = [[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1] CGColor];
    [gridShopLabel.layer setMasksToBounds:YES];
    [gridShopLabel.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [gridShopLabel.layer setBorderWidth:1.0]; //边框宽度
    
    buttonsLabel.layer.borderColor = [[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1] CGColor];
    [buttonsLabel.layer setMasksToBounds:YES];
    [buttonsLabel.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [buttonsLabel.layer setBorderWidth:1.0]; //边框宽度
    
    //timeButton attribute
    [self setbuttonStyle:timeButton];
    [timeButton setBackgroundColor:[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1]];
    [timeButton addTarget:self action:@selector(timeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //soldNumberButton attribute
    [self setbuttonStyle:soldNumberButton];
  [soldNumberButton addTarget:self action:@selector(soldNumberButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //goodsAmountButton attribute
    [self setbuttonStyle:goodsAmountButton];
    [goodsAmountButton addTarget:self action:@selector(goodsAmountButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    
    //soldOutButton attribute
    [self setbuttonStyle:soldOutButton];
    [soldOutButton addTarget:self action:@selector(soldOutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
//gridShopLabel添加手势
    UITapGestureRecognizer *toShopDetailTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showShopDetail)];
    gridShopLabel.userInteractionEnabled = YES;
    [gridShopLabel addGestureRecognizer:toShopDetailTouch];
//键盘消失
    UITapGestureRecognizer *singleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    //[singleTouch setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:singleTouch];
    
    //设置物品scrollView
    itemsScrollView.showsVerticalScrollIndicator = NO;
    [itemsScrollView setContentSize:CGSizeMake(itemsScrollView.frame.size.width, 500)];
    [self scrollViewAddItems];
}

-(void)scrollViewAddItems
{
    for(UIView *view in [itemsScrollView subviews])
    {
        [view removeFromSuperview];
    }
    for (int i=0; i<6; i++) {
        int row = i/3;//判断图片在第几行
        //设置物品图片
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(100*(i%3)+5*(i%3+1), (100+35) * row, 100, 100)];
        [iv setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]]];
        [self setImageViewStyle:iv];
        [itemsScrollView addSubview:iv];
        iv = nil;
        //设置头像图片
        UIImageView *hiv = [[UIImageView alloc] initWithFrame:CGRectMake(100*(i%3)+5*(i%3+1),102.5 +(100+30+5) * row, 30, 30)];
        [hiv setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]]];
        [self setImageViewStyle:hiv];
        [itemsScrollView addSubview:hiv];
        hiv = nil;
        //设置物主名字
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(32+100*(i%3)+5*(i%3+1),102.5 +(100+30+5) * row, 70, 15)];
        nameLabel.text = [NSString stringWithFormat:@"%d.jpg",i+1];
        [nameLabel setFont:[UIFont systemFontOfSize:10]];
        [nameLabel setTextColor:[UIColor blackColor]];
        [itemsScrollView addSubview:nameLabel];
        //设置产品类型
        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(32+100*(i%3)+5*(i%3+1),15 +102.5 +(100+30+5) * row, 70, 15)];
        typeLabel.text = @"保温杯";
        [typeLabel setFont:[UIFont systemFontOfSize:10]];
        [typeLabel setTextColor:[UIColor blackColor]];
        [itemsScrollView addSubview:typeLabel];
    }

}
-(void)setImageViewStyle:(UIImageView *)iv
{
    //设置图片属性
    iv.layer.borderColor = [[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1] CGColor];
    [iv.layer setMasksToBounds:YES];
    [iv.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
    [iv.layer setBorderWidth:1.0]; //边框宽度
}

-(void)dismissKeyboard:(id)sender{
    [searchTextField resignFirstResponder];
}

-(void)showShopDetail
{
    NSLog(@"hello");
    [self performSegueWithIdentifier:@"gotoShop" sender:self];
}

-(void)timeButtonClicked
{
    [timeButton setBackgroundColor:[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1]];
    [soldNumberButton setBackgroundColor:[UIColor whiteColor]];
    [goodsAmountButton setBackgroundColor:[UIColor whiteColor]];
    [soldOutButton setBackgroundColor:[UIColor whiteColor]];
}
-(void)soldNumberButtonClicked
{
    [soldNumberButton setBackgroundColor:[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1]];
    [timeButton setBackgroundColor:[UIColor whiteColor]];
    [goodsAmountButton setBackgroundColor:[UIColor whiteColor]];
    [soldOutButton setBackgroundColor:[UIColor whiteColor]];
}
-(void)goodsAmountButtonClicked
{
    [goodsAmountButton setBackgroundColor:[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1]];
    [soldNumberButton setBackgroundColor:[UIColor whiteColor]];
    [timeButton setBackgroundColor:[UIColor whiteColor]];
    [soldOutButton setBackgroundColor:[UIColor whiteColor]];
}

-(void)soldOutButtonClicked
{
    [soldOutButton setBackgroundColor:[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1]];
    [soldNumberButton setBackgroundColor:[UIColor whiteColor]];
    [goodsAmountButton setBackgroundColor:[UIColor whiteColor]];
    [timeButton setBackgroundColor:[UIColor whiteColor]];
}

-(void)setbuttonStyle:(UIButton *)button
{
    //设置按钮属性
    button.layer.borderColor = [[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1] CGColor];
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
    [button.layer setBorderWidth:1.0]; //边框宽度
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
