//
//  CircleSpreadAnimationTransition.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "CircleSpreadAnimationTransition.h"
#import "CircleSpreadViewController.h"
#import "CircleSpreadPushedViewController.h"

@interface CircleSpreadAnimationTransition ()
@property (nonatomic, assign) UINavigationControllerOperation type;
@property (nonatomic, assign) CGPoint point;
@end

@implementation CircleSpreadAnimationTransition
+ (instancetype)animationTransitionWithType:(UINavigationControllerOperation)type  {

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
    CircleSpreadViewController *fromVC = [transitionContext viewControllerForKey:(UITransitionContextFromViewControllerKey)];
    CircleSpreadPushedViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    NSLog(@"view:%@",toVC.view);
    [containerView addSubview:toVC.view];
    UIButton *btn = fromVC.btn;

    CGFloat widthMax = MAX(btn.center.x, containerView.frame.size.width -  btn.center.x);
    CGFloat heightMax = MAX(btn.center.y, containerView.frame.size.height - btn.center.y);
    CGFloat radius = sqrtf(powf(widthMax, 2) + pow(heightMax, 2)); //shapelayer的半径
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    UIBezierPath *minPath = [UIBezierPath bezierPathWithOvalInRect:btn.frame];
    UIBezierPath *maxPath = [UIBezierPath bezierPathWithArcCenter:btn.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];

    maskLayer.path = maxPath.CGPath;
    maskLayer.bounds = toVC.view.bounds;
    maskLayer.position = CGPointMake(toVC.view.frame.size.width * 0.5, toVC.view.frame.size.height * 0.5);
    toVC.view.layer.mask = maskLayer;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id)minPath.CGPath;
    animation.toValue = (__bridge id)maxPath.CGPath;
    animation.duration = [self transitionDuration:transitionContext];
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [animation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:animation forKey:@"path"];
}

/**
 * pop动画
 */
- (void)popAniamtion:(id<UIViewControllerContextTransitioning>)transitionContext {
    CircleSpreadPushedViewController *fromVC = [transitionContext viewControllerForKey:(UITransitionContextFromViewControllerKey)];
    CircleSpreadViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    NSLog(@"popAniamtion");
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    fromVC.view.layer.mask = maskLayer;

    UIButton *btn = toVC.btn;
    CGFloat widthMax = MAX(btn.frame.origin.x, containerView.frame.size.width - btn.frame.origin.x);
    CGFloat heightMax = MAX(btn.frame.origin.y, containerView.frame.size.width - btn.frame.origin.y);
    CGFloat cornerRadius = sqrtf(powf(widthMax, 2) + powf(heightMax, 2));


    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:cornerRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:btn.frame];

    maskLayer.path = endPath.CGPath;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id)startPath.CGPath;
    animation.toValue = (__bridge id)endPath.CGPath;
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;
    [animation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:animation forKey:@"path"];

}



/**
 * animation的代理方法
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
    switch (_type) {
        case UINavigationControllerOperationPush:
        {
            [transitionContext completeTransition:YES];
        }

            break;
        case UINavigationControllerOperationPop:
        {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
        }

            break;


        default:
            break;
    }


}






@end
