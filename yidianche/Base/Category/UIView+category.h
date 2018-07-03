//
//  UIView+MUCommon.h
//  BigCalculate
//
//  Created by wonhigh on 2016/11/15.
//  Copyright © 2016年 wonhigh. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIView (category)


/**
 获取当前view所在的控制器
 */
- (UIViewController *)getCurrentViewController;

/**
 移除view上刷新控件之外的其他控件
 */
- (void)removeSubviewFromSuperviewExceptRerfeshView;

/**
 一次加多个view到界面上
 */
-(void)addSubviews:(NSArray<UIView*>*)views;

/**
 加约束
 */
-(void)addConstraints;

- (UIImage *)screenShot;

- (void)screenShotWithCompletion:(void(^)(UIImage* image))completion;

@end
