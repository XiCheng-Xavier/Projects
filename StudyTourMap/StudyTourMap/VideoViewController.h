//
//  VideoViewController.h
//  StudyTourMap
//
//  Created by 熙 程 on 14-4-14.
//  Copyright (c) 2014年 change. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PicFrame.h"
#import <MediaPlayer/MediaPlayer.h>
@interface VideoViewController : UIViewController<UIScrollViewDelegate>
{
    PicFrame *pf;
    int tag;
}
@property(nonatomic,strong)IBOutlet UIImageView *videoImageView;
@property(nonatomic,strong)IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong) MPMoviePlayerController *moviePlayer;
-(IBAction)returnToSubView:(id)sender;
@end
