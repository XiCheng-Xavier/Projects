
//
//  DetailViewController.m
//  ShowGoodsSystem
//
//  Created by 熙 程 on 14-4-9.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize goodsInShoppingcart;
@synthesize attributeDic;
@synthesize attributeArr;
@synthesize imageView;
@synthesize nameLabel;
@synthesize attributeLabel;
@synthesize attributeTextField;
@synthesize numberTextField;
@synthesize priceLabel;
@synthesize scrollView;
@synthesize imageScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tag = 0;
    //传递goodsInShoppingcart到shoppingcartViewController
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(postGoodsArray) name:@"gotoShoppingcart" object:nil];
    [center addObserver:self selector:@selector(clearGoodsArray) name:@"completePay" object:nil];
    //接收master view 传参
    [center addObserver:self selector:@selector(prepareValue:) name:@"selectInfo" object:nil];
    NSString *text =[[NSString alloc]init];
    text = @"    大雪山位于云南临沧地区双江县勐库镇。若论普洱茶，必言大叶种，“勐库大叶茶，品种称英豪”，云南双江勐库镇是云南大叶种茶的发源地。勐库大叶种茶属乔木型、特大叶类、早芽种，在茶业界享有较高的美誉度。大雪山雄踞双江县勐库镇西北，是孕育勐库大叶茶的摇篮。勐库大雪山野生茶，外观油润呈深墨绿色、无毫。闻之有浓郁的山野夜来香的香气，茶性劲足霸道，存放时间短不宜多饮，特别适宜长期收藏贮存。因地处高山密林，原料采摘艰难，故产量极少。";
    CGSize size = CGSizeMake(760, 1000);
    UIFont *fonts = [UIFont systemFontOfSize:25.0];
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:fonts,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    CGSize  msgSie =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    //CGSize msgSie = [text sizeWithFont:fonts constrainedToSize:size lineBreakMode: NSLineBreakByCharWrapping];
    UILabel *introductionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 760, msgSie.height)];
    [introductionLabel setFont:[UIFont boldSystemFontOfSize:25]];
    introductionLabel.text = text;
    introductionLabel.textAlignment = NSTextAlignmentLeft;
    introductionLabel.lineBreakMode = NSLineBreakByCharWrapping;
    introductionLabel.numberOfLines = 0;
    [scrollView addSubview:introductionLabel];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, introductionLabel.frame.size.height);
    scrollView.delegate = self;
    //设置简介textLabel属性
    
    //设置图片点击函数
    UITapGestureRecognizer *imageSingleTapGus = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageSingleTap)];
    [imageSingleTapGus setNumberOfTapsRequired:1];
    [imageView addGestureRecognizer:imageSingleTapGus];
    imageView.userInteractionEnabled = YES;
    
//选择图片scollView
    imageScrollView.delegate = self;
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.showsVerticalScrollIndicator = NO;
    for (int i = 0; i<6; i++) {
        UIImageView *tempImageView = [[UIImageView alloc]initWithFrame:CGRectMake(200*i, 0, 200,imageScrollView.frame.size.height)];
        [tempImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]]];
        [imageScrollView addSubview:tempImageView];
    }
    [imageScrollView setContentSize:CGSizeMake(200*6, imageScrollView.frame.size.height)];
    //添加点击处理函数
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [imageScrollView addGestureRecognizer:singleTap];
    //声明白色边框
    pf = [[PicFrame alloc] initWithFrame:((UIImageView*)[imageScrollView.subviews objectAtIndex:0]).frame];
    [imageScrollView addSubview:pf];
    
    [self setViewElement];
    
    if(goodsInShoppingcart == nil){
        goodsInShoppingcart = [[NSMutableArray alloc]init];
    }


}

-(void)clearGoodsArray
{
    [goodsInShoppingcart removeAllObjects];
}

-(void)postGoodsArray
{
    if (goodsInShoppingcart.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"购物车为空" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }else
    {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"postGoodsArray" object:goodsInShoppingcart];
    }
}

-(void)setViewElement
{
    switch (section) {
        case 0:{
            [attributeLabel  setText:@"年份"];
            [nameLabel setText:[[[TeaOfXiaguan getItems] objectAtIndex:row] getName]];
            [imageView setImage:[UIImage imageNamed:@"tea1.jpg"]];
            //设置attribute TextLabel
            attributeDic = [[[TeaOfXiaguan getItems] objectAtIndex:row] getYearPriceDic];
            attributeArr = [[NSArray alloc]initWithArray:[self changeOrder:attributeDic]];
            attributeTextField.text = [NSString stringWithFormat:@"%@",[attributeArr objectAtIndex:0]];
            //得到词典中所有Value值
            //NSEnumerator * enumeratorValue = [attributeDic objectEnumerator];
            //快速枚举遍历所有Value的值
            //for (NSString *value in enumeratorValue) {
            //    NSLog(@"遍历Value的值: %@",value);
            //}
            
            break;
            
        }
        case 1:{
            [attributeLabel  setText:@"年份"];
            [nameLabel setText:[[[TeaOfDayi getItems] objectAtIndex:row] getName]];
            [imageView setImage:[UIImage imageNamed:@"tea2.jpg"]];
            //设置attribute TextLabel
            attributeDic = [[[TeaOfDayi getItems] objectAtIndex:row] getYearPriceDic];
            attributeArr = [[NSArray alloc]initWithArray:[self changeOrder:attributeDic]];
            attributeTextField.text = [NSString stringWithFormat:@"%@",[attributeArr objectAtIndex:0]];
            break;
        }
        case 2:{
            [attributeLabel  setText:@"年份"];
            [nameLabel setText:[[[ForeignWines getItems] objectAtIndex:row] getName]];
            [imageView setImage:[UIImage imageNamed:@"wine1.jpg"]];
            //设置attribute TextLabel
            attributeDic = [[[RedWines getItems] objectAtIndex:row] getYearPriceDic];
            attributeArr = [[NSArray alloc]initWithArray:[self changeOrder:attributeDic]];
            attributeTextField.text = [NSString stringWithFormat:@"%@",[attributeArr objectAtIndex:0]];
            break;
        }
        case 3:{
            [attributeLabel  setText:@"容量"];
            [nameLabel setText:[[[RedWines getItems] objectAtIndex:row] getName]];
            [imageView setImage:[UIImage imageNamed:@"wine2.jpeg"]];
            //设置attribute TextLabel
            attributeDic = [[[ForeignWines getItems] objectAtIndex:row] getVolumePriceDic];
            attributeArr = [[NSArray alloc]initWithArray:[self changeOrder:attributeDic]];
            attributeTextField.text = [NSString stringWithFormat:@"%@",[attributeArr objectAtIndex:0]];
            break;
        }
    }
    [numberTextField setText:@"1"];
    [self changePriceLabel];
}

-(void)viewWillAppear:(BOOL)animated
{
    //设置视图大小
    [self.view setFrame:CGRectMake(200, 44, 824, 724)];
}

-(void)imageSingleTap
{
    //传数据给MainViewController
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",tag],@"touchIndex",nil ];
    NSArray *arr =[[NSArray alloc]initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg", nil];
    [center postNotificationName:@"blowUp" object:arr userInfo:dic];

}

-(void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer
{
    CGFloat width = 200;
    
    CGPoint loc = [gestureRecognizer locationInView:imageScrollView];
    NSInteger touchIndex = floor(loc.x / width) ;
    [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",touchIndex+1]]];
    
    tag = touchIndex;
    
    if (touchIndex > 5) {
        return;
    }

    pf.frame = ((UIImageView*)[imageScrollView.subviews objectAtIndex:touchIndex]).frame;
    [pf setAlpha:0];
    [UIView animateWithDuration:0.2f animations:^(void){
        [pf setAlpha:.85f];
    }];
    
}


-(void)prepareValue:(NSNotification *)notification
{
    
    NSDictionary *dic = [notification userInfo];
    section = [[dic objectForKey:@"section"] intValue];
    row = [[dic objectForKey:@"row"]intValue];
    [self setViewElement];
}

-(void)changePriceLabel
{
    priceLabel.text =[NSString stringWithFormat:@"%d",[[attributeDic objectForKey:attributeTextField.text] integerValue]*[numberTextField.text integerValue]];
    
}
-(IBAction)addNumber:(id)sender
{
    numberTextField.text = [NSString stringWithFormat:@"%d",[numberTextField.text integerValue]+1];
    [self changePriceLabel];
}

-(IBAction)reduceNumber:(id)sender
{
    if (([numberTextField.text integerValue]-1) >=1) {
        numberTextField.text = [NSString stringWithFormat:@"%d",[numberTextField.text integerValue]-1];
        [self changePriceLabel];
    }
}

-(IBAction)changeAttributeToLeft:(id)sender
{
    
    // NSString *price =[attributeDic objectForKey:[NSString stringWithFormat:@"%@",attributeTextField.text]];
    if (index >0) {
        index = index -1;
        attributeTextField.text = [attributeArr objectAtIndex:index];
        numberTextField.text =@"1";
        [self changePriceLabel];
    }
}

-(IBAction)changeAttributeToRight:(id)sender
{
    if (index <attributeArr.count-1) {
        index = index +1;
        attributeTextField.text = [attributeArr objectAtIndex:index];
        numberTextField.text =@"1";
        [self changePriceLabel];
    }
    
}

-(IBAction)buyImmediately:(id)sender
{
    Goods *goods = [[Goods alloc]init];
    goods.name = nameLabel.text;
    goods.amount = numberTextField.text;
    goods.unitprice = [attributeDic objectForKey:attributeTextField.text];
    goods.price = priceLabel.text;
    goods.goodsImage = imageView.image;

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"postPayImmeInfo" object:goods];
    
}

-(IBAction)addToShoppingcart:(id)sender
{
    Goods *goods = [[Goods alloc]init];
    goods.name = nameLabel.text;
    goods.amount = numberTextField.text;
    goods.unitprice = [attributeDic objectForKey:attributeTextField.text];
    goods.price = priceLabel.text;
    goods.goodsImage = imageView.image;
    [goodsInShoppingcart addObject:goods];
}

-(IBAction)gotoShoppingcart:(id)sender
{
    if (goodsInShoppingcart.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"购物车为空" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
       
    }
}

-(NSMutableArray *)changeOrder:(NSDictionary *)d
{
    NSMutableArray *mut = [[NSMutableArray alloc]initWithCapacity:5];
    //得到词典中所有KEY值
    NSEnumerator * enumeratorKey = [attributeDic keyEnumerator];
    //快速枚举遍历所有KEY的值
    for (NSString *key in enumeratorKey) {
        [mut addObject:key];
    }
    //把年份信息按从小到大排序
    for (int i = 1; i<mut.count; i++) {
        NSString *temp =[mut objectAtIndex:i];
        for (int j = i - 1; j >= 0; j--) {
            if ([[mut objectAtIndex:j] integerValue] >= [temp integerValue]) {
                [mut setObject:[mut objectAtIndex:j] atIndexedSubscript:j+1];
                if (j==0) {
                    [mut setObject:temp atIndexedSubscript:0];break;
                }
            }else {
                [mut setObject:temp atIndexedSubscript:j+1];break;
            }
        }
    }
    return mut;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
