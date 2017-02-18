//
//  originWeiboViewController.m
//  ChangeBo
//
//  Created by ioscourse  on 13-9-5.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import "originWeiboViewController.h"

@interface originWeiboViewController ()

@end

@implementation originWeiboViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSMutableString *getWeiboAPIString = [[NSMutableString alloc]initWithFormat:@"%@?access_token=%@&id=%@",WEIBO_GET_BY_ID,[infoOfWeibo returnAccessToken],self.WeiboID];

    //同步POST请求
    NSURL *urlstring = [NSURL URLWithString:getWeiboAPIString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlstring cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //从backString中获取到access_token
    NSError *error = nil;
    NSDictionary *dictionary= [NSJSONSerialization JSONObjectWithData:received options:kNilOptions error:&error];
    self.originWeibo = [[Weibo alloc]initWithJsonDictionary:dictionary];
  
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //转发按钮
    UIButton *transpondButton = [[UIButton alloc]init];
    int transpondCount = self.originWeibo.transpondCount;
    NSMutableString *buttonName =[[NSMutableString alloc]initWithFormat:@"转发:%d",transpondCount];
    [transpondButton setTitle:buttonName forState:UIControlStateNormal];
    transpondButton.titleLabel.font    = [UIFont systemFontOfSize: 12];
    [transpondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    transpondButton.layer.borderWidth = 1;
    //label.backgroundColor = [UIColor blueColor];
    //label.layer.cornerRadius = 10;
    //UIColor * color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xx.png"]];
    //UILabel * label = [[UILabel alloc] init ];
    //label.backgroundColor = color;
    transpondButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    transpondButton.tag = indexPath.row;
    [transpondButton addTarget:self action:@selector(TranspondbtnClicked:event:)  forControlEvents:UIControlEventTouchUpInside];
    
    //评论按钮
    UIButton *commentButton = [[UIButton alloc]init];
    int commentsCount = self.originWeibo.commentsCount;
    buttonName =[[NSMutableString alloc]initWithFormat:@"评论:%d",commentsCount];
    [commentButton setTitle:buttonName forState:UIControlStateNormal];
    commentButton.titleLabel.font    = [UIFont systemFontOfSize: 12];
    [commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    commentButton.layer.borderWidth = 1;
    commentButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [commentButton addTarget:self action:@selector(CommentbtnClicked:event:)
            forControlEvents:UIControlEventTouchUpInside];
    
    //微博正文
    CGSize size = CGSizeMake(288, 180);
    UIFont *fonts = [UIFont systemFontOfSize:14.0];
    CGSize msgSie = [self.originWeibo.text sizeWithFont:fonts constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *WeiboTextLabel  = [[UILabel alloc] init];
    [WeiboTextLabel setFont:[UIFont boldSystemFontOfSize:14]];
    WeiboTextLabel.frame = CGRectMake(20,70, 280,msgSie.height);
    WeiboTextLabel.text = self.originWeibo.text;
    WeiboTextLabel.lineBreakMode = NSLineBreakByCharWrapping;//实现文字多行显示
    WeiboTextLabel.numberOfLines = 0;
    //UIColor * color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"照片.PNG"]];
    //WeiboTextLabel.backgroundColor = color;
    //label.alpha = 0.9;  //设置透明度，范围为0.0-1.0
    [cell.contentView addSubview:WeiboTextLabel];
    
    //博主名字
    UILabel *hostNameLabel = [[UILabel alloc]init];
    hostNameLabel.frame = CGRectMake(97, 0, 150, 30);
    hostNameLabel.text = self.originWeibo.HostName;
    hostNameLabel.font = [UIFont systemFontOfSize:17];
    [hostNameLabel sizeToFit];
    [cell.contentView addSubview:hostNameLabel];
    
    //发布时间
    UILabel *createdAtLabel = [[UILabel alloc]init];
    createdAtLabel.frame = CGRectMake(97, 30, 218, 18);
    NSRange range = NSMakeRange(4,15);
    NSString *created_at = [self.originWeibo.createdAt substringWithRange:range];//取出发布时间
    createdAtLabel.text =created_at;
    createdAtLabel.font = [UIFont systemFontOfSize:12];//文字大小
    createdAtLabel.textColor = [UIColor lightGrayColor];//文字颜色
    [cell.contentView addSubview:createdAtLabel];
    
    //微博来源
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.frame = CGRectMake(97, 47, 223, 19);
    sourceLabel.text = self.originWeibo.source;
    sourceLabel.font = [UIFont systemFontOfSize:12];//文字大小
    sourceLabel.textColor = [UIColor lightGrayColor];//文字颜色
    [cell.contentView addSubview:sourceLabel];
    
    //头像照片
    UIImageView *hostImageView = [[UIImageView alloc]init];
    hostImageView.frame = CGRectMake(20,9, 52,52);
    NSURL *url = [NSURL URLWithString:self.originWeibo.HostHeadImageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    hostImageView.image = image;
    [cell.contentView addSubview:hostImageView];
    
    if (self.originWeibo.hasTranspond == true) {
        //对话图片
        UIImageView *dialogImageView = [[UIImageView alloc]init];
        dialogImageView.frame = CGRectMake(6,70+ WeiboTextLabel.frame.size.height,307,12);
        NSString *imageName = [NSString stringWithFormat:@"%@.png",@"transpondDialog"];
        dialogImageView.image = [UIImage imageNamed:imageName];
        
        //转发微博label
        UILabel *transpondWeiboTextLabel = [[UILabel alloc]init];
        CGSize size = CGSizeMake(288, 180);
        UIFont *fonts = [UIFont systemFontOfSize:14];
        NSMutableString *transponedNameAndText =[[NSMutableString alloc]initWithFormat:@"%@:%@",self.originWeibo.transpondedWeibo.HostName,self.originWeibo.transpondedWeibo.text];
        CGSize msgSie = [transponedNameAndText sizeWithFont:fonts constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        
        transpondWeiboTextLabel.frame = CGRectMake(20,70+11+ WeiboTextLabel.frame.size.height,280,msgSie.height);//label根据文字数量动态调整高度
        
        
        transpondWeiboTextLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;//边框颜色
        transpondWeiboTextLabel.layer.borderWidth = 1;//边框宽度
        
        transpondWeiboTextLabel.text =transponedNameAndText;//转发内容
        [transpondWeiboTextLabel setFont:[UIFont boldSystemFontOfSize:14]];
        transpondWeiboTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
        transpondWeiboTextLabel.numberOfLines = 0;
        transpondWeiboTextLabel.backgroundColor = [UIColor lightTextColor];
        [cell.contentView addSubview:transpondWeiboTextLabel];
        
        //转发有图
        if (self.originWeibo.haveTranspondImage) {
            UIImageView *WeiboImageView =[[UIImageView alloc]init];
            NSURL *url = [NSURL URLWithString:self.originWeibo.transpondedWeibo.thumbnailPic];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [[UIImage alloc] initWithData:data];
            WeiboImageView.image = image;
            WeiboImageView.frame = CGRectMake(160-(image.size.width/2),WeiboTextLabel.frame.origin.y + WeiboTextLabel.frame.size.height +transpondWeiboTextLabel.frame.size.height+12 +1, image.size.width,image.size.height);
            [cell.contentView addSubview:WeiboImageView];
            
            transpondWeiboTextLabel.layer.borderColor = [UIColor clearColor].CGColor;
            UILabel *dialog=[[UILabel alloc]init];
            dialog.frame = CGRectMake(20,70+11+ WeiboTextLabel.frame.size.height,280,msgSie.height + image.size.height+4);
            dialog.layer.borderColor = [UIColor lightGrayColor].CGColor;
            dialog.layer.borderWidth = 1;
            dialog.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:dialog];
            
            transpondButton.frame =CGRectMake(20,dialog.frame.origin.y +dialog.frame.size.height -1, 100, 30);
            commentButton.frame =CGRectMake(200,dialog.frame.origin.y +dialog.frame.size.height -1, 100, 30);
        }
        //转发没图
        else{
            
            transpondButton.frame =CGRectMake(20,transpondWeiboTextLabel.frame.origin.y +transpondWeiboTextLabel.frame.size.height -1, 100, 30);
            commentButton.frame =CGRectMake(200,transpondWeiboTextLabel.frame.origin.y +transpondWeiboTextLabel.frame.size.height -1, 100, 30);
            
        }
        [cell.contentView addSubview:transpondButton];
        [cell.contentView addSubview:commentButton];
        [cell.contentView addSubview:dialogImageView];
    }
    else{
        //判断原微博是否有图
        if (self.originWeibo.hasImage == true) {
            NSURL *url = [NSURL URLWithString:self.originWeibo.thumbnailPic];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [[UIImage alloc] initWithData:data];
            UIImageView *WeiboImageView=[[UIImageView alloc]init];
            WeiboImageView.image = image;
            WeiboImageView.frame = CGRectMake(160-(image.size.width/2),WeiboTextLabel.frame.origin.y + WeiboTextLabel.frame.size.height +1,image.size.width,image.size.height);
            [cell.contentView addSubview:WeiboImageView];
            
            transpondButton.frame =CGRectMake(20,WeiboImageView.frame.origin.y + image.size.height +1, 100, 30);
            commentButton.frame =CGRectMake(200,WeiboImageView.frame.origin.y + image.size.height +1, 100, 30);
            [cell.contentView addSubview:transpondButton];
            [cell.contentView addSubview:commentButton];
        }
        else{
            
            transpondButton.frame =CGRectMake(20,WeiboTextLabel.frame.origin.y +WeiboTextLabel.frame.size.height+1, 100, 30);
            commentButton.frame =CGRectMake(200,WeiboTextLabel.frame.origin.y +WeiboTextLabel.frame.size.height+1, 100, 30);
            [cell.contentView addSubview:transpondButton];
            [cell.contentView addSubview:commentButton];
        }
    }
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    CGSize size = CGSizeMake(288, 180);
    UIFont *fonts = [UIFont systemFontOfSize:14];
    CGSize msgSie = [self.originWeibo.text sizeWithFont:fonts constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    CGFloat height = msgSie.height + 75;
    if (self.originWeibo.hasTranspond == true) {
        NSMutableString *transponedNameAndText =[[NSMutableString alloc]initWithFormat:@"%@:%@",self.originWeibo.transpondedWeibo.HostName,self.originWeibo.transpondedWeibo.text];
        CGSize msgSieTranspond = [transponedNameAndText sizeWithFont:fonts constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        height = height + msgSieTranspond.height +12;//12是对话框的图的高度
        if (self.originWeibo.haveTranspondImage == true) {
            NSURL *url = [NSURL URLWithString:self.originWeibo.transpondedWeibo.thumbnailPic];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [[UIImage alloc] initWithData:data];
            height = height +image.size.height +1;
        }
    }
    else{
        if (self.originWeibo.hasImage == true) {
            NSURL *url = [NSURL URLWithString:self.originWeibo.thumbnailPic];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [[UIImage alloc] initWithData:data];
            height = height +image.size.height +1;
        }
    }
    height = height +31;//按钮高度
    
    return height;
}

- (void)TranspondbtnClicked:(id)sender event:(id)event{//按下转发按钮响应事件
    [self performSegueWithIdentifier:@"transpondSegue" sender:nil];
    
}

- (void)CommentbtnClicked:(id)sender event:(id)event{//按下评论按钮响应事件
    [self performSegueWithIdentifier:@"commentSegue" sender:nil];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender//跳转到转发/评论输入界面
{
   
    
    if([[segue identifier] isEqualToString:@"transpondSegue"]){
        transpondViewController *v=[segue destinationViewController];
        v.WeiboID =self.originWeibo.WeiboID;
        if (self.originWeibo.hasTranspond) {
            v.transpondOriginText =self.originWeibo.text;
            v.transpondOriginHostName = self.originWeibo.HostName;
        }
        else{
            v.transpondOriginText =@"";
            v.transpondOriginHostName = @"";
        }
    }
    if([[segue identifier] isEqualToString:@"commentSegue"]){
        replyCommentViewController *v=[segue destinationViewController];
        v.WeiboID = self.originWeibo.WeiboID;
        v.commentID = @"";
    }
}
@end
