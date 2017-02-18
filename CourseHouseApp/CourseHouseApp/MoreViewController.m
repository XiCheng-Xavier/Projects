//
//  MoreViewController.m
//  CourseHouseApp
//
//  Created by 熙 程 on 14-4-18.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize settingCatalog;
@synthesize moreTableView;


- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, 320, 50);
    //[self.tableView setFrame:CGRectMake(0, 0, 320, 600)];

}

-(void)viewWillAppear:(BOOL)animated
{
    //[self.tableView setFrame:CGRectMake(0, -50, 320, 600)];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    moreTableView.delegate = self;
    moreTableView.dataSource = self;
    settingCatalog = [[NSMutableArray alloc]initWithObjects:@"扫一扫",@"通用设置",@"意见反馈",@"版本更新（已是最新版本）",@"告诉朋友",@"新手帮助",@"关于我们",nil];
    //设置navigationBar字体大小、颜色
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    //设置navigationBar背景色
    [self.navigationController.navigationBar setBarTintColor: [UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1]];
    [self.navigationController.navigationBar setTranslucent:NO];//设置不透明
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; // 其上默认按钮（比如返回按钮）颜色

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

    return settingCatalog.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [settingCatalog objectAtIndex:indexPath.row];
    [cell.textLabel setTextColor:[UIColor colorWithRed:21.0/255 green:144.0/255 blue:66.0/255 alpha:1]];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
