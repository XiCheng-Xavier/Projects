//
//  originWeiboViewController.h
//  ChangeBo
//
//  Created by ioscourse  on 13-9-5.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Weibo.h"
#import "infoOfWeibo.h"
#import "transpondViewController.h"
#import "replyCommentViewController.h"
@interface originWeiboViewController : UITableViewController
@property(strong,nonatomic)NSString *WeiboID;
@property(strong,nonatomic)Weibo *originWeibo;
@end
