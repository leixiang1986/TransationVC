//
//  CircleSpreadAnimationTransition.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "CircleSpreadAnimationTransition.h"

@interface CircleSpreadAnimationTransition ()
@property (nonatomic, assign) UINavigationControllerOperation type;
@end

@implementation CircleSpreadAnimationTransition
+ (instancetype)animationTransitionWithType:(UINavigationControllerOperation)type {

    return [[self alloc] initWithNavigationOperationType:type];
}


- (instancetype)initWithNavigationOperationType:(UINavigationControllerOperation)type {
    if (self = [super init]) {
        _type = type;
    }

    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {

    return 0.75;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case UINavigationControllerOperationPush:
            [self pushAnimation:transitionContext];
            break;
        case UINavigationControllerOperationPop:
            [self popAniamtion:transitionContext];
            break;

        default:
            break;
    }
}

/**
 * push动画
 */
- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:(UITransitionContextFromViewControllerKey)];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    NSLog(@"view:%@",toVC.view);
    [containerView addSubview:toVC.view];

    CALayer *maskLayer = [CALayer layer];
    maskLayer.cornerRadius = 20;
    

    [transitionContext completeTransition:YES];

}

/**
 * pop动画
 */
- (void)popAniamtion:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:(UITransitionContextFromViewControllerKey)];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    NSLog(@"popAniamtion");
    [containerView addSubview:toVC.view];
    [transitionContext completeTransition:YES];
}


@end
