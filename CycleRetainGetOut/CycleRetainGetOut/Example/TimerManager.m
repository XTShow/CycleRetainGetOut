//
//  TimerManager.m
//  CycleRetainGetOut
//
//  Created by XTShow on 2018/3/23.
//  Copyright © 2018年 XTShow. All rights reserved.
//

#import "TimerManager.h"

@interface TimerManager()
@property (nonatomic,weak) NSObject *delegateObj;
@end

@implementation TimerManager

- (instancetype)initWithObj:(NSObject *)obj
{
    self = [super init];
    if (self) {
        self.delegateObj = obj;
        if ([obj isKindOfClass:[PresentVC class]]) {
            PresentVC *realobj = (PresentVC *)obj;
            realobj.delegate = self;
        }
    }
    return self;
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}

#pragma mark - PresentVCWeakTimerDelegate
-(void)useTimer:(NSTimer *)timer{
    NSString *selStr = timer.userInfo[@"SEL"];
    NSDictionary *para = timer.userInfo[@"para"];
    SEL selector = NSSelectorFromString(selStr);
    [self.delegateObj performSelector:selector withObject:para];
    
    //performSelector会报黄色警告，如有介意，替代方法如下
    //IMP imp = [self.delegateObj methodForSelector:selector];
    //void (*func)(id,SEL,NSDictionary *) = (void *)imp;
    //func(self.delegateObj,selector,para);
}
@end
