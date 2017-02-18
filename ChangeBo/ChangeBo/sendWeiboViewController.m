//
//  sendWeiboViewController.m
//  ChangeBo
//
//  Created by ioscourse  on 13-8-26.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import "sendWeiboViewController.h"
#import "ASIFormDataRequest.h"

@interface sendWeiboViewController ()

@end

@implementation sendWeiboViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

//发送微博
-(IBAction)pressSend:(id)sender{
    [self.weiboText resignFirstResponder];
    
    if([self.weiboText.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"微博" message:@"发送内容不能为空，请输入发送内容!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
        return ;
    }
    if([self textLength:self.weiboText.text] > 140)
    {
        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"微博" message:@"字数不能超过140!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert2 show];
        return ;
    }
    
    //  -- 设置HTTP请求方式和请求头 --
    // 请求头的内容：
    // Content-type: multipart/form-data, charset=utf-8, boundary=KhTmLbOuNdArY, Authorization=Bearer access_token
    NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    CFUUIDRef uuid = CFUUIDCreate(nil);
    NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuid));
    CFRelease(uuid);
    NSString *stringBoundary = [NSString stringWithFormat:@"0xKhTmLbOuNdArY-%@",uuidString];
    NSString *endItemBoundary = [NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:WEIBO_UPLOAD]];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; charset=%@; boundary=%@", charset,stringBoundary] forHTTPHeaderField:@"Content-Type"];
    NSString *bearerToken = [NSString stringWithFormat:@"Bearer %@",[infoOfWeibo returnAccessToken]];
    [request setValue:bearerToken forHTTPHeaderField:@"Authorization"];

    //  -- 对要POST的数据进行编码并设置HTTP请求的BODY --
    // 开头的boundary:
    // --KhTmLbOuNdArY
    NSMutableData *postData = [[NSMutableData alloc] init];
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // source参数对应的key和内容:
    // Content-disposition: form-data; name="source"
    //
    // AppKey对应的内容
/*
    NSString *kAccessToken = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"access_token\"\r\n\r\n"];
    [postData appendData:[kAccessToken dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *vAccessToken = [NSString stringWithFormat:@"access_token=%@", [infoOfWeibo returnAccessToken]];
    [postData appendData:[vAccessToken dataUsingEncoding:NSUTF8StringEncoding]];
    */
    // 分割字段内容的boundary:
    // --KhTmLbOuNdArY
    [postData appendData:[endItemBoundary dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *kSource = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"source\"\r\n\r\n"];
    [postData appendData:[kSource dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *vSource = [NSString stringWithFormat:@"source=%@", CLIENT_ID];
    [postData appendData:[vSource dataUsingEncoding:NSUTF8StringEncoding]];

    // 分割字段内容的boundary:
    // --KhTmLbOuNdArY
    [postData appendData:[endItemBoundary dataUsingEncoding:NSUTF8StringEncoding]];

    // text参数对应的key和内容:
    // Content-disposition: form-data; name="text"
    //
    // 要发送的广播内容
    NSString *kText = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"status\"\r\n\r\n"];
    [postData appendData:[kText dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *vText = self.weiboText.text;
    [postData appendData:[vText dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 分割字段内容的boundary:
    // --KhTmLbOuNdArY
    [postData appendData:[endItemBoundary dataUsingEncoding:NSUTF8StringEncoding]];
    
    // image参数对应的key和内容:
    // content-disposition: form-data; name="image"; filename="WW.jpg"
    // Content-Type: image/png
    //
    // ... contents of WW.jpg ...
    NSString *kImage = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"WW.jpg\"\r\n"];
    [postData appendData:[kImage dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *tImage = [NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", @"image/jpeg"];
    [postData appendData:[tImage dataUsingEncoding:NSUTF8StringEncoding]];
    UIImage *pickedImage = [UIImage imageNamed:@"WW.jpg"];
    // NSData *imageData = UIImagePNGRepresentation(pickedImage); // png格式
    NSData *imageData = UIImageJPEGRepresentation(pickedImage, 0.0); // jpg格式，1.0表示最大压缩，0.0表示图像无压缩
    [postData appendData:imageData];
    
    // 结尾的boundary
    // --KhTmLbOuNdArY--
    [postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //  -- 设置HTTP的BODY和请求头中的Content-Length --
    NSString *length = [NSString stringWithFormat:@"%d", [postData length]];  
    [request setValue:length forHTTPHeaderField:@"Content-Length"];  
    [request setHTTPBody:postData];
                                    
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];


    
    
    /*
    //用第三方库实现发送图片
    NSURL *url = [NSURL URLWithString:WEIBO_UPLOAD];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    
    [item setPostValue:[infoOfWeibo returnAccessToken]    forKey:@"access_token"];
    [item setPostValue:self.weiboText.text                                     forKey:@"status"];
    [item addData:UIImagePNGRepresentation(self.WeiboImage.image)               forKey:@"pic"];
        [item startAsynchronous];
     */
    /*
     //原来自己写的内容
    NSString *url,*params;
 
    if (hasAddImage == false) {
        url = @"https://api.weibo.com/2/statuses/update.json?";
            params = [[NSString alloc] initWithFormat:@"access_token=%@&status=%@",[infoOfWeibo returnAccessToken],self.weiboText.text];
    }
    else{

        url = @"https://api.weibo.com/2/statuses/upload.json?";
       params = [[NSString alloc] initWithFormat:@"access_token=%@&status=%@&pic=",[infoOfWeibo returnAccessToken],self.weiboText.text];

    //}

    NSMutableData *postData = [[NSMutableData alloc] init];
    [postData appendData:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:UIImagePNGRepresentation(self.WeiboImage.image)];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    //[request setHTTPBody:UIImagePNGRepresentation(weiboImage)];
    // NSURLConnection *theConncetion=[[NSURLConnection alloc]
    //initWithRequest:request delegate:self];
   
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
*/
}

//取消发送
-(IBAction)pressCancel:(id)sender{
[self.navigationController popViewControllerAnimated:YES];      
}

//添加图片
-(IBAction)pressAddImage:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"插入图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"系统相册",@"拍摄", nil];
    [alert show];
}

//取消添加图片
-(IBAction)pressCancelAddImage:(id)sender{
    self.WeiboImage.image = nil;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:nil delegate:self cancelButtonTitle:@"取消完成" otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   // hasAddImage = false;
    self.weiboText.delegate = self;
    //设置按背景图键盘消失
     self.backgroundImage.userInteractionEnabled = YES;//一定要有这句否则不能响应事件
    UITapGestureRecognizer *singleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.backgroundImage addGestureRecognizer:singleTouch];
}

-(void)dismissKeyboard:(id)sender{
    [self.weiboText resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//设置文本的placeholder
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.defaultLabel.hidden = YES;
}
- (void)textViewDidChange:(UITextView *)txtView{
    self.defaultLabel.hidden = ([_weiboText.text length] > 0);
}

- (void)textViewDidEndEditing:(UITextView *)txtView{
    self.defaultLabel.hidden = ([_weiboText.text length] > 0);
}



#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self addPhoto];
    }
    else if(buttonIndex == 2)
    {
        [self takePhoto];
    }
}

- (void)addPhoto
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
	imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePickerController.delegate = self;
	imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)takePhoto
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"该设备不支持拍照功能"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"好", nil];
        [alert show];
    }
    else
    {
        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.WeiboImage.image = image;
    hasAddImage = true;    
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"微博" message:@"发送成功!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"微博" message:@"发送失败!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }
    
    [self.connection cancel];
}

-(void)connection:(NSURLConnection *)theconnection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"微博" message:@"发送失败!" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
    [self.connection cancel];
}

@end
