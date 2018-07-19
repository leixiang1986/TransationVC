//
//  CircleSpreadAnimationTransition.h
//  TransationVC
//
//  Created by 雷祥 on 2017/7/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleSpreadAnimationTransition : NSObject<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>
+ (instancetype)animationTransitionWithType:(UINavigationControllerOperation)type ;
- (instancetype)initWithNavigationOperationType:(UINavigationControllerOperation)type ;
- (instancetype)init NS_UNAVAILABLE;
@end
