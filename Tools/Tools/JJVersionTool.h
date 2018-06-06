//
//  JJVersionTool.h
//  Tools
//
//  Created by lwq on 2018/6/5.
//  Copyright © 2018年 lwq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJVersionTool : NSObject

/**版本更新提示,待会提醒,也可以做成忽略本次更新的模式,但是不利于增加更新率*/
+(void)updataVersion;

/**是否显示新特性*/
+(BOOL)isShowNewFeature;

/**APP版本号*/
+(NSString*)appVersion;




@end
