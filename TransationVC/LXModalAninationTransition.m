//
//  LXAninationTransition.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/17.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "LXModalAninationTransition.h"

@interface LXModalAninationTransition ()
@property (nonatomic, strong) id<UIViewControllerContextTransitioning>transitionContext;
@property (nonatomic, weak, readonly) UIViewController *fromVC;
@property (nonatomic, weak, readonly) UIViewController *toVC;
@property (nonatomic, weak, readonly) UIView *containerView;

@end


@implementation LXModalAninationTransition

#pragma mark - UIViewControllerAnimatedTransitioning 实现方法
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _transitionContext = transitionContext;
    _fromVC = [transitionContext viewControllerForKey:( UITransitionContextFromViewControllerKey)];
    _toVC = [transitionContext viewControllerForKey:( UITransitionContextToViewControllerKey)];
    _containerView = [transitionContext containerView];

    if (self.toVC.isBeingPresented) {   //present
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *contrainerView = [transitionContext containerView];

        UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
        tempView.frame = fromVC.view.frame;
        fromVC.view.hidden = YES;

        [contrainerView addSubview:tempView];
        [contrainerView addSubview:toVC.view];

        toVC.view.frame = CGRectMake(0, contrainerView.frame.size.height, contrainerView.frame.size.width, 500);
        NSLog(@"动画开始前");

#warning warning:时间通过transitionDuration:方法获取，在手势present时，如果写死时间动画不连贯
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:0 animations:^{
            toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
            tempView.transform = CGAffineTransformMakeScale(0.95, 0.95);
        } completion:^(BOOL finished) {
            BOOL complete = ![transitionContext transitionWasCancelled];
            NSLog(@"present动画完成%ld",complete);
            if (!complete) {
                [tempView removeFromSuperview];
                [toVC.view removeFromSuperview];
                fromVC.view.hidden = NO;
            }

            [transitionContext completeTransition:complete];
        }];
    }
    else {  //dismiss
        //注意在dismiss的时候fromVC就是vc2了，toVC才是VC1了，注意理解这个逻辑关系
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        //参照present动画的逻辑，present成功后，containerView的最后一个子视图就是截图视图，我们将其取出准备动画
        UIView *containerView = [transitionContext containerView];
        NSArray *subviewsArray = containerView.subviews;
        UIView *tempView = subviewsArray[MIN(subviewsArray.count, MAX(0, subviewsArray.count - 2))];
        //动画吧
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
            fromVC.view.transform = CGAffineTransformIdentity;
            tempView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                //失败了接标记失败
                [transitionContext completeTransition:NO];
            }else{
                //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
                [transitionContext completeTransition:YES];
                toVC.view.hidden = NO;
                [tempView removeFromSuperview];
            }
        }];


        
    }
}




/**
 * 动画时间
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:( UITransitionContextToViewControllerKey)];
    return toVC.isBeingPresented ? 0.55 : 0.25;
}



@end
