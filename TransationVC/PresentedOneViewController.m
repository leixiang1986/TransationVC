//
//  PresentedOneViewController.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/14.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "PresentedOneViewController.h"
#import "LXInteractiveTransition.h"
#import "LXModalAninationTransition.h"

@interface PresentedOneViewController ()
@property (nonatomic, strong) LXInteractiveTransition *interactiveDismiss;
@property (nonatomic, assign) BOOL interactive;
@end

@implementation PresentedOneViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _interactiveDismiss = [LXInteractiveTransition interactiveTransitionWithTransitionType:(LXInteractiveTransitionTypeDismiss) gestureDirection:(LXInteractiveTransitionGestureDirectionDown)] ;
    [_interactiveDismiss addPanGestureForViewController:self];
    _interactive = YES;
}

- (IBAction)dismissal:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {

    return _interactiveDismiss.interative ? _interactiveDismiss : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    if (self.interactivePresentBlock) {
        LXInteractiveTransition *interactivePrerent = self.interactivePresentBlock();
        return interactivePrerent.interative ? interactivePrerent : nil;
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {

    return [[LXModalAninationTransition alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[LXModalAninationTransition alloc] init];
}

- (void)dealloc {
    NSLog(@"PresentedOneViewController:%s",__func__);
}








@end
