//
//  ViewController.h
//  dialog
//
//  Created by ioscourse  on 13-9-12.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)NSMutableArray *dialogMessages;
@property(nonatomic,strong) UITextField *myTextField;
@property(nonatomic,strong) UIToolbar *myToolbar;
@property(nonatomic,strong) UIButton *myButton;
@end
