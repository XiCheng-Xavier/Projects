//
//  myInformationViewController.h
//  ChangeBo
//
//  Created by ioscourse  on 13-9-1.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "infoOfWeibo.h"

@interface myInformationViewController : UIViewController
@property(strong,nonatomic)IBOutlet UIImageView *myHeadImage;
@property(strong,nonatomic)IBOutlet UILabel *myNameLabel;
@property(strong,nonatomic)IBOutlet UILabel *myLocationLabel;
@property(strong,nonatomic)IBOutlet UILabel *myLatestWeiboLabel;
@property(strong,nonatomic)IBOutlet UILabel *myIntroductionLabel;
@property(strong,nonatomic)IBOutlet UIButton *myWeiboCountButton;
@property(strong,nonatomic)IBOutlet UIButton *myFollowersCountButton;
@property(strong,nonatomic)IBOutlet UIButton *myAttentionsCountButton;
-(IBAction)pressAttentionButton:(id)sender;
-(IBAction)pressFollowersButton:(id)sender;
@end
