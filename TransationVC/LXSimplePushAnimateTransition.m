//
//  LXSimplePushAnimateTransition.m
//  TransationVC
//
//  Created by fuzzy@fdore.com on 2018/7/19.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "LXSimplePushAnimateTransition.h"

@implementation LXSimplePushAnimateTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.75;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:( UITransitionContextFromViewControllerKey)];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
   
    
    [UIView transitionFromView:fromVC.view toView:toVC.view duration:0.75 options:(UIViewAnimationOptionTransitionFlipFromRight) completion:^(BOOL finished) {
        BOOL result = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!result];
    }];
}


@end
