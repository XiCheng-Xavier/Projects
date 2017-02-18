//
//  commentViewController.m
//  ChangeBo
//
//  Created by ioscourse  on 13-8-27.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import "commentViewController.h"

@interface commentViewController ()

@end

@implementation commentViewController

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
    hasChangeTag = YES;
    page = 1;
    
    if (!self.comments) {
        self.comments = [NSMutableArray array];
    }
    [self getCommentDataWithPage:page];
    [self addRefreshViewController];//下拉刷新
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getCommentDataWithPage:(int)p{
    NSString *pageString = [NSString stringWithFormat:@"%d", p];
    NSMutableString *commentsAPIString;
    if (hasChangeTag == YES) {
            commentsAPIString = [[NSMutableString alloc]initWithFormat:@"%@?access_token=%@&page=%@",COMMENTS,[infoOfWeibo returnAccessToken],pageString];
    }
    else{
            commentsAPIString = [[NSMutableString alloc]initWithFormat:@"%@?access_token=%@&page=%@",AT_COMMENTS,[infoOfWeibo returnAccessToken],pageString];
   }
    
    //同步POST请求
    NSURL *urlstring = [NSURL URLWithString:commentsAPIString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlstring cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    //从backString中获取到access_token
    NSError *error = nil;
    NSDictionary *dictionary= [NSJSONSerialization JSONObjectWithData:received options:kNilOptions error:&error];
    NSArray *array = [dictionary objectForKey:@"comments"];
    for (NSDictionary *d in array) {
        
        NSDictionary *user = [d objectForKey:@"user"];
        NSDictionary *status =[d objectForKey:@"status"];
        commentsItem *a =[[commentsItem alloc] initWithUserName:[user objectForKey:@"screen_name"] andComment:[d objectForKey:@"text"] andImageURL:[user objectForKey:@"profile_image_url"] andCommentID:[d objectForKey:@"id"] andCreateTime:[d objectForKey:@"created_at"] andWeiboID:[status objectForKey:@"id"]];
        [self.comments addObject:a];
    }

}

-(IBAction)pressChangeDisplayButton:(id)sender{
    page = 1;
    if (hasChangeTag ==YES) {
        hasChangeTag = FALSE;
                _changeDisplayButton.title = @"评论";
        [_comments removeAllObjects];
        [self getCommentDataWithPage:page];
        [self.tableView reloadData];
    }
else{
    hasChangeTag = YES;
    _changeDisplayButton.title =@"@我的评论";
    [_comments removeAllObjects];
    [self getCommentDataWithPage:page];
    [self.tableView reloadData];
}
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
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
  
    self.comments = [[NSMutableArray alloc] init];
    //重新回到第一页
    page = 1;
    [self getCommentDataWithPage:page];
    
    if (self.refreshControl.refreshing == true) {
        
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    commentsItem *i=self.comments[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    
    //评论正文
    CGSize size = CGSizeMake(288, 180);
    UIFont *fonts = [UIFont systemFontOfSize:14.0];
    CGSize msgSie = [i.Comment sizeWithFont:fonts constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *commentTextLabel  = [[UILabel alloc] init];
    [commentTextLabel setFont:[UIFont boldSystemFontOfSize:14]];
    commentTextLabel.frame = CGRectMake(20,70, 280,msgSie.height);
    commentTextLabel.text = i.Comment;
    commentTextLabel.lineBreakMode = NSLineBreakByCharWrapping;//实现文字多行显示
    commentTextLabel.numberOfLines = 0;
    [cell.contentView addSubview:commentTextLabel];
    
    //博主名字
    UILabel *hostNameLabel = [[UILabel alloc]init];
    hostNameLabel.frame = CGRectMake(97, 5, 150, 30);
    hostNameLabel.text = i.UserName;
    hostNameLabel.font = [UIFont systemFontOfSize:17];
    [hostNameLabel sizeToFit];
    [cell.contentView addSubview:hostNameLabel];
    
    //发布时间
    UILabel *createdAtLabel = [[UILabel alloc]init];
    createdAtLabel.frame = CGRectMake(97, 36, 218, 18);
    NSRange range = NSMakeRange(4,15);
    NSString *created_at = [i.CreateTime substringWithRange:range];//取出发布时间
    createdAtLabel.text =created_at;
    createdAtLabel.font = [UIFont systemFontOfSize:12];//文字大小
    createdAtLabel.textColor = [UIColor lightGrayColor];//文字颜色
    [cell.contentView addSubview:createdAtLabel];
    
    
    //头像照片
     dispatch_sync(dispatch_get_global_queue(0, 0), ^{
    UIImageView *hostImageView = [[UIImageView alloc]init];
    hostImageView.frame = CGRectMake(20,8, 52,52);
    NSURL *url = [NSURL URLWithString:i.ImageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    hostImageView.image = image;
    [cell.contentView addSubview:hostImageView];
     });
    return cell;

}

//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    commentsItem *i=self.comments[indexPath.row];
    CGSize size = CGSizeMake(288, 180);
    UIFont *fonts = [UIFont systemFontOfSize:14.0];
    CGSize msgSie = [i.Comment sizeWithFont:fonts constrainedToSize:size lineBreakMode: NSLineBreakByCharWrapping];
    return 70 + msgSie.height +3;
}
//滑到底刷新
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint contentOffsetPoint = self.tableView.contentOffset;
    
    CGRect frame = self.tableView.frame;
    
    if (contentOffsetPoint.y == self.tableView.contentSize.height - frame.size.height)
    {
        page =page +1;
        [self getCommentDataWithPage:page];
        [self.tableView reloadData];
    }
}

-(IBAction)pressRefresh:(id)sender{
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"回复",@"查看微博", nil];
    [alert show];
   //[self performSegueWithIdentifier:@"detailCommentSegue" sender:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self performSegueWithIdentifier:@"replySegue" sender:self];
    }
    else if(buttonIndex == 2)
    {
        [self performSegueWithIdentifier:@"originSegue" sender:self];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"replySegue"]) {
        NSIndexPath *index=[self.tableView indexPathForSelectedRow];
        commentsItem *i=self.comments[index.row];
        replyCommentViewController *v=[segue destinationViewController];
        v.commentID = i.CommentID;
        v.WeiboID = i.WeiboID;
    }
    if ([[segue identifier] isEqualToString:@"originSegue"]) {
        NSIndexPath *index=[self.tableView indexPathForSelectedRow];
        commentsItem *i=self.comments[index.row];
        originWeiboViewController *v=[segue destinationViewController];
        v.WeiboID = i.WeiboID;
    }
}
@end
