//
//  NSTimer+CycleRetainGetOut.m
//  CycleRetainGetOut
//
//  Created by XTShow on 2018/3/22.
//  Copyright © 2018年 XTShow. All rights reserved.
//

#import "NSTimer+CycleRetainGetOut.h"
#import <objc/runtime.h>

static NSString * const BlockKey = @"BlockKey";
typedef void(^SelectorBlock)(void);

@interface NSTimer()

@property (nonatomic,copy) SelectorBlock block;

@end

@implementation NSTimer (CycleRetainGetOut)

- (void)setBlock:(SelectorBlock)block {
    objc_setAssociatedObject(self, &BlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (SelectorBlock)block {
    return objc_getAssociatedObject(self, &BlockKey);
}

+ (NSTimer *)XT_scheduledTimerWithTimeInterval:(NSTimeInterval)ti block:(void(^)(void))block userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    
    NSTimer *timer = [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(performBlock:) userInfo:userInfo repeats:yesOrNo];
    timer.block = block;

    return timer;
}

+ (void)performBlock:(NSTimer *)timer {
    if (timer.block) {
        timer.block();
    }
}

@end
