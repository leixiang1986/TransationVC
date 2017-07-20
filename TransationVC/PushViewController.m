//
//  PushViewController.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/18.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "PushViewController.h"
#import "PushedViewController.h"
#import "LXInteractiveTransition.h"
#import "LXNavigationAnimationTransition.h"


@interface PushViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) LXInteractiveTransition *pushInteractive;
@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"push";
    _pushInteractive = [LXInteractiveTransition interactiveTransitionWithTransitionType:(LXInteractiveTransitionTypePush) gestureDirection:(LXInteractiveTransitionGestureDirectionLeft)];
    __weak typeof(self)weakSelf = self;
    _pushInteractive.pushConfig = ^{
//        PushedViewController *pushedVC = [[PushedViewController alloc] init];
        [weakSelf pushClick];
    };
    [_pushInteractive addPanGestureForViewController:self];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(backClick:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}


- (void)pushClick {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PushedViewController *pushedVC = [storyboard instantiateViewControllerWithIdentifier:@"pushedVC"];
    __weak typeof(self)weakSelf = self;
    pushedVC.interactiveBlock = ^id<UIViewControllerInteractiveTransitioning>{
        return weakSelf.pushInteractive;
    };
    self.navigationController.delegate = pushedVC; //导航栏的代理是push进去的控制器
    [self.navigationController pushViewController:pushedVC animated:YES];
}

/**
 * 返回事件
 */
- (void)backClick:(id)sender {
    self.navigationController.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

#warning 如果是点击就直接设置,如果是segue就设置
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PushedViewController *pushedVC = (PushedViewController *)segue.destinationViewController;
    __weak typeof(self)weakSelf = self;
    //1,向pushedVC传递手势交互类
    pushedVC.interactiveBlock = ^id<UIViewControllerInteractiveTransitioning>{
        return weakSelf.pushInteractive;
    };
    //2,设置导航控制器代理为pushedVC
    self.navigationController.delegate = pushedVC; //导航栏的代理是push进去的控制器
}






@end
