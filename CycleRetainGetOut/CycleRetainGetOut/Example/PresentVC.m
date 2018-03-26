//
//  PresentVC.m
//  CycleRetainGetOut
//
//  Created by XTShow on 2018/3/22.
//  Copyright © 2018年 XTShow. All rights reserved.
//

#import "PresentVC.h"
#import "NSTimer+CycleRetainGetOut.h"
#import "TimerManager.h"

@interface PresentVC ()
@property (nonatomic,weak) NSTimer *timer;
@property (nonatomic,strong) NSMutableArray *timerArray;
@end

@implementation PresentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
//    [self useTimerInDelegate];
    [self useTimerInCategory];
//    [self checkTimerRelease];
//    [self checkTimerReleaseInTradition];
//    [self creatTimerInNewApi];
//    [self newOBj];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

    //4.checkTimerReleaseInTradition
//    for (NSTimer *timer in self.timerArray) {
//        [timer invalidate];
//    }
}

-(void)dealloc{
    
    NSLog(@"%s",__func__);
    
    //1.使用代理解耦（useTimerInDelegate）
//    [self.timer invalidate];
    
    //2.使用Category解耦（useTimerInCategory）
    NSLog(@"before-%@",self.timer);
    [self.timer invalidate];
    NSLog(@"after-%@",self.timer);
    
    //3.检测NSTimer的释放（checkTimerRelease）
//    for (NSTimer *timer in self.timerArray) {
//        [timer invalidate];
//    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - NSTimer调用方法
- (void)dosth:(NSDictionary *)dic {
    NSLog(@"%@:%@说自己%@已经20多年了",[self class],dic[@"name"],dic[@"age"]);
}

- (void)dosthWithTimer:(NSTimer *)timer {
    NSLog(@"%@:我在使用%@做事情",[self class],timer.userInfo);
}

- (void)dosth {
    NSLog(@"%@在做事情",[self class]);
}

#pragma mark - 为NSTimer解耦的方式

//使用代理解耦
- (void)useTimerInDelegate {
    
    //此处可以将TimerManager生成一个单例模式，全局所有的timer的处理都可以由他来进行，但此处为了演示manager的释放，故如此实现。
    //传入需求对象（一般就是当前self），注意此处被manager全局持有时，要使用weak修饰，不然manager和self相互持有，仍然无法释放。
    TimerManager *manager = [[TimerManager alloc] initWithObj:self];
    
    //千万不要讲self封入userInfo之中，因为timer和userInfo是强引用的关系，会破坏解耦的目的。
    NSDictionary *userInfo = @{
                               @"SEL":NSStringFromSelector(@selector(dosth:)),
                               @"para":@{
                                       @"name":@"XTShow",
                                       @"age":@"18"
                                       }
                               };
    
    //此处的target是代理对象，selector是代理协议中的方法
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.delegate selector:@selector(useTimer:) userInfo:userInfo repeats:YES];
}

//使用Category解耦
- (void)useTimerInCategory {
    
    __weak __typeof__(self)weakSelf = self;

    self.timer = [NSTimer XT_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        [weakSelf dosthWithTimer:timer];
    } userInfo:@"useTimerInCategory" repeats:YES];

}

//检测NSTimer是否真的被释放了
- (void)checkTimerRelease {
    
    self.timerArray = [NSMutableArray array];
    
    __weak __typeof__(self)weakSelf = self;
    for (int i = 0; i < 10000; i++) {
        
        NSTimer *timer = [NSTimer XT_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
            [weakSelf dosth];
        } userInfo:@"asd" repeats:YES];
        
        [self.timerArray addObject:timer];
    }
}

//检测传统方式下，NSTimer是否真的被释放了
- (void)checkTimerReleaseInTradition {
    
    self.timerArray = [NSMutableArray array];
    
    for (int i = 0; i < 10000; i++) {
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dosth) userInfo:nil repeats:YES];//即使此时repeats设置为NO，也不会释放内存
        
        [self.timerArray addObject:timer];
    }
}

//使用iOS10中新出现的api生产timer
- (void)creatTimerInNewApi {
    
    __weak __typeof__(self)weakSelf = self;
    for (int i = 0; i < 10000; i++) {
        
        if (@available(iOS 10.0, *)) {
            [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                [weakSelf dosth];
            }];
        } else {
            
        }
        
    }
}

//使用NSObject测试内存释放
- (void)newOBj {
    self.timerArray = [NSMutableArray array];
    for (int i = 0; i < 10000; i++) {
        NSObject *obj = [NSObject new];
        [self.timerArray addObject:obj];
    }
}

@end
