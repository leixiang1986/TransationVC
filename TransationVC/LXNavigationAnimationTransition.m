//
//  LXNavigationAnimationTransition.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/18.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "LXNavigationAnimationTransition.h"

@implementation LXNavigationAnimationTransition


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.75;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *fromVC = [transitionContext viewControllerForKey:( UITransitionContextFromViewControllerKey)];





}


@end
