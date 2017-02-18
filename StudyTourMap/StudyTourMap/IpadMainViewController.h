//
//  IpadMainViewController.h
//  StudyTourMap
//
//  Created by 熙 程 on 14-4-12.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface IpadMainViewController : UIViewController<BMKMapViewDelegate,BMKSearchDelegate>
{
    int tag;
}
@property(nonatomic,strong)NSMutableArray *routeLocationArray;
@property(nonatomic,strong)NSMutableArray *overlayLocationsArray;
@property(nonatomic,strong)BMKMapView* mapView;
@property(nonatomic,strong)BMKGroundOverlay *ground;
@end
