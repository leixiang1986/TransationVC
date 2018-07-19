//
//  PushedViewController.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/17.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "PushedViewController.h"
#import "LXNavigationAnimationTransition.h"
#import "LXInteractiveTransition.h"

@interface PushedViewController ()
@property (nonatomic, strong) LXInteractiveTransition *popInteractive;
@property (nonatomic, assign) UINavigationControllerOperation operation;
@end

@implementation PushedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"pushed";
    self.view.backgroundColor = [UIColor cyanColor];
    _popInteractive = [LXInteractiveTransition interactiveTransitionWithTransitionType:(LXInteractiveTransitionTypePop) gestureDirection:(LXInteractiveTransitionGestureDirectionRight)];
    [_popInteractive addPanGestureForViewController:self];
}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    if (_operation == UINavigationControllerOperationPush) {
        if (self.interactiveBlock) {
            LXInteractiveTransition *pushInteractive = self.interactiveBlock();
            if (pushInteractive.interative) {
                return pushInteractive;
            }
        }
    }
    else if (_operation == UINavigationControllerOperationPop) {
        return _popInteractive.interative ? _popInteractive : nil;
    }

    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    _operation = operation;
    if (operation == UINavigationControllerOperationPush) {
        return [LXNavigationAnimationTransition animationTransitionWithNavigationType:(LXNavigationAnimationTransitionTypePush)];
    }
    else {
        return [LXNavigationAnimationTransition animationTransitionWithNavigationType:(LXNavigationAnimationTransitionTypePop)];
    }
}





@end
