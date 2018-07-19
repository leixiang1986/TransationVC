//
//  MagicPushedViewController.h
//  TransationVC
//
//  Created by 雷祥 on 2017/7/19.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagicPushedViewController : UIViewController<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage *image; //传值时，imageView还没有初始化，所以用image变量保存图片信息，在viewDidLoad方法中赋值给imageView

@end
