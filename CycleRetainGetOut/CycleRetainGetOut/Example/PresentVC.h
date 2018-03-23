//
//  PresentVC.h
//  CycleRetainGetOut
//
//  Created by XTShow on 2018/3/22.
//  Copyright © 2018年 XTShow. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PresentVCWeakTimerDelegate;

@interface PresentVC : UIViewController

@property (nonatomic,weak) id<PresentVCWeakTimerDelegate> delegate;

@end


@protocol PresentVCWeakTimerDelegate<NSObject>

@required
- (void)useTimer:(NSTimer *)timer;

@end
