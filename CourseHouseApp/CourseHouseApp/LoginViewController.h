//
//  LoginViewController.h
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-26.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property(nonatomic,strong)IBOutlet UITextField *nameTextField;
@property(nonatomic,strong)IBOutlet UITextField *passwordTextField;
@property(nonatomic,strong)IBOutlet UIButton *loginButton;
@property(nonatomic,strong)IBOutlet UIButton *registerButton;
-(IBAction)loginButtonTaped:(id)sender;
-(IBAction)registerButtonTaped:(id)sender;
@end
