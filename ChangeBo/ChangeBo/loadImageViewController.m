//
//  loadImageViewController.m
//  ChangeBo
//
//  Created by ioscourse  on 13-8-21.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import "loadImageViewController.h"

@interface loadImageViewController ()

@end

@implementation loadImageViewController

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
    if ([infoOfWeibo returnAccessToken] != nil) {
        self.loadingTimer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(jumpTotheTabBarView) userInfo:nil repeats:NO];
    }
    
    else{
    NSLog(@"standardUserDefaultsAccess_token=%@",[infoOfWeibo returnAccessToken]);
    self.loadingTimer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(jumpTotheImpowerView) userInfo:nil repeats:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)jumpTotheImpowerView{
    [self performSegueWithIdentifier:@"LoadSegue" sender:nil];
}
-(void)jumpTotheTabBarView{
    [self performSegueWithIdentifier:@"MainSegue" sender:nil];
}
@end
