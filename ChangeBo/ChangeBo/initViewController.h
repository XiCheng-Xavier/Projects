//
//  initViewController.h
//  ChangeBo
//
//  Created by ioscourse  on 13-8-21.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "infoOfWeibo.h"
#import "AppDelegate.h"
@interface initViewController : UIViewController<UIWebViewDelegate>
@property(strong,nonatomic)IBOutlet UIWebView *loadingWebView;
@end
