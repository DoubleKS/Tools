//
//  UIView+MUCommon.m
//  BigCalculate
//
//  Created by wonhigh on 2016/11/15.
//  Copyright © 2016年 wonhigh. All rights reserved.
//

#import "UIView+category.h"


@implementation UIView (category)



- (UIViewController *)getCurrentViewController
{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

#pragma mark - 移除view上刷新控件之外的其他控件
- (void)removeSubviewFromSuperviewExceptRerfeshView
{
    if (self == nil) {
        return;
    }
    
    if ([self isKindOfClass:[UITableView class]]) {
        return;
    }
    
    for (UIView * refreshView in self.subviews) {
        
        if (![refreshView isKindOfClass:NSClassFromString(@"MJRefreshComponent")]) {
            [refreshView removeFromSuperview];
        }
    }
}

#pragma mark - 一次性加多个view到界面上
-(void)addSubviews:(NSArray<UIView*>*)views{
    for (UIView* view in views) {
        [self addSubview:view];
    }
}

-(void)addConstraints{
}


- (UIImage *)screenShot{
    if (self && self.frame.size.height && self.frame.size.width) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    } else { 
        return nil;
    }
}


- (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    return resultImage;
}




- (void)screenShotWithCompletion:(void(^)(UIImage* image))completion{
    if (self && self.frame.size.height && self.frame.size.width) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if(completion){
            completion(image);
        }
    } else {
        if(completion){
            completion(nil);
        }
    }
}


@end
