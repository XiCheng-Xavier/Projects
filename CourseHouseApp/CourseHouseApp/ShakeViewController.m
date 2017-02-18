//
//  ShakeViewController.m
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-23.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "ShakeViewController.h"

@interface ShakeViewController ()

@end

@implementation ShakeViewController
@synthesize exchangeLabel1;
@synthesize exchangeLabel2;
@synthesize image1URL;
@synthesize image2URL;
@synthesize goodsName1;
@synthesize goodsName2;
@synthesize goodsHost1;
@synthesize goodsHost2;


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
    NSString *path = [[NSBundle mainBundle]pathForResource:@"shake" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    
}

-(void)addAnimations
{
    //每次摇动先把原有的label移除
    [exchangeLabel1 removeFromSuperview];
    [exchangeLabel2 removeFromSuperview];
    //让imgup上下移动
    CABasicAnimation *translation2 = [CABasicAnimation animationWithKeyPath:@"position"];
    translation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation2.fromValue = [NSValue valueWithCGPoint:CGPointMake(160, 115)];
    translation2.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 40)];
    translation2.duration = 0.4;
    translation2.repeatCount = 1;
    translation2.autoreverses = YES;
    [imgUp.layer addAnimation:translation2 forKey:@"translation2"];
    
    //让imagdown上下移动
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"position"];
    translation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation.fromValue = [NSValue valueWithCGPoint:CGPointMake(160, 345)];
    translation.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 420)];
    translation.duration = 0.4;
    translation.repeatCount = 1;
    translation.autoreverses = YES;
    [imgDown.layer addAnimation:translation forKey:@"translation"];
    
    //设置label的弹出延迟
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(addLabels)
                                   userInfo:nil
                                    repeats:NO];
}


-(void)addLabels
{
    
    exchangeLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(40,260 , 239, 59)];
    [self setLabelBorder:exchangeLabel1];
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 49, 49)];
    NSURL *url1 = [NSURL URLWithString:image1URL];
    NSData *data1 =[NSData dataWithContentsOfURL:url1];
    UIImage *image1 = [[UIImage alloc] initWithData:data1];
    imageView1.image = image1;
    [exchangeLabel1 addSubview:imageView1];
    exchangeLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(40, 338, 239, 59)];
    [self setLabelBorder:exchangeLabel2];
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 49, 49)];
    NSURL *url2 = [NSURL URLWithString:image1URL];
    NSData *data2 =[NSData dataWithContentsOfURL:url2];
    UIImage *image2 = [[UIImage alloc] initWithData:data2];
    imageView2.image = image2;
    [exchangeLabel1 addSubview:imageView2];
    [self.view addSubview:exchangeLabel1];
    [self.view addSubview:exchangeLabel2];
}

-(void)setLabelBorder:(UILabel *)myLabel
{
    myLabel.layer.borderColor = [[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1] CGColor];
    [myLabel.layer setMasksToBounds:YES];
    [myLabel.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [myLabel.layer setBorderWidth:1.0]; //边框宽度
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    
    if(motion==UIEventSubtypeMotionShake)
    {
        
        
        [self addAnimations];
        AudioServicesPlaySystemSound (soundID);
        
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
