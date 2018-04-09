//
//  ViewController.m
//  CycleRetainGetOut
//
//  Created by XTShow on 2018/3/22.
//  Copyright © 2018年 XTShow. All rights reserved.
//

#import "ViewController.h"
#import "PresentVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [btn setCenter:self.view.center];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setTitle:@"Click,See Debug Area" forState:UIControlStateNormal];
    btn.titleLabel.numberOfLines = 0;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)present{
    [self presentViewController:[PresentVC new] animated:YES completion:nil];
}
@end
