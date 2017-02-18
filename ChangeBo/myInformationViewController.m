//
//  myInformationViewController.m
//  ChangeBo
//
//  Created by ioscourse  on 13-9-1.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import "myInformationViewController.h"

@interface myInformationViewController ()

@end

@implementation myInformationViewController

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
   // NSMutableString *commentsAPIString;
    //int uid = 2169331617;
    //commentsAPIString = [[NSMutableString alloc]initWithFormat:@"%@?uid=%d&access_token=%@",USERS_TIMELINE,uid,[infoOfWeibo returnAccessToken]];
     NSString *commentsAPIString=@"https://api.weibo.com/2/users/show.json?access_token=2.00dPSo3C4Asx5B2f5c5910b901kB7w&uid=2169331617";
        //同步POST请求
        NSURL *urlstring = [NSURL URLWithString:commentsAPIString];
        //创建请求
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlstring cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        
        //连接服务器
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        
        //从backString中获取到access_token
        NSError *error = nil;
        NSDictionary *dictionary= [NSJSONSerialization JSONObjectWithData:received options:kNilOptions error:&error];
        _myNameLabel.text =[dictionary objectForKey:@"name"];
        [_myNameLabel sizeToFit];
        _myLocationLabel.text = [dictionary objectForKey:@"location"];
    _myIntroductionLabel.text = [[NSMutableString alloc]initWithFormat:@"简介: %@",[dictionary objectForKey:@"description"]];
        _myIntroductionLabel.lineBreakMode = NSLineBreakByCharWrapping;//实现文字多行显示
        _myIntroductionLabel.numberOfLines = 0;
    NSDictionary *mylatestWeiboDic =[dictionary objectForKey:@"status"];
    _myLatestWeiboLabel.text =[[NSMutableString alloc]initWithFormat:@"最新微博: %@",[mylatestWeiboDic objectForKey:@"text"]];
    _myLatestWeiboLabel.lineBreakMode = NSLineBreakByCharWrapping;//实现文字多行显示
    _myLatestWeiboLabel.numberOfLines = 0;
      NSURL *url = [NSURL URLWithString:[dictionary objectForKey:@"profile_image_url"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:data];
        _myHeadImage.image = image;
        NSMutableString *buttonName =[[NSMutableString alloc]initWithFormat:@"微博%@",[dictionary objectForKey:@"statuses_count"]];
        [_myWeiboCountButton setTitle:buttonName forState:UIControlStateNormal];
    buttonName =[[NSMutableString alloc]initWithFormat:@"关注%@",[dictionary objectForKey:@"friends_count"]];
    [_myAttentionsCountButton setTitle:buttonName forState:UIControlStateNormal];
    buttonName =[[NSMutableString alloc]initWithFormat:@"粉丝%@",[dictionary objectForKey:@"followers_count"]];
    [_myFollowersCountButton setTitle:buttonName forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pressAttentionButton:(id)sender{
    
}
-(IBAction)pressFollowersButton:(id)sender{
    
}

@end
