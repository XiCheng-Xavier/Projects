//
//  VideoViewController.m
//  StudyTourMap
//
//  Created by 熙 程 on 14-4-14.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController
@synthesize scrollView;
@synthesize videoImageView;
@synthesize moviePlayer;

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
    [self.view setFrame:CGRectMake(150, 20, 874, 724)];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tag = 0;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [videoImageView setImage:[UIImage imageNamed:@"1.png"]];
    UIImage *startButtonImage = [UIImage imageNamed:@"start.png"];
    UIButton *startButton = [[UIButton alloc]initWithFrame:CGRectMake((videoImageView.frame.size.width-startButtonImage.size.width)/2, (videoImageView.frame.size.height-startButtonImage.size.height)/2, startButtonImage.size.width, startButtonImage.size.height)];
    [startButton setBackgroundImage:startButtonImage forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startSingleTap)  forControlEvents:UIControlEventTouchUpInside];
    [videoImageView addSubview:startButton];
    videoImageView.userInteractionEnabled = YES;
    for (int i = 0; i<6; i++) {
        UIImageView *tempImageView = [[UIImageView alloc]initWithFrame:CGRectMake(200*i, 0, 200,scrollView.frame.size.height)];
        [tempImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]]];
        [scrollView addSubview:tempImageView];
    }
    [scrollView setContentSize:CGSizeMake(200*6, scrollView.frame.size.height)];
    //添加点击处理函数
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [scrollView addGestureRecognizer:singleTap];
    //声明白色边框
    pf = [[PicFrame alloc] initWithFrame:((UIImageView*)[scrollView.subviews objectAtIndex:0]).frame];
    [scrollView addSubview:pf];
    
    
}
-(void)startSingleTap
{
    NSLog(@"%d",tag);
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"darkandlight" ofType:@"mp4"];
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
    moviePlayer=[[MPMoviePlayerController alloc] initWithContentURL: movieURL];
    
    //    // 我们只支持 Landscape Left 方向，此时屏幕方向未确定，故尺寸不准确，需要在 viewDidAppear 方法中重新设置
    [moviePlayer.view setFrame: self.view.bounds];  // player's frame must match parent's
    //_moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    //[_moviePlayer setFullscreen:YES animated:YES];
    //_moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
    //[self presentMoviePlayerViewControllerAnimated:moviePlayer];
    [self.view addSubview: moviePlayer.view];
//    [moviePlayer prepareToPlay];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMovieFinishedCallback:)//按下done之后是退出出全屏，触发这个notification
                                                 name:MPMoviePlayerDidExitFullscreenNotification
                                               object:moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMovieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification//视频播放完毕触发
                                               object:moviePlayer];

    [moviePlayer play];
}


//视频移出subView
-(void)myMovieFinishedCallback:(NSNotification*)notify
{
    //视频播放对象
    MPMoviePlayerController* theMovie = [notify object];
    //销毁播放通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerDidExitFullscreenNotification
                                                  object:theMovie];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:theMovie];
    [theMovie.view removeFromSuperview];
    // 释放视频对象
  
}

-(void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer
{
    CGFloat width = 200;
    
    CGPoint loc = [gestureRecognizer locationInView:scrollView];
    NSInteger touchIndex = floor(loc.x / width) ;
    [videoImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",touchIndex+1]]];
    tag = touchIndex;
    
    if (touchIndex > 5) {
        return;
    }
    
    pf.frame = ((UIImageView*)[scrollView.subviews objectAtIndex:touchIndex]).frame;
    [pf setAlpha:0];
    [UIView animateWithDuration:0.2f animations:^(void){
        [pf setAlpha:.85f];
    }];
    
}

-(IBAction)returnToSubView:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"videoShow" object:@"remove"];
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
