//
//  ViewTransicitonController.m
//  TransationVC
//
//  Created by fuzzy@fdore.com on 2018/7/19.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "ViewTransicitonController.h"
#import "Header.h"

@interface ViewTransicitonController ()
@property (nonatomic, strong) UIImageView *someView;
@property (nonatomic, strong) UIImageView *view1;
@property (nonatomic, strong) UIImageView *view2;
@property (nonatomic, assign) BOOL flag;

@property (nonatomic, strong) UIView *act2Container;
@property (nonatomic, strong) UIImageView *act2View1;
@property (nonatomic, strong) UIImageView *act2View2;

@end



@implementation ViewTransicitonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupForAnimation1];
    [self setupForAnimation2];
    
}

- (void)setupForAnimation1 {
    self.someView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 65, 100, 100)];
    self.someView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.someView];
    self.someView.image = [UIImage imageNamed:@"0"];
    
    _view1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _view1.backgroundColor = [UIColor redColor];
    _view1.alpha = 0;
    _view1.image = [UIImage imageNamed:@"11"];
    [self.someView addSubview:_view1];
    
    _view2 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    _view2.backgroundColor = [UIColor blueColor];
    _view2.image = [UIImage imageNamed:@"12"];
    [self.someView addSubview:_view2];
}

- (void)setupForAnimation2 {
    self.act2Container = [[UIView alloc] initWithFrame:CGRectMake(kScreenSize.width - 120, 65, 100, 100)];
    [self.view addSubview:self.act2Container];
    self.act2View1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.act2View1.image = [UIImage imageNamed:@"11"];
    [self.act2Container addSubview:self.act2View1];
    
    self.act2View2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.act2View2.image = [UIImage imageNamed:@"12"];
    [self.act2Container addSubview:self.act2View2];
}



//view转场动画1，在一个view上做变化
- (void)actAnimation1 {
    [UIView transitionWithView:self.someView duration:0.2 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        if (self.flag) {
            self.view2.alpha = 1;
            self.view1.alpha = 0;
            self.someView.image = [UIImage imageNamed:@"0"];
            
        }
        else {
            self.view2.alpha = 0;
            self.view1.alpha = 1;
            self.someView.image = [UIImage imageNamed:@"1"];
        }
        self.flag = !self.flag;
    } completion:^(BOOL finished) {
        
    }];
}

//View转场动画2，从一个view转化动另一个view
//使用UIViewAnimationOptionShowHideTransitionViews方便的实现视图层级的显示隐藏
- (void)actAnimation2 {
    [UIView transitionFromView:self.act2View2 toView:self.act2View1 duration:0.2 options:(UIViewAnimationOptionTransitionFlipFromBottom |  UIViewAnimationOptionShowHideTransitionViews) completion:^(BOOL finished) {
        UIImageView *temp = self.act2View2;
        self.act2View2 = self.act2View1;
        self.act2View1 = temp;
    }];
}


- (IBAction)click:(id)sender {
    [self actAnimation1];
    [self actAnimation2];
    
    
}



@end
