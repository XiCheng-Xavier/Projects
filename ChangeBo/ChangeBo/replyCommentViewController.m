//
//  replyCommentViewController.m
//  ChangeBo
//
//  Created by ioscourse  on 13-8-27.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import "replyCommentViewController.h"

@interface replyCommentViewController ()

@end

@implementation replyCommentViewController

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
    self.replyText.delegate = self;
}



//设置文本的placeholder
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.defaultLabel.hidden = YES;
}
- (void)textViewDidChange:(UITextView *)txtView{
    self.defaultLabel.hidden = ([_replyText.text length] > 0);
}

- (void)textViewDidEndEditing:(UITextView *)txtView{
    self.defaultLabel.hidden = ([_replyText.text length] > 0);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//判断微博的字数长度
-(int)textLength:(NSString *)dataString {
    float sum = 0.0;
    for(int i=0;i<[dataString length];i++)
    {
        NSString *character = [dataString substringWithRange:NSMakeRange(i, 1)];
        if([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            sum++;
        }
        else
            sum += 0.5;
    }
    
    return ceil(sum);
}

//发送评论
-(IBAction)pressDone:(id)sender{
    [self.replyText resignFirstResponder];
    
    if([self.replyText.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"评论" message:@"发送内容不能为空，请输入发送内容!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
        return ;
    }
    if([self textLength:self.replyText.text] > 140)
    {
        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"评论" message:@"字数不能超过140!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert2 show];
        return ;
    }
    NSString *params=[[NSString alloc]init];
    NSMutableURLRequest *request;
   if ([self.commentID isEqual:@""]) {
        params = [[NSString alloc] initWithFormat:@"access_token=%@&id=%@&comment=%@",[infoOfWeibo returnAccessToken],_WeiboID,_replyText.text];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:GIVE_COMMENT] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
   }else{

        params = [[NSString alloc] initWithFormat:@"access_token=%@&id=%@&cid=%@&comment=%@",[infoOfWeibo returnAccessToken],_WeiboID,_commentID,_replyText.text];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:REPLY_COMMENT] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
    }
    NSMutableData *postData = [[NSMutableData alloc] init];
    [postData appendData:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];

    //initWithRequest:request delegate:self];
    
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

//取消发送
-(IBAction)pressCancel:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - NSURLConnection delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [[NSMutableData alloc] initWithLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)theconnection
{
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&error];
    NSLog(@"%@",dict);
    
    NSString *date = [dict objectForKey:@"created_at"];
    if(date)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"评论" message:@"发送成功!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"评论" message:@"发送失败!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }
    
    [self.connection cancel];
}

-(void)connection:(NSURLConnection *)theconnection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"评论" message:@"发送失败!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
    [self.connection cancel];
}

@end
