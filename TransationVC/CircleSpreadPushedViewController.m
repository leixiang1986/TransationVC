//
//  CircleSpreadPushedViewController.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "CircleSpreadPushedViewController.h"
#import "CircleSpreadAnimationTransition.h"
#import "LXInteractiveTransition.h"

@interface CircleSpreadPushedViewController ()
@property (nonatomic, assign) UINavigationControllerOperation operation;
@property (nonatomic, strong) LXInteractiveTransition *poPinteractive;
@end

@implementation CircleSpreadPushedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _poPinteractive = [LXInteractiveTransition interactiveTransitionWithTransitionType:(LXInteractiveTransitionTypePop) gestureDirection:(LXInteractiveTransitionGestureDirectionDown)];
    [_poPinteractive addPanGestureForViewController:self];
}


- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {

    if (_operation == UINavigationControllerOperationPop) {
        return _poPinteractive.interative ? _poPinteractive : nil;
    }

    return nil;
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    _operation = operation;

    return [CircleSpreadAnimationTransition animationTransitionWithType:operation];

}

- (void)dealloc {
    NSLog(@"%s==%s",__FILE__,__func__);
}

@end
