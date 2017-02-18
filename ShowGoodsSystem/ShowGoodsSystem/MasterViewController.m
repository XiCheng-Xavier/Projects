//
//  MasterViewController.m
//  ShowGoodsSystem
//
//  Created by 熙 程 on 14-4-9.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

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
    
    self.view.layer.borderWidth = 0.5;
    self.view.layer.borderColor = [[UIColor grayColor] CGColor];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view setFrame:CGRectMake(0, 44, 200, 728)];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identfier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:16];//设置字体大小
    if (indexPath.section == 0) {
        Tea *xiaguanTea =[[TeaOfXiaguan getItems] objectAtIndex:indexPath.row];
        cell.textLabel.text = [xiaguanTea getName];
        cell.imageView.image = [UIImage imageNamed:@"tea1.jpg"];
        return cell;
    }else if (indexPath.section == 1) {
        Tea *dayiTea =[[TeaOfDayi getItems] objectAtIndex:indexPath.row];
        cell.textLabel.text =[dayiTea getName];
        cell.imageView.image = [UIImage imageNamed:@"tea2.jpg"];
    }else if (indexPath.section == 2) {
        Wine *foreignWine = [[ForeignWines getItems] objectAtIndex:indexPath.row];
        cell.textLabel.text = [foreignWine getName];
        cell.imageView.image = [UIImage imageNamed:@"wine1.jpg"];
    }else{
        RedWine *redwine = [[RedWines getItems] objectAtIndex:indexPath.row];
        cell.textLabel.text = [redwine getName];
        cell.imageView.image = [UIImage imageNamed:@"wine2.jpeg"];
    }
    return cell;
}
#pragma mark - Table View Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

//设置cell header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 30;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"下关茶";
    }
    if (section == 1){
        return @"大益茶";
    }
    if (section == 2) {
        return @"红酒";
    }
    //if(section == 3)
    return @"洋酒";
    
}

//设置cell footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section//最后一个cell设置footer保持界面一致性
{
    if (section == 3) {
        return 20;
    }
    else{
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)indexPath.section],@"section",[NSString stringWithFormat:@"%ld",(long)indexPath.row],@"row",nil];
    [center postNotificationName:@"selectInfo" object:nil userInfo:dic];
    
}

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
