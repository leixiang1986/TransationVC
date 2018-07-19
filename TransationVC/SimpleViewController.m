//
//  SimpleViewController.m
//  TransationVC
//
//  Created by fuzzy@fdore.com on 2018/7/19.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SimpleViewController.h"
#import "SimplePushedViewController.h"

@interface SimpleViewController ()<UINavigationControllerDelegate>
@property (nonatomic, assign) BOOL noAnimation;
@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)click:(id)sender {
    _noAnimation = YES;  //不要动画
    //这里会执行prepareForSegue: sender:
    [self performSegueWithIdentifier:@"simplePush" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"==================");
    SimplePushedViewController *pushedVC = (SimplePushedViewController *)segue.destinationViewController;
    pushedVC.hasCustomAnimation = !_noAnimation;
    //2,设置导航控制器代理为pushedVC
//    self.navigationController.delegate = pushedVC; //导航栏的代理是push进去的控制器
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
