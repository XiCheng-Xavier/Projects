//
//  ViewController.m
//  dialog
//
//  Created by ioscourse  on 13-9-12.
//  Copyright (c) 2013年 ioscourse . All rights reserved.
//

#import "ViewController.h"
#import "Message.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize myToolbar;
@synthesize myButton;
@synthesize myTextField;
@synthesize tableView;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (!self.dialogMessages) {
        self.dialogMessages =[[NSMutableArray alloc]init];
    }
    const NSString *MsgKey = @"msg";
    const NSString *MineKey = @"ismine";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:path];
    
    [dataArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        Message *message = [[Message alloc] init];
        message.message = dict[MsgKey];
        message.isMine = [dict[MineKey] boolValue];
        [self.dialogMessages addObject:message];
    }];//读取字典中的数据
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 371)];
    tableView.delegate =self;
    tableView.dataSource =self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 372, 320, 44)];
    myTextField.delegate =self;
    myTextField = [[UITextField alloc] init];//初始化UITextField
    myTextField.frame = CGRectMake(0, 0, 250, 32);
    myTextField.delegate = self;//设置代理
    myTextField.borderStyle = UITextBorderStyleRoundedRect;
    myTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直居中
    myTextField.placeholder = @"请输入内容";//内容为空时默认文字
    myTextField.returnKeyType = UIReturnKeyDone;//设置放回按钮的样式
    myTextField.keyboardType = UIKeyboardTypeDefault;//设置键盘样式为默认
    
    UIBarButtonItem *textfieldButtonItem =[[UIBarButtonItem alloc]initWithCustomView:myTextField];
    UIBarButtonItem *sendMessageButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendMessage)];
    NSArray *textfieldArray=[[NSArray alloc]initWithObjects:textfieldButtonItem,sendMessageButtonItem,nil];
    [myToolbar setItems:textfieldArray];
    [self.view addSubview:tableView];
    [self.view addSubview:myToolbar];
    
    //注册键盘出现与隐藏时候的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboadWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

-(void)sendMessage{//完成输入响应函数 
    Message *newMessage =[[Message alloc]init];
    newMessage.message = [[NSString alloc]initWithString:myTextField.text];
    newMessage.isMine =YES;
    [self.dialogMessages addObject:newMessage];
    [tableView reloadData];
    NSUInteger rowCount = [tableView numberOfRowsInSection:0];//设置滚动到底部
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:rowCount-1 inSection:0];
    [tableView scrollToRowAtIndexPath:indexPath
                        atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    [myTextField resignFirstResponder];
    myTextField.text =@"";
    
}

//键盘出现时候调用的事件
-(void) keyboadWillShow:(NSNotification *)note{
    NSDictionary *info = [note userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//键盘的frame
    CGFloat offY = (416-keyboardSize.height)-myToolbar.frame.size.height;//屏幕总高度-键盘高度-myToolbar高度
    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
    [UIView setAnimationDuration:0.3];//设置动画时间 秒为单位
    myToolbar.frame =CGRectMake(0, offY, 320, 44);
    [UIView commitAnimations];//开始动画效果
    
}
//键盘消失时候调用的事件
-(void)keyboardWillHide:(NSNotification *)note{
    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
    [UIView setAnimationDuration:0.3];
    myToolbar.frame =CGRectMake(0, 372, 320, 44);
    [UIView commitAnimations];
}
//隐藏键盘方法
-(void)hideKeyboard{
    [myTextField resignFirstResponder];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-
#pragma mark UITabelViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dialogMessages count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message *msg = self.dialogMessages[indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize size =[msg.message sizeWithFont:font constrainedToSize:CGSizeMake(115, 400) lineBreakMode: NSLineBreakByCharWrapping];
    if (size.height < 55) {//判断对话框的高度，如果比头像矮就设置为头像高度，否则就设置为对话框的文本高度加上间隔
        return 55;
    }
    else{
    return size.height+25+5;//与边线的间隔加上文本的上下缩进
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float buttonHeight,buttonWidth;
    NSString *CellIdentifier=@"CellIdentifier";
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//消去边线
    Message *msg = self.dialogMessages[indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize size =[msg.message sizeWithFont:font constrainedToSize:CGSizeMake(115, 400) lineBreakMode: NSLineBreakByCharWrapping];//计算文本高度
    if (size.height <16) {
        CGSize sizeSec=[msg.message sizeWithFont:font constrainedToSize:CGSizeMake(500, 15) lineBreakMode: NSLineBreakByCharWrapping];
        buttonWidth=sizeSec.width +35;
    }
    else{
        buttonWidth = 150;
    }

    if (size.height <50) {//设置对话框高度
        buttonHeight = 50;
    }
    else{
        buttonHeight = size.height +25;
    }
    UIImage *normalImage,*highlightedImage;
    UIButton *dialogMessageButton =[[UIButton alloc]init];
    UIEdgeInsets insets;
    UIImage *headImage;
    UIImageView *headImageView =[[UIImageView alloc]init];
    if (msg.isMine ==true) {//判断信息来源，自己和别人的不一样的处理
        headImage =[UIImage imageNamed:@"me.jpg"];
        [headImageView setFrame:CGRectMake(5, 5, 50, 50)];
        normalImage = [UIImage imageNamed:@"mychat_normal"];
        highlightedImage = [UIImage imageNamed:@"mychat_focused"];
        insets = UIEdgeInsetsMake(10, 25, 15, 10);//设置文本的内边框，使文字与对话框更协调
        [dialogMessageButton setContentEdgeInsets:insets];//设置缩进
        [dialogMessageButton setFrame:CGRectMake(55, 5, buttonWidth, buttonHeight)];
        [dialogMessageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    }
    else{
        headImage =[UIImage imageNamed:@"mate.jpg"];
        [headImageView setFrame:CGRectMake(265, 5, 50, 50)];
        normalImage = [UIImage imageNamed:@"matechat_normal"];
        highlightedImage = [UIImage imageNamed:@"matechat_focused"];
        insets = UIEdgeInsetsMake(10, 10, 15, 25);//设置文本的内边框
        [dialogMessageButton setFrame:CGRectMake(320-buttonWidth-55, 5,buttonWidth, buttonHeight)];
        [dialogMessageButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    }
                                 
    [headImageView setImage:headImage];
    NSMutableString *buttonName =[[NSMutableString alloc]initWithFormat:@"%@",msg.message];
    [dialogMessageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    normalImage = [normalImage stretchableImageWithLeftCapWidth:normalImage.size.width*0.5 topCapHeight:normalImage.size.height*0.6];//设置图片拉伸区域
    highlightedImage = [highlightedImage stretchableImageWithLeftCapWidth:highlightedImage.size.width*0.5 topCapHeight:highlightedImage.size.height*0.6];//设置图片拉伸区域
    [dialogMessageButton setBackgroundImage:normalImage forState:UIControlStateNormal];//设置对话框图片
    [dialogMessageButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];//设置点击时对话框图片
    [dialogMessageButton setTitle:buttonName forState:UIControlStateNormal];
    [dialogMessageButton setContentEdgeInsets:insets];//设置缩进
    dialogMessageButton.titleLabel.font = font;
    dialogMessageButton.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    dialogMessageButton.titleLabel.numberOfLines = 0;
    [cell.contentView addSubview:headImageView];
    [cell.contentView addSubview:dialogMessageButton];
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [myTextField resignFirstResponder];
}
#pragma mark -
#pragma mark UITextFieldDelegate
//开始编辑：
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

//点击return按钮所做的动作：
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];//取消第一响应
    return YES;
}

//编辑完成：
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
}


@end
























