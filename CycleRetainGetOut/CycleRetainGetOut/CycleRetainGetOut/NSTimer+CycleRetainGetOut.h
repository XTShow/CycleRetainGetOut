//
//  NSTimer+CycleRetainGetOut.h
//  CycleRetainGetOut
//
//  Created by XTShow on 2018/3/22.
//  Copyright © 2018年 XTShow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (CycleRetainGetOut)
+ (NSTimer *)XT_scheduledTimerWithTimeInterval:(NSTimeInterval)ti block:(void(^)(void))block userInfo:(id)userInfo repeats:(BOOL)yesOrNo;
@end
