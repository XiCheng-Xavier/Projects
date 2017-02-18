//
//  DetailViewController.h
//  searchResult
//
//  Created by 熙 程 on 14-4-24.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,strong)NSString *loadURL;
@property(nonatomic,strong)IBOutlet UIWebView *detailWebView;
@property(nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;
@end
