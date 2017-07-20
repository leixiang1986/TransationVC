//
//  LXInteractiveTransition.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/14.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "LXInteractiveTransition.h"


@interface LXInteractiveTransition ()
@property (nonatomic, weak) UIViewController *vc;
@property (nonatomic, assign) LXInteractiveTransitionType type;
@property (nonatomic, assign) LXInteractiveTransitionGestureDirection direction;
@end

@implementation LXInteractiveTransition


+ (instancetype)interactiveTransitionWithTransitionType:(LXInteractiveTransitionType)type gestureDirection:(LXInteractiveTransitionGestureDirection)direction {
    return [[self alloc] initWithTransitionType:type gestureDirection:direction];
}


- (instancetype)initWithTransitionType:(LXInteractiveTransitionType)type gestureDirection:(LXInteractiveTransitionGestureDirection)direction {
    self = [super init];
    if (self) {
        _completePercent = 0.65;
        _direction = direction;
        _type = type;
    }
    return self;
}


- (void)addPanGestureForViewController:(UIViewController *)viewController {
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMoved:)];
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
}


- (void)panMoved:(UIPanGestureRecognizer *)gesture {
    CGFloat percent = 0;
    CGPoint transitionPoint = [gesture translationInView:gesture.view];
    CGFloat height = gesture.view.frame.size.height;
    CGFloat width = gesture.view.frame.size.width;
    switch (_direction) { //方向不同，计算百分比的方式不同
        case LXInteractiveTransitionGestureDirectionUp: //向上滑动有效
            percent = - transitionPoint.y / height;
            break;

        case LXInteractiveTransitionGestureDirectionDown: //向下滑动有效
            percent = transitionPoint.y / height;
            break;

        case LXInteractiveTransitionGestureDirectionLeft: //向左滑动有效
            percent = - transitionPoint.x / width;
            break;

        case LXInteractiveTransitionGestureDirectionRight: //向右滑动有效
            percent = transitionPoint.x / width;
            break;
    }

    percent = percent > 1 ? 1:percent;
//    NSLog(@"滑动百分比:%f",percent);
    CGPoint velocity = [gesture velocityInView:gesture.view];
//    NSLog(@"point:%@",NSStringFromCGPoint(velocity));
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.interative = YES;
            [self startGesture];
            break;

        case UIGestureRecognizerStateChanged:
//            NSLog(@"%f完成的百分比:%f",_completePercent,percent);
            [self updateInteractiveTransition:percent];
            break;

        case UIGestureRecognizerStateCancelled:
            self.interative = NO;
            [self cancelInteractiveTransition];
            NSLog(@"UIGestureRecognizerStateCancelled");
            break;

        case UIGestureRecognizerStateEnded:
            self.interative = NO;
            if (percent > _completePercent) {
                [self finishInteractiveTransition];
                NSLog(@"百分比结束");
            }
            else if (velocity.y > 1000 && ( LXInteractiveTransitionGestureDirectionDown == _direction)){
                [self finishInteractiveTransition];
                NSLog(@"向下速度快结束");
            }
            else if (velocity.y < -1000 && ( LXInteractiveTransitionGestureDirectionUp == _direction )){
                [self finishInteractiveTransition];
                NSLog(@"向上速度快结束");
            }
            else if (velocity.x > 800 && ( LXInteractiveTransitionGestureDirectionRight == _direction)){
                [self finishInteractiveTransition];
            }
            else if (velocity.x < -800 && ( LXInteractiveTransitionGestureDirectionLeft == _direction)){
                [self finishInteractiveTransition];
            }
            else{
                NSLog(@"cancelInteractiveTransition取消了");
                [self cancelInteractiveTransition];

            }
            break;

        default:
            NSLog(@"cancelInteractiveTransition取消了-");
                self.interative = NO;
                [self cancelInteractiveTransition];

            break;
    }
}

- (void)cancelInteractiveTransition {
    [super cancelInteractiveTransition];
    NSLog(@"==[super cancelInteractiveTransition]");
}
- (void)finishInteractiveTransition {
    [super finishInteractiveTransition];
    NSLog(@"==[super finishInteractiveTransition]");
}


/**
 * 开始时调用对应的方法
 */
- (void)startGesture {
    switch (_type) {
        case LXInteractiveTransitionTypePush:
            if (self.pushConfig) {
                self.pushConfig();
            }
            break;

        case LXInteractiveTransitionTypePop:
            [self.vc.navigationController popViewControllerAnimated:YES];
            break;

        case LXInteractiveTransitionTypePresent:
            if (self.presentConfig) {
                self.presentConfig();
            }
            break;

        case LXInteractiveTransitionTypeDismiss:
            [self.vc dismissViewControllerAnimated:YES completion:nil];
            break;

        default:
            break;
    }
}




@end
