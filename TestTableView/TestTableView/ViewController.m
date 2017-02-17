//
//  ViewController.m
//  TestTableView
//
//  Created by 程熙 on 2/8/17.
//  Copyright © 2017 程熙. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_myLabel setText:@"Hello"];
    NSLog(@"Hello");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
