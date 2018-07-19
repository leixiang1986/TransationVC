//
//  SimplePushedViewController.m
//  TransationVC
//
//  Created by fuzzy@fdore.com on 2018/7/19.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SimplePushedViewController.h"
#import "LXNavigationAnimationTransition.h"
#import "LXSimplePushAnimateTransition.h"

@interface SimplePushedViewController ()
@property (nonatomic, assign) BOOL showed;
@end

@implementation SimplePushedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.delegate = self;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (_hasCustomAnimation) {
        [UIView transitionFromView:fromVC.view toView:toVC.view duration:0.75 options:(UIViewAnimationOptionTransitionFlipFromRight) completion:^(BOOL finished) {
            
        }];
    }
    
    return nil;
    
    if (_showed) {

        return nil;
    }
    else {
        _showed = YES;

        LXSimplePushAnimateTransition *animation = [[LXSimplePushAnimateTransition alloc] init];
        return animation;
    }
}





@end
