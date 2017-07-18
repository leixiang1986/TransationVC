//
//  UIPanInteractiveTransition.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/13.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "UIPanInteractiveTransition.h"

@implementation UIPanInteractiveTransition

- (instancetype)initWithPresentedVC:(UIViewController *)presentedVC {
    self = [super init];
    if (self) {
        _presentedVC = presentedVC;
    }

    return self;
}


//- (void)cancelInteractiveTransition {
//    [super cancelInteractiveTransition];
//
//}




//startInteractiveTransition

//- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
//
//    NSLog(@"动画");
//
//}





@end
