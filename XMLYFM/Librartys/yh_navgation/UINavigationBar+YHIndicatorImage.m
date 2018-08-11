//
//  UINavigationBar+YHIndicatorImage.m
//  test1221
//
//  Created by Vincent hoover on 2018/1/6.
//  Copyright © 2018年 Wheat. All rights reserved.
//

#import "UINavigationBar+YHIndicatorImage.h"
#import <objc/runtime.h>

@implementation UINavigationBar (YHIndicatorImage)

+ (void)load{
    
    //  只交换一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
       
        Method configBackImage = class_getInstanceMethod(self, @selector(setBackIndicatorImage:));
        
        Method yh_configBackImage = class_getInstanceMethod(self, @selector(yh_setBackIndicatorImage:));
        
        method_exchangeImplementations(configBackImage, yh_configBackImage);
    });
}

- (void)yh_setBackIndicatorImage:(UIImage *)image{
    
    [self yh_setBackIndicatorImage:image];
    
    if (@available(iOS 11.2, *)) {
        
    }else{
        //设置title与 back indicator image 的间距
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(5, 0) forBarMetrics:UIBarMetricsDefault];
    }
    
}

    
    
@end
