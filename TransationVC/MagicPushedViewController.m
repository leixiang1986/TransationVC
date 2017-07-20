//
//  MagicPushedViewController.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/19.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "MagicPushedViewController.h"
#import "MovePopRestoreAnimationTransition.h"
#import "LXInteractiveTransition.h"

@interface MagicPushedViewController ()

@property (nonatomic, assign) UINavigationControllerOperation operation;
@property (nonatomic, strong) LXInteractiveTransition *popInteractiveTransition;    //pop的手势管理类
@end

@implementation MagicPushedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    _imageView.image = _image;
    LXInteractiveTransition *interactiveTransition = [LXInteractiveTransition interactiveTransitionWithTransitionType:(LXInteractiveTransitionTypePop) gestureDirection:(LXInteractiveTransitionGestureDirectionLeft)];
    [interactiveTransition addPanGestureForViewController:self];
    _popInteractiveTransition = interactiveTransition;
}




- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    NSLog(@"%s",__func__);
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"%s",__func__);
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    _operation = operation;
    return [MovePopRestoreAnimationTransition animationTransitionWithType:(operation)];
}


- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if (_operation == UINavigationControllerOperationPop) {
        return _popInteractiveTransition.interative ? _popInteractiveTransition : nil;
    }
    return nil;
}

- (void)dealloc {
    NSLog(@"magic pushedVC %s",__func__);
}

@end
