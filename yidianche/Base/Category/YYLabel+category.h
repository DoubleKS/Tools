//
//  YYLabel+Addition.h
//  RENAUL
//
//  Created by jamesfeng on 2018/3/22.
//  Copyright © 2018年 JX. All rights reserved.
//

#import "YYLabel.h"

@interface YYLabel (catrgory)
/** 创建label*/
+ (YYLabel*)labelWith:(NSString*)title font:(UIFont*)font fontColor:(UIColor*)color;

/**计算文本宽度,在可以无限高的情况下*/
-(CGFloat)getWidth;

/**调整lab宽度,通过调整字间距*/
- (void)adjustWidth:(CGFloat)width;

/**计算文本高度*/
- (CGFloat)getHeightByLimitiWidth:(CGFloat)width;

@end
