//
//  transpondViewController.h
//  ChangeBo
//
//  Created by ioscourse  on 13-9-2.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface transpondViewController : UIViewController
@property(strong,nonatomic)IBOutlet UITextView *transpondTextView;
@property(strong,nonatomic)NSURLConnection *connection;
@property(strong,nonatomic)NSString *WeiboID;
@property(strong,nonatomic)NSString *transpondOriginHostName;
@property(strong,nonatomic)NSString *transpondOriginText;
@property(strong,nonatomic)NSMutableData *responseData;
-(IBAction)pressTranspondButton:(id)sender;
@end
