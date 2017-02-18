//
//  IpadMainViewController.m
//  StudyTourMap
//
//  Created by 熙 程 on 14-4-12.
//  Copyright (c) 2014年 change. All rights reserved.
//
#define SEARCHURL       @"http://api.map.baidu.com/geocoder/v2/?output=json&ak=3b1684d26197edcecf9123bf8f9decf9&address="
#define DRIVEAPI        @"http://api.map.baidu.com/direction/v1?mode=driving"
#define AK              @"3b1684d26197edcecf9123bf8f9decf9"


#import "IpadMainViewController.h"
#import "BMapKit.h"
#import "NSString+EncodingUTF8Additions.h"
#import "Location.h"
#include <math.h>

@interface IpadMainViewController ()

@end

@implementation IpadMainViewController
@synthesize routeLocationArray;
@synthesize mapView;
@synthesize ground;
@synthesize overlayLocationsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //设置视图大小
    [self.view setFrame:CGRectMake(150, 20, 874, 724)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (routeLocationArray == nil) {
        routeLocationArray = [[NSMutableArray alloc]init];
    }
    if (overlayLocationsArray == nil) {
        overlayLocationsArray = [[NSMutableArray alloc]init];
    }
    tag = 0;
    
    mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    BMKSearch *search = [[BMKSearch alloc]init];
    search.delegate = self;
    mapView.delegate = self;
    BMKMapStatus *mapStatus = [[BMKMapStatus alloc]init];
    mapStatus.targetGeoPt = CLLocationCoordinate2DMake(32.128582,114.085491);//设置视图的起始中心点
    mapStatus.fLevel = 14;//改变缩放级别
    [mapView setMapStatus:mapStatus];
    [self.view addSubview:mapView];
    //地图准备
    routeLocationArray =[self routeAPIRquestOrigin:@"信阳" andDestination:@"驻马店"];
    
    //搜索路线
    for(int i = 0;i < routeLocationArray.count -1;i++)
    {
        Location *location1 = [routeLocationArray objectAtIndex:i];
        Location *location2 = [routeLocationArray objectAtIndex:i+1];
        CLLocationCoordinate2D coors[2] = {0};
                    coors[0].latitude = [location1 getLatitude];
                    coors[0].longitude = [location1 getLongtitude];
                    coors[1].latitude = [location2 getLatitude];
                    coors[1].longitude = [location2 getLongtitude];
                    BMKPolyline* polyline = [BMKPolyline polylineWithCoordinates:coors count:2];
                    [mapView addOverlay:polyline];
        
        //处理路线覆盖物移动的中间点
        //[overlayLocationsArray addObject:location1];
        //float num = sqrt(pow([location2 getLatitude] - [location1 getLatitude], 2)+pow([location2 getLongtitude] - [location1 getLongtitude],2))/0.0009;
        float num = 1.0;
        float thwortDur = ([location2 getLatitude] - [location1 getLatitude])/(5*num);
        float uprightDur = ([location2 getLongtitude] - [location1 getLongtitude])/(5*num);

        for(int j=0;j<5*num;j++){
            Location *middleLocation = [[Location alloc]init];
            [middleLocation setLongtitude:[location1 getLongtitude]+uprightDur*j andLatitude:[location1 getLatitude]+thwortDur*j];
            [overlayLocationsArray addObject:middleLocation];
        }
        if (i == routeLocationArray.count -2) {
            [overlayLocationsArray addObject:location2];
        }
        
//        NSString *middleOrigin = [NSString stringWithFormat:@"%f,%f",[location1 getLatitude],[location1 getLongtitude]];
//        NSString *middleDestination = [NSString stringWithFormat:@"%f,%f",[location2 getLatitude],[location2 getLongtitude]];
//        NSLog(@"middleOrigin=%@,middleDestination=%@",middleOrigin,middleDestination);
//        NSMutableArray *middleLocationArray = [self routeAPIRquestOrigin:middleOrigin andDestination:middleDestination];
    //NSLog(@"count=%d",middleLocationArray.count);
//        if (middleLocationArray.count >1) {
//    
//        for(int j = 0;j<middleLocationArray.count -1;j++)
//        {
//            Location *middleLocation1 = [middleLocationArray objectAtIndex:i];
//            Location *middleLocation2 = [middleLocationArray objectAtIndex:i+1];
//            NSLog(@"middleLat=%f,middleLng=%f",[location1 getLatitude],[location1 getLongtitude]);
//            CLLocationCoordinate2D coors[2] = {0};
//            coors[0].latitude = [middleLocation1 getLatitude];
//            coors[0].longitude = [middleLocation1 getLongtitude];
//            coors[1].latitude = [middleLocation2 getLatitude];
//            coors[1].longitude = [middleLocation2 getLongtitude];
//            BMKPolyline* polyline = [BMKPolyline polylineWithCoordinates:coors count:2];
//            [mapView addOverlay:polyline];
//        }
//            
//        }
    }
    //设置图片刷新频率
NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(overlayRun) userInfo:nil repeats:YES];
    [timer fire];
}

-(void)overlayRun
{
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [mapView removeOverlay:ground];
    Location *location = [overlayLocationsArray objectAtIndex:tag];
    CLLocationCoordinate2D coors;
    coors.latitude = [location getLatitude]+ 0.01;//往上偏移使覆盖物在路线中间
    coors.longitude = [location getLongtitude] - 0.01;//往左偏移使覆盖物在路线中间
    ground = [BMKGroundOverlay groundOverlayWithPosition:coors zoomLevel:14 anchor:CGPointMake(0.0f,0.0f) icon:[UIImage imageNamed:@"3.jpg"]];
    [mapView addOverlay:ground];
    tag = tag + 1;
    if (tag ==overlayLocationsArray.count-1) {
        tag = 0;
    }
    [UIView commitAnimations];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation//设置自定义覆盖物
{
    NSString *AnnotationViewID = @"renameMark";
    NSString *text;
    //if (newAnnotation == nil) {
    BMKPinAnnotationView *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    // 设置颜色
    ((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorRed;
    //设置可拖拽
    //((BMKPinAnnotationView*)newAnnotation).draggable = YES;
    UIView * customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200,300)];
    customView.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 200, 170)];
    
    if ([annotation.title isEqualToString:@"信阳"]) {
        text = @"信阳市，古称义阳、申州，又名“申城”，位于河南省最南部，东连安徽，南接湖北，为三省通衢，是江淮河汉间的战略要地，豫南的政治、经济、军事、文化、教育、交通中心，鄂豫皖区域性中心城市。";
    }
    else{
        text =@"河南，古称中原，简称“豫”，地处中国中东部，黄河中下游，省会郑州，因其大部分位于历史上的黄河以南，故名河南，与山东、河北、山西、陕西、湖北、安徽接壤，承东启西、联南望北。";
    }
    label.backgroundColor = [UIColor whiteColor];//设置label
    //label.lineBreakMode = NSLineBreakByCharWrapping;//实现文字多行显示
    ///////////////////////////////////////////////////////////////////////////////
    //设置字体大小根据label大小自动调整
    float maxHeight =170;//设置最大高度
    float minFontSize =9;
    float height;
    int fontSize = 31;//设置最大字号
    do {
        fontSize = fontSize - 1;
        UIFont *font =[UIFont fontWithName:@"Arial" size:fontSize];
        CGSize size = CGSizeMake(200, 300);
        //    获取当前文本的属性
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
        //ios7方法，获取文本需要的size，限制宽度
        CGSize  msgSie =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin/*| NSStringDrawingUsesFontLeading*/ attributes:tdic context:nil].size;
        height = msgSie.height;
    }while (height > maxHeight&&fontSize>minFontSize);
    
    label.text =text;
    if (fontSize ==9) {//判断字体是否小于最小字号，小于最小字号时就使用系统默认的缩略显示
        label.font = [UIFont fontWithName:@"Arial" size:15];
    }
    else{
        label.font = [UIFont fontWithName:@"Arial" size:fontSize];
        label.lineBreakMode = NSLineBreakByCharWrapping;//实现文字多行显示
        label.numberOfLines = 0;
    }
    //////////////////////////////////////////////////////////////////////////////////
    //设置按键
    UIButton* button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 270, 200, 30)];
    button1.backgroundColor = [UIColor whiteColor];
    [button1 setTitle:@"进入课程学习" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [button1 addTarget:self action:@selector(TranspondbtnClicked:event:)  forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    [imageView setImage:[UIImage imageNamed:@"xy.jpg"]];
    
    
    [customView addSubview:imageView];
    [customView addSubview:button1];
    [customView addSubview:label];
    BMKActionPaopaoView* test = [[BMKActionPaopaoView alloc]initWithCustomView:customView];
    ((BMKPinAnnotationView*)newAnnotation).paopaoView = test;
    return newAnnotation;
}



- (void)TranspondbtnClicked:(id)sender event:(id)event{//按下转发按钮响应事件
    //UIButton *button =(UIButton *)sender;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"videoShow" object:@"show"];
}

//API 请求函数
-(NSMutableArray *)routeAPIRquestOrigin:(NSString *)o andDestination:(NSString *)d
{
    NSString *region = [@"河南" URLEncodingUTF8String];
    NSString *originAddress = [o URLEncodingUTF8String];
    NSString *destinationAddress = [d URLEncodingUTF8String];
    NSMutableString  *geoAPIString = [[NSMutableString alloc]initWithFormat:@"%@&origin=%@&destination=%@&origin_region=%@&destination_region=%@&output=json&ak=%@",DRIVEAPI,originAddress,destinationAddress,region,region,AK];
    
    NSURL *urlstring = [NSURL URLWithString:geoAPIString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlstring cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    //从backString中获取到access_token
    NSError *error = nil;
    NSDictionary *firstDic = [NSJSONSerialization JSONObjectWithData:received options:kNilOptions error:&error];
    if (error!=nil) {
        NSLog(@"error=%@",error);
    }
    NSDictionary *secondDic = [firstDic objectForKey:@"result"];
    NSArray *routesArray = [secondDic objectForKey:@"routes"];
    NSDictionary *thirdDic = [routesArray objectAtIndex:0];
    NSArray *stepsArray = [thirdDic objectForKey:@"steps"];
    
    NSMutableArray *routeLocationArrayInside = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in stepsArray) {
        Location *location = [[Location alloc]init];
        NSDictionary *locationDic = [dic objectForKey:@"stepOriginLocation"];
        [location setLongtitude:[[locationDic objectForKey:@"lng"] floatValue] andLatitude:[[locationDic objectForKey:@"lat"] floatValue]];
        [routeLocationArrayInside addObject:location];
    }
    Location *locationDestination = [[Location alloc]init];
    NSDictionary *destinationDic =[thirdDic objectForKey:@"destinationLocation"];
    [locationDestination setLongtitude:[[destinationDic objectForKey:@"lng"] floatValue] andLatitude:[[destinationDic objectForKey:@"lat"] floatValue]];
     [routeLocationArrayInside addObject:locationDestination];
    //加入大头钉
    Location *tempLocation1 = [routeLocationArrayInside objectAtIndex:0];
    Location *tempLocation2 = [routeLocationArrayInside lastObject];
    CLLocationCoordinate2D coor;
    coor.latitude = [tempLocation1 getLatitude];
    coor.longitude = [tempLocation1 getLongtitude];
    BMKPointAnnotation* annotation1 = [[BMKPointAnnotation alloc]init];
    annotation1.coordinate = coor;
    annotation1.title = o;
    [mapView addAnnotation:annotation1];
    coor.latitude = [tempLocation2 getLatitude];
    coor.longitude = [tempLocation2 getLongtitude];
    BMKPointAnnotation* annotation2 = [[BMKPointAnnotation alloc]init];
    annotation2.coordinate = coor;
    annotation2.title = d;
    [mapView addAnnotation:annotation2];
    return routeLocationArrayInside;

}



- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKGroundOverlay class]]){
        BMKGroundOverlayView* groundView = [[BMKGroundOverlayView alloc] initWithOverlay:overlay];
        return groundView;
    }
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:0.5];
        polylineView.lineWidth = 5.0;
        return polylineView;
    }

    return nil;
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
