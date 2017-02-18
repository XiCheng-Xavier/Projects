//
//  replyCommentViewController.h
//  ChangeBo
//
//  Created by ioscourse  on 13-8-27.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "infoOfWeibo.h"

@interface replyCommentViewController : UIViewController
@property(strong,nonatomic)NSURLConnection *connection;
@property(strong,nonatomic)NSMutableData *responseData;
@property(strong,nonatomic)IBOutlet UITextView *replyText;
@property(strong,nonatomic)IBOutlet UILabel *defaultLabel;
@property(strong,nonatomic)NSString *commentID;
@property(strong,nonatomic)NSString *WeiboID;
-(IBAction)pressCancel:(id)sender;
-(IBAction)pressDone:(id)sender;
@end
