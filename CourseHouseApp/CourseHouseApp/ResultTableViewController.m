//
//  ResultTableViewController.m
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-24.
//  Copyright (c) 2014年 change. All rights reserved.
//
#define SEARCHURL           @"http://coursehouse.sinaapp.com/book.php/Book/index/productlist?page=1&k="
#import "ResultTableViewController.h"
#import "DetailViewController.h"

@interface ResultTableViewController ()

@end

@implementation ResultTableViewController
@synthesize resultsArray;
@synthesize keyWord;


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
    if (resultsArray ==nil) {
        resultsArray = [[NSMutableArray alloc]init];
    }
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBarTintColor: [UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1]];
    [self.navigationController.navigationBar setTranslucent:NO];//设置不透明
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; // 其上默认按钮（比如返回按钮）颜色
    //设置navigationBar字体
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    [self getData];
}
-(void)getData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc]
                                 initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
        [activityIndicatorView setCenter: self.view.center] ;
        [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray] ;
        [self.tableView addSubview : activityIndicatorView] ;
        [activityIndicatorView startAnimating];
        
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSString *url = [NSString stringWithFormat:@"%@%@",SEARCHURL,[keyWord URLEncodingUTF8String]];
        NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
        NSError* error = nil;
        NSArray *goods = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error != nil)
            return;
        for(NSDictionary *d in goods){
            Book *book = [[Book alloc]initWithTitle:[d objectForKey:@"Title"] andPrice:[d objectForKey:@"Price"] andImageURL:[d objectForKey:@"SmallImageUrl"] andAuthor:[d objectForKey:@"Author"] andSoldAmount:[d objectForKey:@"Score"] andDetailURL:[d objectForKey:@"DetailPageURL"]];
            [resultsArray addObject:book];
        }
    });
    dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
             [activityIndicatorView stopAnimating];
            
        });
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
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return resultsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Book *book = [resultsArray objectAtIndex:indexPath.row+1];
    cell.titleLabel.text = book.title;
    cell.priceLabel.text = book.price;
    cell.shopLabel.text = book.author;
    cell.soldAmountLabel.text = book.soldAmount;
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:book.imageURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:data];
        cell.bookImageView.image = image;
    });
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [self performSegueWithIdentifier:@"detail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *detail = [segue destinationViewController];
    Book *book =[resultsArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    detail.loadURL = book.detailURL;
    
}




@end
