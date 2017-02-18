//
//  initViewController.m
//  ChangeBo
//
//  Created by ioscourse  on 13-8-21.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import "initViewController.h"

@interface initViewController ()

@end

@implementation initViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    NSMutableString *oauthUrlString =[[NSMutableString alloc]initWithFormat:@"%@?client_id=%@&redirect_uri=%@&response_type=code&display=mobile", OAuth_URL,CLIENT_ID,CLIENT_REDIRECT_URL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:oauthUrlString]];
    [self.loadingWebView setDelegate:self];
    [self.loadingWebView loadRequest:request];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    NSString *backURLString = request.URL.absoluteString;
    
    
    
    //判断是否是授权调用返回的url
    if ([backURLString hasPrefix:@"http://api.weibo.com/oauth2/default.html?"]) {
        
        NSLog(@"backURL=%@",backURLString);
        
        //找到”code=“的range
        NSRange rangeOne;
        rangeOne=[backURLString rangeOfString:@"code="];
        
        //根据他“code=”的range确定code参数的值的range
        NSRange range = NSMakeRange(rangeOne.length+rangeOne.location, backURLString.length-(rangeOne.length+rangeOne.location));
        //获取code值
        NSString *codeString = [backURLString substringWithRange:range];
        
        
 
        //生成ACCESS_TOKEN url
        NSMutableString *urlString = [[NSMutableString alloc] initWithFormat:@"https://api.weibo.com/oauth2/access_token?client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=%@",CLIENT_ID,CLIENT_SECRET,CLIENT_REDIRECT_URL,codeString];

        //同步POST请求
        NSURL *urlstring = [NSURL URLWithString:urlString];
        NSMutableURLRequest *requestSecond = [[NSMutableURLRequest alloc]initWithURL:urlstring cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [requestSecond setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
        NSString *str = @"type=focus-c";//设置参数
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [requestSecond setHTTPBody:data];
        
        //连接服务器
        NSData *received = [NSURLConnection sendSynchronousRequest:requestSecond returningResponse:nil error:nil];
   
        //从backString中获取到access_token
        NSError *error = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:received options:kNilOptions error:&error];
        NSString *string = [dictionary objectForKey:@"access_token"];
        
        [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"access_token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
               
        //跳转到主界面
        [self performSegueWithIdentifier:@"MainSegue" sender:nil];
    }
    return YES;
}

@end
