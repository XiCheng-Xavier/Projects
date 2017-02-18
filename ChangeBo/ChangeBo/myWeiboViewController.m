//
//  myWeiboViewController.m
//  ChangeBo
//
//  Created by ioscourse  on 13-8-28.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import "myWeiboViewController.h"

@interface myWeiboViewController ()

@end

@implementation myWeiboViewController


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
    if (!self.WeiboItems) {
        self.WeiboItems = [NSMutableArray array];
    }
    page = 1;
    [self loadMyWeiboWithPage:page];
    [self addRefreshViewController];
}

-(void)loadMyWeiboWithPage:(int)page{
    NSString *pageString = [NSString stringWithFormat:@"%d",page];
    NSMutableString *commentsAPIString;
    
    commentsAPIString = [[NSMutableString alloc]initWithFormat:@"%@?access_token=%@&page=%@",USERS_TIMELINE,[infoOfWeibo returnAccessToken],pageString];
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        //同步POST请求
        NSURL *urlstring = [NSURL URLWithString:commentsAPIString];
        //创建请求
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlstring cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        
        //连接服务器
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        
        //从backString中获取到access_token
        NSError *error = nil;
        NSDictionary *dictionary= [NSJSONSerialization JSONObjectWithData:received options:kNilOptions error:&error];
        NSArray *array = [dictionary objectForKey:@"statuses"];
        
        for (NSDictionary *dic in array) {
            Weibo *w = [[Weibo alloc]initWithJsonDictionary:dic];
            [self.WeiboItems addObject:w];
        }
    });
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
    return [self.WeiboItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    Weibo *i=[[Weibo alloc]init];
    i=self.WeiboItems[indexPath.row];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
 cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    //转发按钮
    UIButton *transpondButton = [[UIButton alloc]init];
    NSMutableString *buttonName =[[NSMutableString alloc]initWithFormat:@"转发:%d",i.transpondCount];
    [transpondButton setTitle:buttonName forState:UIControlStateNormal];
    transpondButton.titleLabel.font    = [UIFont systemFontOfSize: 12];
    [transpondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    transpondButton.layer.borderWidth = 1;
    transpondButton.layer.borderColor = [UIColor lightGrayColor].CGColor;

    
    //评论按钮
    UIButton *commentButton = [[UIButton alloc]init];
    buttonName =[[NSMutableString alloc]initWithFormat:@"评论:%d",i.commentsCount];
    [commentButton setTitle:buttonName forState:UIControlStateNormal];
    commentButton.titleLabel.font    = [UIFont systemFontOfSize: 12];
    [commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    commentButton.layer.borderWidth = 1;
    commentButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
       //微博正文
    CGSize size = CGSizeMake(288, 180);
    UIFont *fonts = [UIFont systemFontOfSize:14.0];
    CGSize msgSie = [i.text sizeWithFont:fonts constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *WeiboTextLabel  = [[UILabel alloc] init];
    [WeiboTextLabel setFont:[UIFont boldSystemFontOfSize:14]];
    WeiboTextLabel.frame = CGRectMake(20,19, 280,msgSie.height);
    WeiboTextLabel.text = i.text;
    WeiboTextLabel.lineBreakMode = NSLineBreakByCharWrapping;//实现文字多行显示
    WeiboTextLabel.numberOfLines = 0;
    [cell.contentView addSubview:WeiboTextLabel];

    //发布时间
    UILabel *createdAtLabel = [[UILabel alloc]init];
    createdAtLabel.frame = CGRectMake(7, 0, 143, 18);
    NSRange range = NSMakeRange(4,15);
    NSString *created_at = [i.createdAt substringWithRange:range];//取出发布时间
    createdAtLabel.text =created_at;
    createdAtLabel.font = [UIFont systemFontOfSize:12];//文字大小
    createdAtLabel.textColor = [UIColor lightGrayColor];//文字颜色
    createdAtLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:createdAtLabel];
    
    //微博来源
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.frame = CGRectMake(166, 0, 143, 18);
    sourceLabel.text = i.source;
    sourceLabel.font = [UIFont systemFontOfSize:12];//文字大小
    sourceLabel.textColor = [UIColor lightGrayColor];//文字颜色
    sourceLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:sourceLabel];
    if (i.hasTranspond == true) {
        //对话图片
        UIImageView *dialogImageView = [[UIImageView alloc]init];
        dialogImageView.frame = CGRectMake(6,19+ WeiboTextLabel.frame.size.height,307,12);
        NSString *imageName = [NSString stringWithFormat:@"%@.png",@"transpondDialog"];
        dialogImageView.image = [UIImage imageNamed:imageName];
        
        //转发微博label
        UILabel *transpondWeiboTextLabel = [[UILabel alloc]init];
        CGSize size = CGSizeMake(288, 180);
        UIFont *fonts = [UIFont systemFontOfSize:14];
        NSMutableString *transponedNameAndText =[[NSMutableString alloc]initWithFormat:@"%@:%@",i.transpondedWeibo.HostName,i.transpondedWeibo.text];
        CGSize msgSie = [transponedNameAndText sizeWithFont:fonts constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        
        transpondWeiboTextLabel.frame = CGRectMake(20,19+11+ WeiboTextLabel.frame.size.height,280,msgSie.height);//label根据文字数量动态调整高度
        
        
        transpondWeiboTextLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;//边框颜色
        transpondWeiboTextLabel.layer.borderWidth = 1;//边框宽度
        
        transpondWeiboTextLabel.text =transponedNameAndText;//转发内容
        [transpondWeiboTextLabel setFont:[UIFont boldSystemFontOfSize:14]];
        transpondWeiboTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
        transpondWeiboTextLabel.numberOfLines = 0;
        transpondWeiboTextLabel.backgroundColor = [UIColor lightTextColor];
        [cell.contentView addSubview:transpondWeiboTextLabel];
        
        //转发有图
        if (i.haveTranspondImage) {
            UIImageView *WeiboImageView =[[UIImageView alloc]init];
            NSURL *url = [NSURL URLWithString:i.transpondedWeibo.thumbnailPic];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [[UIImage alloc] initWithData:data];
            WeiboImageView.image = image;
            WeiboImageView.frame = CGRectMake(160-(image.size.width/2),WeiboTextLabel.frame.origin.y + WeiboTextLabel.frame.size.height +transpondWeiboTextLabel.frame.size.height+12 +1, image.size.width,image.size.height);
            [cell.contentView addSubview:WeiboImageView];
            
            transpondWeiboTextLabel.layer.borderColor = [UIColor clearColor].CGColor;
            UILabel *dialog=[[UILabel alloc]init];
            dialog.frame = CGRectMake(20,19+11+ WeiboTextLabel.frame.size.height,280,msgSie.height + image.size.height+4);
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
        if (i.hasImage == true) {
            NSURL *url = [NSURL URLWithString:i.thumbnailPic];
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
    
    Weibo *i=[[Weibo alloc]init];
    i=self.WeiboItems[indexPath.row];
    CGSize size = CGSizeMake(288, 180);
    UIFont *fonts = [UIFont systemFontOfSize:14];
    CGSize msgSie = [i.text sizeWithFont:fonts constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    CGFloat height = msgSie.height + 24;
    if (i.hasTranspond == true) {
        NSMutableString *transponedNameAndText =[[NSMutableString alloc]initWithFormat:@"%@:%@",i.transpondedWeibo.HostName,i.transpondedWeibo.text];
        CGSize msgSieTranspond = [transponedNameAndText sizeWithFont:fonts constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        height = height + msgSieTranspond.height +12;//12是对话框的图的高度
        if (i.haveTranspondImage == true) {
            NSURL *url = [NSURL URLWithString:i.transpondedWeibo.thumbnailPic];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [[UIImage alloc] initWithData:data];
            height = height +image.size.height +1;
        }
    }
    else{
        if (i.hasImage == true) {
            NSURL *url = [NSURL URLWithString:i.thumbnailPic];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [[UIImage alloc] initWithData:data];
            height = height +image.size.height +1;
        }
    }
    height = height +31;//按钮高度
    
    return height;
}


-(void)addRefreshViewController{
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.refreshControl addTarget:self action:@selector(RefreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];
}

-(void)RefreshViewControlEventValueChanged{
    
    [self.refreshControl beginRefreshing];
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中..."];
    
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:1.0f];
}

-(void)reloadData{
    
    page = 1;
    self.WeiboItems =[[NSMutableArray alloc]init];
    [self loadMyWeiboWithPage:page];
    [self.tableView reloadData];
    if (self.refreshControl.refreshing == true) {
        
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    }
    
}

/*
 #pragma mark - Table view delegate
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Navigation logic may go here. Create and push another view controller.

 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
 // ...
 // Pass the selected object to the new view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 
 }
 */
@end
