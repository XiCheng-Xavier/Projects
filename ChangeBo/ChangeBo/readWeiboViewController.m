//
//  readWeiboViewController.m
//  ChangeBo
//
//  Created by ioscourse  on 13-8-27.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import "readWeiboViewController.h"
#import "AppDelegate.h"

@interface readWeiboViewController (){
    int page;
    int tag;
    UIView *background;
    UIImageView *scaleImageView;
}

@end

@implementation readWeiboViewController

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
    tag = 0;
    [self loadWeiboDataWithPage:page];
    [self addRefreshViewController];
}

-(void)loadWeiboDataWithPage:(int)page{
    NSString *pageString = [NSString stringWithFormat:@"%d",self->page];
    NSMutableString *commentsAPIString;
    
    commentsAPIString = [[NSMutableString alloc]initWithFormat:@"%@?access_token=%@&page=%@",FRIENDS_TIMELINE,[infoOfWeibo returnAccessToken],pageString];
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
    [self loadWeiboDataWithPage:page];
     [self.tableView reloadData];
    if (self.refreshControl.refreshing == true) {
        
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    }
    
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint contentOffsetPoint = self.tableView.contentOffset;
    
    CGRect frame = self.tableView.frame;
    
    if (contentOffsetPoint.y == self.tableView.contentSize.height - frame.size.height)
    {
        page =page +1;
        [self loadWeiboDataWithPage:page];
        [self.tableView reloadData];
    }
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
    cell.tag = [indexPath row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    //转发按钮
    UIButton *transpondButton = [[UIButton alloc]init];
    NSMutableString *buttonName =[[NSMutableString alloc]initWithFormat:@"转发:%d",i.transpondCount];
    [transpondButton setTitle:buttonName forState:UIControlStateNormal];
    transpondButton.titleLabel.font    = [UIFont systemFontOfSize: 12];
    [transpondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    transpondButton.layer.borderWidth = 1;
    transpondButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    transpondButton.tag = indexPath.row;
    [transpondButton addTarget:self action:@selector(TranspondbtnClicked:event:)  forControlEvents:UIControlEventTouchUpInside];
 
    //评论按钮
    UIButton *commentButton = [[UIButton alloc]init];
    buttonName =[[NSMutableString alloc]initWithFormat:@"评论:%d",i.commentsCount];
    [commentButton setTitle:buttonName forState:UIControlStateNormal];
    commentButton.titleLabel.font    = [UIFont systemFontOfSize: 12];
    [commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    commentButton.layer.borderWidth = 1;
    commentButton.layer.borderColor = [UIColor lightGrayColor].CGColor;

    [commentButton addTarget:self action:@selector(CommentbtnClicked:event:)
            forControlEvents:UIControlEventTouchUpInside];
    
    //微博正文
    CGSize size = CGSizeMake(280, 180);
    UIFont *fonts = [UIFont systemFontOfSize:14.0];
    CGSize msgSie = [i.text sizeWithFont:fonts constrainedToSize:size lineBreakMode: NSLineBreakByCharWrapping];
    UILabel *WeiboTextLabel  = [[UILabel alloc] init];
    [WeiboTextLabel setFont:[UIFont boldSystemFontOfSize:14]];
    WeiboTextLabel.frame = CGRectMake(20,70, 280,msgSie.height);
    WeiboTextLabel.text = i.text;
    //WeiboTextLabel.textAlignment = UITextAlignmentCenter;
    WeiboTextLabel.lineBreakMode = NSLineBreakByCharWrapping;//实现文字多行显示
    WeiboTextLabel.numberOfLines = 0;
    [cell.contentView addSubview:WeiboTextLabel];

    //博主名字
    UILabel *hostNameLabel = [[UILabel alloc]init];
    hostNameLabel.frame = CGRectMake(97, 0, 150, 30);
    hostNameLabel.text = i.HostName;
    hostNameLabel.font = [UIFont systemFontOfSize:17];
    [hostNameLabel sizeToFit];
    [cell.contentView addSubview:hostNameLabel];
    
    //发布时间
    UILabel *createdAtLabel = [[UILabel alloc]init];
    createdAtLabel.frame = CGRectMake(97, 30, 218, 18);
    NSRange range = NSMakeRange(4,15);
    NSString *created_at = [i.createdAt substringWithRange:range];//取出发布时间
    createdAtLabel.text =created_at;
    createdAtLabel.font = [UIFont systemFontOfSize:12];//文字大小
    createdAtLabel.textColor = [UIColor lightGrayColor];//文字颜色
    [cell.contentView addSubview:createdAtLabel];
    
    //微博来源
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.frame = CGRectMake(97, 47, 223, 19);
    sourceLabel.text = i.source;
    sourceLabel.font = [UIFont systemFontOfSize:12];//文字大小
    sourceLabel.textColor = [UIColor lightGrayColor];//文字颜色
    [cell.contentView addSubview:sourceLabel];
    
    //头像照片
     dispatch_sync(dispatch_get_global_queue(0, 0), ^{
    UIImageView *hostImageView = [[UIImageView alloc]init];
    hostImageView.frame = CGRectMake(20,9, 52,52);
    NSURL *url = [NSURL URLWithString:i.HostHeadImageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    hostImageView.image = image;
    [cell.contentView addSubview:hostImageView];
     });
    
    if (i.hasTranspond == true) {
        //对话图片
        UIImageView *dialogImageView = [[UIImageView alloc]init];
        dialogImageView.frame = CGRectMake(6,70+ WeiboTextLabel.frame.size.height,307,12);
        NSString *imageName = [NSString stringWithFormat:@"%@.png",@"transpondDialog"];
        dialogImageView.image = [UIImage imageNamed:imageName];
        
        //转发微博label
        UILabel *transpondWeiboTextLabel = [[UILabel alloc]init];
        CGSize size = CGSizeMake(280, 180);
        UIFont *fonts = [UIFont systemFontOfSize:14];
        NSMutableString *transponedNameAndText =[[NSMutableString alloc]initWithFormat:@"%@:%@",i.transpondedWeibo.HostName,i.transpondedWeibo.text];
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
    if (i.haveTranspondImage) {
        UIImageView *WeiboImageView =[[UIImageView alloc]init];
        WeiboImageView.tag = [indexPath row];
        
        NSURL *url = [NSURL URLWithString:i.transpondedWeibo.thumbnailPic];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:data];
        WeiboImageView.image = image;
        WeiboImageView.frame = CGRectMake(160-(image.size.width/2),WeiboTextLabel.frame.origin.y + WeiboTextLabel.frame.size.height +transpondWeiboTextLabel.frame.size.height+12 +1, image.size.width,image.size.height);
        //添加图片放大手势
        WeiboImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnify:)] ;
        [WeiboImageView addGestureRecognizer:singleTap];
            
        
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
        if (i.hasImage == true) {
            NSURL *url = [NSURL URLWithString:i.thumbnailPic];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [[UIImage alloc] initWithData:data];
            UIImageView *WeiboImageView=[[UIImageView alloc]init];
            WeiboImageView.tag = [indexPath row];//设置标签用于之后的放大
           
            WeiboImageView.image = image;
            WeiboImageView.frame = CGRectMake(160-(image.size.width/2),WeiboTextLabel.frame.origin.y + WeiboTextLabel.frame.size.height +1,image.size.width,image.size.height);
            //添加图片放大手势
            WeiboImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnify:)] ;
           
            [WeiboImageView addGestureRecognizer:singleTap];
            
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
    CGSize msgSie = [i.text sizeWithFont:fonts constrainedToSize:size lineBreakMode: NSLineBreakByCharWrapping];
    CGFloat height = msgSie.height + 75;
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

- (void)TranspondbtnClicked:(id)sender event:(id)event{//按下转发按钮响应事件
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    NSInteger row = [indexPath row];
    tag = row;
    [self performSegueWithIdentifier:@"transpondSegue" sender:nil];

}

- (void)CommentbtnClicked:(id)sender event:(id)event{//按下评论按钮响应事件
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    NSInteger row = [indexPath row];
    tag = row;
    [self performSegueWithIdentifier:@"commentSegue" sender:nil];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender//跳转到转发/评论输入界面
{
        Weibo *i=self.WeiboItems[tag];

   if([[segue identifier] isEqualToString:@"transpondSegue"]){
   transpondViewController *v=[segue destinationViewController];
   v.WeiboID = i.WeiboID;
   v.transpondOriginText = i.text;
   v.transpondOriginHostName = i.HostName;
   }
   if([[segue identifier] isEqualToString:@"commentSegue"]){
        replyCommentViewController *v=[segue destinationViewController];
        v.WeiboID = i.WeiboID;
       v.commentID = @"";
    }
}

//图片放大
- (void)magnify:(id)sender 
{
    UITapGestureRecognizer *guesture = (UITapGestureRecognizer *)sender;
    UIImageView *myImageView = (UIImageView *)guesture.view;//guesture.view为添加guestureRecognizer的view
    NSInteger row = myImageView.tag;//取得tag即indexPath.row
   
    /*NSIndexPath *indexpath;
   
    for (UITableViewCell *cell in [self.tableView visibleCells]) {//查找可见视图中tag一样的cell，取得对应indexPath.row
        if (cell.tag == myImageView.tag) {
            indexpath = [self.tableView indexPathForCell:cell];
        }
    }*/

    NSURL *url;
    Weibo *weibo = [self.WeiboItems objectAtIndex:row];
    if (weibo.hasTranspond) {
        url = [NSURL URLWithString:weibo.transpondedWeibo.originalPic];
    }else{
        url = [NSURL URLWithString:weibo.originalPic];
    }

    NSData *data = [NSData dataWithContentsOfURL:url];
    //创建显示图像视图
    
    UIImage *bigImage =[[UIImage alloc] initWithData:data];
    
     CGPoint point = [self.tableView contentOffset];
    
    float imageWidth,imageHeight,positionX = 0,positionY = 0,imageViewHeight;
    if (bigImage.size.width > 320) {
        imageWidth = 320;
        imageHeight = 320*bigImage.size.height/bigImage.size.width;
    }else{
        imageWidth = bigImage.size.width;
        imageHeight = bigImage.size.height;
        positionX = ([ UIScreen mainScreen ].applicationFrame.size.width - imageWidth)/2;
    }
    if (imageHeight < [ UIScreen mainScreen ].applicationFrame.size.height) {
        positionY = ([ UIScreen mainScreen ].applicationFrame.size.height - imageHeight)/2;
        imageViewHeight = [ UIScreen mainScreen ].applicationFrame.size.height;
    }else{
        imageViewHeight = imageHeight;
        [self.tableView   setContentInset:UIEdgeInsetsMake(point.y, 0, 0, 0)];
        [self.tableView setContentSize:CGSizeMake(320, imageViewHeight)];

    }
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(positionX, positionY, imageWidth,imageHeight)];
    [imgView setImage:bigImage];
    
    scaleImageView = imgView;
    imgView.userInteractionEnabled = YES;//设置允许用户交互然后可添加guestureRecognizer
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(restore)] ;
    [imgView addGestureRecognizer:singleTap];

    self.tableView.scrollEnabled = NO;//设置原tableview使其不能滚动
   
    [self.tabBarController.view  setFrame:CGRectMake(0, 0, 320, 700)];
    //创建灰色透明背景，使其背后内容不可操作

    UIScrollView *bgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,20+point.y, 320,[UIScreen mainScreen].applicationFrame.size.height)];
    [bgView setContentSize:CGSizeMake(320, imageViewHeight)];
    bgView.scrollEnabled = YES;
    bgView.delegate = self;
    bgView.minimumZoomScale=0.1;//设置放大缩小倍数
    bgView.maximumZoomScale=2.0;

    background = bgView;
    [bgView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:bgView];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];//隐藏navigation bar
   
    [bgView addSubview:imgView];
    
    }
//再点击图片还原
-(void)restore
{
    [background removeFromSuperview];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tabBarController.view  setFrame:CGRectMake(0, 0,320, 480)];
    [self.navigationController.navigationBar setFrame:CGRectMake(0,20,320, 44)];
    self.tableView.scrollEnabled = YES;
}

#pragma mark - ScrollView Delegate
//图片放大返回imageView
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    [scaleImageView setCenter:CGPointMake(160, [UIScreen mainScreen].applicationFrame.size.height/2)];
    return scaleImageView;//UIImageView对象
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
     //<#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"// ...
     // Pass the selected object to the new view controller.
     //[self.navigationController pushViewController:detailViewController animated:YES];
     
}

@end
