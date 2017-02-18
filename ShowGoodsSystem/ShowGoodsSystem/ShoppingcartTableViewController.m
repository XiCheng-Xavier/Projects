//
//  ShoppingcartTableViewController.m
//  ShowGoodsSystem
//
//  Created by 熙 程 on 14-4-10.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "ShoppingcartTableViewController.h"

@interface ShoppingcartTableViewController ()

@end

@implementation ShoppingcartTableViewController
@synthesize goodsArray;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView setFrame:CGRectMake(0, 0, 1024, 768)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (goodsArray == nil) {
        goodsArray = [[NSMutableArray alloc]init];
    }
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(cancelCell:) name:@"cancelGoodsInCart" object:nil];//注册自己为监听者observer
    

}
-(void)cancelCell:(NSNotification *)notification
{
    
    NSInteger tag = [[notification object]integerValue];
    [goodsArray removeObjectAtIndex:tag];
    [self.tableView reloadData];
}
-(void)addObserver//添加监听者
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(setValue:) name:@"postGoodsArray" object:nil];//注册自己为监听者observer
}

-(void)setValue:(NSNotification *)notification//接收DetailViewController传值
{
    goodsArray = [notification object];
    [self.tableView reloadData];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"shoppingcartValueOK" object:nil];
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
    return goodsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    ShoppingcartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    Goods *goods = [[Goods alloc]init];
    goods =[goodsArray objectAtIndex:[indexPath row]];
    cell.nameLabel.text = goods.name;
    cell.unitPriceLabel.text = goods.unitprice;
    cell.priceLabel.text = goods.price;
    cell.amountLabel.text = goods.amount;
    cell.goodsImageView.image = goods.goodsImage;
    cell.tag = indexPath.row;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section//改变haeder的高度美观画面
{
    return 150;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //高度无法改变，只能用heightForHeaderInSection委托方法改变高度
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 50)];
    UIButton *btnReturn = [[UIButton alloc]initWithFrame:CGRectMake(100, 50, 150, 50)];
    [btnReturn setTitle:@"返回" forState:UIControlStateNormal];
    [btnReturn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnReturn.layer.borderColor = [[UIColor grayColor] CGColor];
    btnReturn.layer.borderWidth = 1;
    [btnReturn.titleLabel setFont:[UIFont systemFontOfSize: 25]];
    [btnReturn addTarget:self action:@selector(returnToChoose)  forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btnReturn];
    UIButton *btnPrint = [[UIButton alloc]initWithFrame:CGRectMake(300, 50, 150, 50)];
    [btnPrint setTitle:@"打印订单" forState:UIControlStateNormal];
    [btnPrint setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnPrint.layer.borderColor = [[UIColor grayColor] CGColor];
    btnPrint.layer.borderWidth = 1;
    [btnPrint.titleLabel setFont:[UIFont systemFontOfSize: 25]];
    [btnPrint addTarget:self action:@selector(printOrderform)  forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btnPrint];
    if (section == 0){
        [headerView setBackgroundColor:[UIColor clearColor]];
    }
    return headerView;
}

-(void)returnToChoose
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"shoppingcartPopInfo" object:nil];
}
-(void)printOrderform
{
    if (goodsArray.count==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"订单为空" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [self returnToChoose];
    }else{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"订单确认" message:@"确定打印" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    [alert show];
    }
}
#pragma mark - alert view delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"shoppingcartPopInfo" object:nil];
        [center postNotificationName:@"completePay" object:nil];
        [goodsArray removeAllObjects];
        [self.tableView reloadData];
    }
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
