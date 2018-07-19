//
//  PresentedViewController.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/13.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "PresentedViewController.h"

@interface PresentedViewController ()

@end

@implementation PresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSLog(@"PresentedViewController====touch");
}


- (IBAction)dismissal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)dealloc {
    NSLog(@"销毁了");

}

@end
