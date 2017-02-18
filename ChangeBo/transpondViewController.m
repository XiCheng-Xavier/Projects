//
//  transpondViewController.m
//  ChangeBo
//
//  Created by ioscourse  on 13-9-2.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import "transpondViewController.h"
#import "infoOfWeibo.h"
@interface transpondViewController ()

@end

@implementation transpondViewController

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
    _transpondTextView.text = [[NSMutableString alloc]initWithFormat:@"//@%@:%@",self.transpondOriginHostName,self.transpondOriginText];
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


-(IBAction)pressTranspondButton:(id)sender{
    [self.transpondTextView resignFirstResponder];
    
    if([self.transpondTextView.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"转发" message:@"发送内容不能为空，请输入发送内容!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
        return ;
    }
    if([self textLength:self.transpondTextView.text] > 140)
    {
        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"转发" message:@"字数不能超过140!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert2 show];
        return ;
    }

    NSString *params = [[NSString alloc] initWithFormat:@"access_token=%@&id=%@&status=%@",[infoOfWeibo returnAccessToken],self.WeiboID,_transpondTextView.text];
    NSMutableData *postData = [[NSMutableData alloc] init];
    [postData appendData:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:REPOST] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    //initWithRequest:request delegate:self];
    
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
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
 
    NSString *date = [dict objectForKey:@"created_at"];
    if(date)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"转发成功!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"转发失败!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }
    
    [self.connection cancel];
}

-(void)connection:(NSURLConnection *)theconnection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"转发失败!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
    [self.connection cancel];
}

@end
