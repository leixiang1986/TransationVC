//
//  ViewController.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/13.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "ViewController.h"
#import "UIPanInteractiveTransition.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>
@property (nonatomic, weak) UIViewController *presentedVC;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactive;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%s",__func__);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%s",__func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"ViewController===touchesBegan");
    [self performSegueWithIdentifier:@"show1" sender:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *vc = segue.destinationViewController;
#warning 这里设置是自定义的还是全凭的
    vc.modalPresentationStyle = UIModalPresentationCustom;
//    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [vc.view addGestureRecognizer:panGesture];
    vc.transitioningDelegate = self;
    _presentedVC = vc;
}

/**
 * pan动画
 */
- (void)panAction:(UIPanGestureRecognizer *)gesture {

    CGPoint point = [gesture translationInView:self.presentedVC.view];
    NSLog(@"pointY:%f",point.y);
    CGFloat percent = (point.y / 300.0) <= 1 ? (point.y / 300.0) : 1;
    if (gesture.state == UIGestureRecognizerStateBegan) {
#warning 这里触发手势dismiss
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {

        [_interactive updateInteractiveTransition:percent];
        //        if (percent == 1) {
        //            [self finishInteractiveTransition];
        //        }
        NSLog(@"UIGestureRecognizerStateChanged:%f",percent);
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
        if (percent == 1) {
            [_interactive finishInteractiveTransition];
        }
        else {
            [_interactive cancelInteractiveTransition];
        }
        NSLog(@"UIGestureRecognizerStateEnded:%f",percent);
    }
    else if (gesture.state == UIGestureRecognizerStateCancelled) {
        [_interactive cancelInteractiveTransition];
        NSLog(@"UIGestureRecognizerStateCancelled:%f",percent);
    }
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {

    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{

    return self;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    UIPercentDrivenInteractiveTransition *interactive = [[UIPercentDrivenInteractiveTransition alloc] init];
    if (_presentedVC) {
        NSLog(@"有_presentedVC");
    }
    else {
        NSLog(@"没有_presentedVC");
    }
    _interactive = interactive;
    return interactive;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (fromVC.isBeingDismissed) {  //dismiss 动画没有弹簧效果  时间短
        return 0.25;
    }
    else {
        return 0.75;
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //1
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0];
    //2
    CGRect finalRect;
    if (toVC.isBeingPresented) {
        finalRect = [transitionContext finalFrameForViewController:toVC];
        toVC.view.frame = CGRectOffset(finalRect, 0, [[UIScreen mainScreen]bounds].size.height);
        if (toVC.modalPresentationStyle == UIModalPresentationCustom) {
            finalRect = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40);
        }

    }
    else {
        finalRect = [transitionContext finalFrameForViewController:toVC];
        finalRect = CGRectOffset(finalRect, 0, [[UIScreen mainScreen]bounds].size.height + 60);
    }


    //3 根据是present还是dismiss  是FullScreen还是custom对containerView添加不同的子view
    if (toVC.isBeingPresented) {
        NSLog(@"添加了");
        if (toVC.modalPresentationStyle == UIModalPresentationFullScreen) {
            [[transitionContext containerView]addSubview:toVC.view];
        }
        else {
            [[transitionContext containerView]addSubview:toVC.view];
        }
    }
    else {
        if (fromVC.modalPresentationStyle == UIModalPresentationFullScreen) {
            NSLog(@"dismiss添加了");
            [[transitionContext containerView]addSubview:toVC.view];
            [[transitionContext containerView]addSubview:fromVC.view];
        }
        else {
             [[transitionContext containerView]addSubview:fromVC.view];
        }
    }

    if (toVC.isBeingPresented) {
        if ( toVC.modalPresentationStyle == UIModalPresentationCustom) {
            //PresentingController消失时为NO
            [fromVC beginAppearanceTransition:NO animated:YES];
        }
    }
    else {
        if ( fromVC.modalPresentationStyle == UIModalPresentationCustom) {
            //PresentingController显示时为YES
            [toVC beginAppearanceTransition:YES animated:YES];
        }
    }


    if (toVC.isBeingPresented) { //
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.1 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
            if (toVC.isBeingPresented) {
                toVC.view.frame = finalRect;
                containerView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
            }
            else {
                fromVC.view.frame = finalRect;
                containerView.backgroundColor = [UIColor clearColor];
            }
        } completion:^(BOOL finished) {
//            if (fromVC.isBeingDismissed && fromVC.modalPresentationStyle == UIModalPresentationCustom) {
//                NSLog(@"移除了");
//                [fromVC.view removeFromSuperview];
//                [toVC endAppearanceTransition];
//            }
            if (toVC.modalPresentationStyle == UIModalPresentationCustom) {
                [fromVC endAppearanceTransition];
            }
            [transitionContext completeTransition:YES];
        }];
    }
    else {

        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            fromVC.view.frame = finalRect;
            containerView.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            if (fromVC.isBeingDismissed && fromVC.modalPresentationStyle == UIModalPresentationCustom) {
                NSLog(@"移除了");
                [fromVC.view removeFromSuperview];
                [toVC endAppearanceTransition];
            }
            [transitionContext completeTransition:YES];
        }];
    }
}

















@end
