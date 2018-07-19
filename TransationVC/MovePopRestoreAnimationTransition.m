//
//  MoveRestoreAnimationTransition.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/19.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "MovePopRestoreAnimationTransition.h"
#import "MagicMoveController.h"
#import "MagicPushedViewController.h"
#import "MagicCollectionViewCell.h"


@interface MovePopRestoreAnimationTransition ()
@property (nonatomic, assign) UINavigationControllerOperation type;
@end

@implementation MovePopRestoreAnimationTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {


    if (_type == UINavigationControllerOperationPush) {
        [self pushAnimation:transitionContext];
    }
    else if (_type == UINavigationControllerOperationPop) {
        [self popAnimation:transitionContext];
    }
}



/**
 * push动画
 */
- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    MagicMoveController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    MagicPushedViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSLog(@"MagicMoveController:%@",fromVC);
    UIView *containerView = [transitionContext containerView];
    MagicCollectionViewCell *cell = (MagicCollectionViewCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.selectIndexPath];
    UIView *tempView = [cell.imageView snapshotViewAfterScreenUpdates:NO];

    CGRect imageViewFrame = [toVC.imageView convertRect:toVC.imageView.bounds toView:toVC.view];

    CGRect cellFrame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
    tempView.frame = cellFrame;
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    cell.imageView.hidden = YES;
    toVC.view.alpha = 0.0;
    toVC.imageView.hidden = YES;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{

        tempView.frame = imageViewFrame;
        toVC.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        tempView.hidden = YES;
        toVC.imageView.hidden = NO;
    }];
}

/**
 * pop动画
 */
- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    MagicPushedViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    MagicMoveController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    MagicCollectionViewCell *cell = (MagicCollectionViewCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.selectIndexPath];
    UIView *tempView = containerView.subviews.lastObject;

    [containerView insertSubview:toVC.view atIndex:0];
    tempView.hidden = NO;
    cell.imageView.hidden = YES;
    fromVC.imageView.hidden = YES;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        CGRect cellFrame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
        tempView.frame = cellFrame;
        fromVC.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if (![transitionContext transitionWasCancelled]) { //完成
            [tempView removeFromSuperview];
            cell.imageView.hidden = NO;
        }
        else {  //取消
            tempView.hidden = YES;
            fromVC.imageView.hidden = NO;
        }
    }];
}



#pragma mark - 初始化
+ (instancetype)animationTransitionWithType:(UINavigationControllerOperation)type {
    return [[self alloc] initWithNavigationOperationType:type];
}

- (instancetype)initWithNavigationOperationType:(UINavigationControllerOperation)type {
    self = [super init];
    if (self) {
        _type = type;
    }

    return self;
}





@end
