//
//  LXInteractiveTransition.h
//  TransationVC
//
//  Created by 雷祥 on 2017/7/14.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureConifg)();

typedef NS_ENUM(NSUInteger, LXInteractiveTransitionGestureDirection) {//手势的方向,滑动的有效方向
    LXInteractiveTransitionGestureDirectionLeft = 1 << 0,
    LXInteractiveTransitionGestureDirectionRight= 1 << 1,
    LXInteractiveTransitionGestureDirectionUp   = 1 << 2,
    LXInteractiveTransitionGestureDirectionDown = 1 << 3
};

typedef NS_ENUM(NSUInteger, LXInteractiveTransitionType) {//手势控制哪种转场
    LXInteractiveTransitionTypePresent = 0,
    LXInteractiveTransitionTypeDismiss,
    LXInteractiveTransitionTypePush,
    LXInteractiveTransitionTypePop,
};

@interface LXInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) CGFloat completePercent;  //完成的百分比，(0 ~ 1)，手势滑动多少算完成，默认0.65
@property (nonatomic, assign) BOOL interative;  //是否支持手势,在开始手势时设置为YES，手势结束或取消时，设置为NO
@property (nonatomic, copy) GestureConifg presentConfig;
@property (nonatomic, copy) GestureConifg pushConfig;

//初始化方式,设置滑动的有效方向
+ (instancetype)interactiveTransitionWithTransitionType:(LXInteractiveTransitionType)type gestureDirection:(LXInteractiveTransitionGestureDirection)direction;
- (instancetype)initWithTransitionType:(LXInteractiveTransitionType)type gestureDirection:(LXInteractiveTransitionGestureDirection)direction;

/**
 * 添加手势
 */
- (void)addPanGestureForViewController:(UIViewController *)viewController;
- (instancetype)init NS_UNAVAILABLE;

@end
