//
//  UINavigationController+YHBackTitle.m
//  test1221
//
//  Created by Vincent hoover on 2018/1/6.
//  Copyright © 2018年 Wheat. All rights reserved.
//

#import "UINavigationController+YHBackTitle.h"
#import <objc/runtime.h>

@implementation UINavigationController (YHBackTitle)

+ (void)load{
    
    //  只交换一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method pushViewController    = class_getInstanceMethod(self, @selector(pushViewController:animated:));
        Method yh_pushViewController = class_getInstanceMethod(self, @selector(yh_pushViewController:animated:));
        method_exchangeImplementations(pushViewController, yh_pushViewController);
        
    });
    
    
}

- (void)yh_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIViewController *backVC = [self.viewControllers lastObject];
        
        UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
        backButtonItem.title = @"";
        backVC.navigationItem.backBarButtonItem = backButtonItem;
        
    }
    [self yh_pushViewController:viewController animated:YES];
    
}

@end
