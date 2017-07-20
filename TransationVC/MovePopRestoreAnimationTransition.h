//
//  MoveRestoreAnimationTransition.h
//  TransationVC
//
//  Created by 雷祥 on 2017/7/19.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovePopRestoreAnimationTransition : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)animationTransitionWithType:(UINavigationControllerOperation)type;
- (instancetype)initWithNavigationOperationType:(UINavigationControllerOperation)type;
-(instancetype)init NS_UNAVAILABLE;
@end
