//
//  TimerManager.h
//  CycleRetainGetOut
//
//  Created by XTShow on 2018/3/23.
//  Copyright © 2018年 XTShow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PresentVC.h"

@interface TimerManager : NSObject
<
PresentVCWeakTimerDelegate
>

- (instancetype _Nonnull)initWithObj:(NSObject * _Nonnull)obj;
@end
