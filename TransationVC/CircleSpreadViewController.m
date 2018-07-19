//
//  CircleSpreadViewController.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/20.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "CircleSpreadViewController.h"
#import "CircleSpreadPushedViewController.h"

@interface CircleSpreadViewController ()

@end

@implementation CircleSpreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    CGRect btnFrame = CGRectZero;
    btnFrame.size = CGSizeMake(40, 40);
    btnFrame.origin = self.view.center;
    btn.frame = btnFrame;

    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    btn.titleLabel.numberOfLines = 2;
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    [btn.layer setCornerRadius:20];
    btn.clipsToBounds = YES;
    [btn setTitle:@"点击或\n拖动我" forState:(UIControlStateNormal)];
    [self.view addSubview:btn];
    _btn = btn;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveGesture:)];
    [btn addGestureRecognizer:pan];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:(UIBarButtonItemStylePlain) target:self action:@selector(backClick)];
}

/**
 * 移动手势
 */
- (void)moveGesture:(UIPanGestureRecognizer *)gesture {
    UIButton *btn = (UIButton *)gesture.view;
    CGPoint point = [gesture translationInView:gesture.view];
    CGRect btnFrame = CGRectMake(point.x + btn.frame.origin.x, point.y + btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
    btn.frame = btnFrame;

    [gesture setTranslation:CGPointZero inView:gesture.view];
}


- (void)backClick {
    self.navigationController.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)btnClick:(id)sender{
    CircleSpreadPushedViewController *pushedVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"circlePushedVC"];
    self.navigationController.delegate = pushedVC;
    [self.navigationController pushViewController:pushedVC animated:YES];
}



@end
