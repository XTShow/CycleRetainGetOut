//
//  PresentVC.m
//  CycleRetainGetOut
//
//  Created by XTShow on 2018/3/22.
//  Copyright © 2018年 XTShow. All rights reserved.
//

#import "PresentVC.h"
#import "NSTimer+CycleRetainGetOut.h"

@interface PresentVC ()
@property (nonatomic,weak) NSTimer *timer;
@property (nonatomic,strong) NSMutableArray *timerArray;
@end

@implementation PresentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    [self useTimerInWeak];
//    [self checkTimerRelease];
}

-(void)dealloc{
    
    NSLog(@"%@%s",[self class],__func__);
    //常规使用
    NSLog(@"before-%@",self.timer);
    [self.timer invalidate];
    NSLog(@"after-%@",self.timer);
    
    //检测NSTimer的释放（checkTimerRelease）
//    for (NSTimer *timer in self.timerArray) {
//        [timer invalidate];
//    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)useTimerInWeak {
    
    __weak __typeof__(self)weakSelf = self;
    
    self.timer = [NSTimer XT_scheduledTimerWithTimeInterval:1 block:^{
        [weakSelf dosth];
    } userInfo:@"asd" repeats:YES];

}

- (void)checkTimerRelease {
    
    self.timerArray = [NSMutableArray array];
    
    __weak __typeof__(self)weakSelf = self;
    for (int i = 0; i < 10000; i++) {
        
        NSTimer *timer = [NSTimer XT_scheduledTimerWithTimeInterval:1 block:^{
            [weakSelf dosth];
        } userInfo:@"asd" repeats:YES];
        
        [self.timerArray addObject:timer];
    }
}

- (void)dosth {
    NSLog(@"%@在做事情",[self class]);
}
@end
