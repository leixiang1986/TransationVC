//
//  CircleSpreadPushedViewController.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "CircleSpreadPushedViewController.h"
#import "CircleSpreadAnimationTransition.h"

@interface CircleSpreadPushedViewController ()
@property (nonatomic, assign) UINavigationControllerOperation operation;
@end

@implementation CircleSpreadPushedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    


}


- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {

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
