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
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self presentViewController:[PresentVC new] animated:YES completion:nil];
}


@end
