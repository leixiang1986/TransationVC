//
//  LXNavigationAnimationTransition.h
//  TransationVC
//
//  Created by 雷祥 on 2017/7/18.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LXNavigationAnimationTransitionType) {
    LXNavigationAnimationTransitionTypePush,
    LXNavigationAnimationTransitionTypePop
};

@interface LXNavigationAnimationTransition : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)animationTransitionWithNavigationType:(LXNavigationAnimationTransitionType)type;
- (instancetype)initWithNavigationType:(LXNavigationAnimationTransitionType)type;
- (instancetype)init NS_UNAVAILABLE;
@end
