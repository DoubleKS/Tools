//
//  RPersonaIinformationIconSetCell.m
//  esee
//
//  Created by 罗文琦 on 2017/7/3.
//  Copyright © 2017年 中北明夷. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 * block回调
 *
 * @param index       被点击按钮标识,取消: 0, 删除: -1, 其他: 1.2.3...
 */
typedef void(^resultBlock)(NSInteger index);

@interface BaseActionSheet : UIView


+ (void)showActionSheetWithTitle:(NSString *)title
               cancelButtonTitle:(NSString *)cancelButtonTitle
          destructiveButtonTitle:(NSString *)destructiveButtonTitle
               otherButtonTitles:(NSArray *)otherButtonTitles
                         handler:(resultBlock)resultBlock;

/**
 * 弹出视图
 */
- (void)show;

@end
