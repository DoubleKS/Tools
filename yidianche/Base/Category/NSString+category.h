//
//  NSString+category.h
//  esee
//
//  Created by 罗文琦 on 2017/9/11.
//  Copyright © 2017年 中北明夷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (category)


/**获取到当前的时间文本,年月日时分秒*/
+(NSString*)yd_getCurrentTime;

/**获取到当前的时间,年月日*/
+(NSString*)yd_getCurrentTimeWithDay;

/**字符串为nil时返回@"",防止崩溃*/

+(NSString *)yd_nilToString:(NSString *)str;

/**是否包含某一字符串*/
- (BOOL)yd_isContainsString:(NSString *)str;

/**判断是否包含emoji*/
-(BOOL)yd_isContainsEmoji;

/**去除emoji */
-(NSString*)yd_deleteEmoji;

/**判断是否包含中文*/
-(BOOL)yd_isContainChinese;

/**判断字符串是否为空或者全部是空格*/
+ (BOOL)yd_isEmpty:(NSString *) str;

/**去除空格*/
-(NSString*)yd_deleteWhiteSpace;

/**
 判断是不是包含非法字符
 除中英文,数字以外任何的字符都是特殊字符,逗号,句号也是特殊字符
 */
-(BOOL)yd_isContainsTheillegalCharacter;

/**判断字符串是否为手机号码*/
-(BOOL)yd_isMobileNumber;

/**获取手机型号*/
+ (NSString *)yd_iphoneType;

/**判断是否九宫格输入*/
-(BOOL)yd_isInputRuleNotBlank;

/**处理后台返回类型类型为float double精度不准确的问题*/
+ (NSString *)yd_reviseString:(NSString *)string;

/**MD5加密*/
-(NSString *)yd_md5;

/**计算文本需要的size*/
+ (CGSize)yd_calculateSizeWithStr:(NSString *)text textFont:(UIFont *)font withMaxSize:(CGSize)maxSize;

/**数字字符串转千分位字符串 （界面显示中用）*/
+ (NSString *)yd_countNumAndChangeformat:(NSString *)num;

/** 修正图片地址*/
-(NSString*)yd_fixImageURL;


/**为字符串增加百分号*/
+ (NSString *)yd_addPercent:(NSString *)str;


@end
