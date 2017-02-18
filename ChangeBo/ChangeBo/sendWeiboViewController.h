//
//  sendWeiboViewController.h
//  ChangeBo
//
//  Created by ioscourse  on 13-8-26.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "infoOfWeibo.h"
@interface sendWeiboViewController : UIViewController<UIWebViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate>
{
    bool hasAddImage;

}
@property(strong,nonatomic)IBOutlet UITextView *weiboText;
@property(strong,nonatomic)NSURLConnection *connection;
@property(strong,nonatomic)NSMutableData *responseData;
@property(strong,nonatomic)IBOutlet UIImageView *WeiboImage;
@property(strong,nonatomic)IBOutlet UILabel *defaultLabel;
@property(strong,nonatomic)IBOutlet UIImageView *backgroundImage;
-(IBAction)pressSend:(id)sender;
-(IBAction)pressCancel:(id)sender;
-(IBAction)pressAddImage:(id)sender;
-(IBAction)pressCancelAddImage:(id)sender;
-(int)textLength:(NSString *)dataString;
-(void)addPhoto;
-(void)takePhoto;
-(void)dismissKeyboard:(id)sender;
@end
