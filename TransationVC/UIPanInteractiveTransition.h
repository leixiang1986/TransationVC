//
//  UIPanInteractiveTransition.h
//  TransationVC
//
//  Created by 雷祥 on 2017/7/13.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPanInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, strong) UIViewController *presentedVC;

- (instancetype)initWithPresentedVC:(UIViewController *)presentedVC;

@end
