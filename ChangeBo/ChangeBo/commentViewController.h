//
//  commentViewController.h
//  ChangeBo
//
//  Created by ioscourse  on 13-8-27.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "infoOfWeibo.h"
#import "commentsItem.h"
#import "replyCommentViewController.h"
#import "readWeiboViewController.h"
#import "originWeiboViewController.h"
@interface commentViewController : UITableViewController<UIScrollViewAccessibilityDelegate>
{
    bool hasChangeTag;
    int page;
}
@property(strong, nonatomic)NSMutableArray *comments;
@property(strong,nonatomic)UIRefreshControl *refreshControll;
@property(strong,nonatomic)IBOutlet UIBarButtonItem *changeDisplayButton;
-(IBAction)pressChangeDisplayButton:(id)sender;
-(IBAction)pressRefresh:(id)sender;
-(void)getCommentDataWithPage:(int)p;

@end
