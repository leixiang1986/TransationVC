//
//  PresentedOneViewController.h
//  TransationVC
//
//  Created by 雷祥 on 2017/7/14.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PresentedOneViewController : UIViewController<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) id<UIViewControllerInteractiveTransitioning>(^interactivePresentBlock)();
@end
