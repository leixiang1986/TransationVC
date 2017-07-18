//
//  PresentOneViewController.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/14.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "PresentOneViewController.h"
#import "LXInteractiveTransition.h"
#import "LXModalAninationTransition.h"
#import "PresentedOneViewController.h"

@interface PresentOneViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, weak) UIViewController *presentedVC;

@property (nonatomic, strong) LXInteractiveTransition *interactivePresent;
@end

@implementation PresentOneViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _interactivePresent = [LXInteractiveTransition interactiveTransitionWithTransitionType:(LXInteractiveTransitionTypePresent) gestureDirection:(LXInteractiveTransitionGestureDirectionUp)];
    __weak typeof(self)weakSelf = self;
    //设置手势present的方法
    _interactivePresent.presentConfig = ^{
        [weakSelf present];
    };
    [_interactivePresent addPanGestureForViewController:self];
}



/**
 * 手势开始时，通过presentConfig调用本方法，跳转并设置interactivePresentBlock，设置push的交互手势过程
 * 如果没有interactivePresentBlock返回interactivePresent,那么就没有滑动控制push的过程，滑动直接push
 */
- (void)present {
    NSLog(@"present");
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PresentedOneViewController *presentedVC = [storyBoard instantiateViewControllerWithIdentifier:@"presentedVC"];
    __weak typeof(self) weakSelf = self;
    //向presentedVC返回present动作的手势交互管理类
    presentedVC.interactivePresentBlock = ^id<UIViewControllerInteractiveTransitioning>{
        return weakSelf.interactivePresent;
    };
    [self presentViewController:presentedVC animated:YES completion:nil];
}



- (void)dealloc {
    NSLog(@"presentVC %s",__func__);
}



@end
