//
//  LXNavigationAnimationTransition.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/18.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "LXNavigationAnimationTransition.h"

@interface LXNavigationAnimationTransition ()

@property (nonatomic, assign) LXNavigationAnimationTransitionType type;
@end

@implementation LXNavigationAnimationTransition


+ (instancetype)animationTransitionWithNavigationType:(LXNavigationAnimationTransitionType)type {
    return [[self alloc] initWithNavigationType:type];
}


- (instancetype)initWithNavigationType:(LXNavigationAnimationTransitionType)type {
    self = [super init];
    if (self) {
        _type = type;
    }

    return self;
}


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.75;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case LXNavigationAnimationTransitionTypePush:
            [self pushAnimation:transitionContext];
            break;

        case LXNavigationAnimationTransitionTypePop:
            [self popAnimation:transitionContext];
            break;

        default:
            break;
    }
}


- (void)pushAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:( UITransitionContextFromViewControllerKey)];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    UIView *fromTempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
//    NSLog(@"fromTempView:%@",NSStringFromCGRect(fromTempView.frame));
    fromTempView.frame = fromVC.view.frame;
    fromVC.view.hidden = YES;
//    NSLog(@"pushshi:%@==\n%@==tempView:%@",fromVC.view,toVC.view,fromTempView);
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromTempView];
    [containerView bringSubviewToFront:fromTempView];
    [containerView insertSubview:toVC.view atIndex:0];
    fromTempView.layer.anchorPoint = CGPointMake(0, 0.5);
    fromTempView.layer.position = CGPointMake(0, containerView.frame.size.height * 0.5);

    CATransform3D transform3d = CATransform3DIdentity;
    transform3d.m34 = - 1 / 500.0;
    containerView.layer.sublayerTransform = transform3d;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromTempView.layer.transform = CATransform3DMakeRotation(-M_PI * 0.51, 0, 1, 0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            [fromTempView removeFromSuperview];
            fromVC.view.hidden = NO;
        }
    }];
}


- (void)popAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:( UITransitionContextFromViewControllerKey)];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
//    NSLog(@"popTempView:%@",tempView);
    [containerView addSubview:toVC.view];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.layer.transform = CATransform3DIdentity;
//        fromVC.view.subviews.lastObject.alpha = 1.0;
//        tempView.subviews.lastObject.alpha = 0.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if (![transitionContext transitionWasCancelled]) {
            [tempView removeFromSuperview];
            toVC.view.hidden = NO;
        }
    }];



}




@end
