//
//  loadImageViewController.h
//  ChangeBo
//
//  Created by ioscourse  on 13-8-21.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "infoOfWeibo.h"

@interface loadImageViewController : UIViewController
@property(strong,nonatomic)IBOutlet UIImageView *loadingImage;
@property(strong,nonatomic)NSTimer *loadingTimer;
-(void)jumpTotheImpowerView;
-(void)jumpTotheTabBarView;
@end
