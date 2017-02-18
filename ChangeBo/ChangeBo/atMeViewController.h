//
//  atMeViewController.h
//  ChangeBo
//
//  Created by ioscourse  on 13-8-28.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//
#import <UIKit/UIKit.h>
#import "infoOfWeibo.h"
#import "Weibo.h"
#import "transpondViewController.h"
#import "replyCommentViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface atMeViewController : UITableViewController{
    int page;
    int tag;
}
@property(strong,nonatomic)NSMutableArray *WeiboItems;
@property(strong,nonatomic)UIRefreshControl *refreshControl;
@end
