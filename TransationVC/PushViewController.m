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


@interface PushViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) LXInteractiveTransition *pushInteractive;
@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pushInteractive = [LXInteractiveTransition interactiveTransitionWithTransitionType:(LXInteractiveTransitionTypePush) gestureDirection:(LXInteractiveTransitionGestureDirectionLeft)];
    __weak typeof(self)weakSelf = self;
    _pushInteractive.pushConfig = ^{
        PushedViewController *pushedVC = [[PushedViewController alloc] init];
        [weakSelf.navigationController pushViewController:pushedVC animated:YES];
    };
}


- (IBAction)pushClick:(id)sender {
    PushedViewController *presentedVC = [[PushedViewController alloc] init];
    presentedVC.navigationController.delegate = self;
    [self.navigationController pushViewController:presentedVC animated:YES];
}







@end
