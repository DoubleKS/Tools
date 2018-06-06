//
//  JJVersionTool.m
//  Tools
//
//  Created by lwq on 2018/6/5.
//  Copyright © 2018年 lwq. All rights reserved.
//

#import "JJVersionTool.h"
#import <AFNetworking.h>

@implementation JJVersionTool


+(NSString*)appVersion{
   return  [[NSBundle mainBundle].infoDictionary valueForKey:(NSString *)kCFBundleVersionKey];
}


+(BOOL)isShowNewFeature{
    NSString *versionValueStringForSystemNow=[[NSBundle mainBundle].infoDictionary valueForKey:(NSString *)kCFBundleVersionKey];
    NSString *versionLocal = [[NSUserDefaults standardUserDefaults] objectForKey:@"NewFeatureVersionKey"];//读取本地版本号
    if(versionLocal!=nil && [versionValueStringForSystemNow isEqualToString:versionLocal]){//说明有本地版本记录，且和当前系统版本一致
        return NO;
    }else{//无本地版本记录或本地版本记录与当前系统版本不一致
        //保存
        [[NSUserDefaults standardUserDefaults] setObject:versionValueStringForSystemNow forKey:@"NewFeatureVersionKey"];
        return YES;
    }
}

+(void)updataVersion{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];//获取当前的时间
    NSString* ignoreUpdateTimeStr =  [[NSUserDefaults standardUserDefaults] objectForKey:@"ignoreUpdateTimeStr"];
    if (ignoreUpdateTimeStr.length > 0) {
        NSDate* ignoreUpdateTime = [formatter dateFromString:ignoreUpdateTimeStr];
        NSTimeInterval end = [datenow timeIntervalSince1970];//当前时间与标准时间差值
        NSTimeInterval start = [ignoreUpdateTime timeIntervalSince1970];//当前时间与标准时间差值
        if ((end - start) < 60*60*24*3) return; //如果超过了3天就重新弹窗更新
    }
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager POST:@"https://itunes.apple.com/cn/lookup?id=1265371343" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSArray* array = responseObject[@"results"];
        if (array.count) {
            NSDictionary *dict = [array lastObject];
            NSLog(@"当前版本为：%@", dict[@"version"]);
            NSString* appstoreVersion = dict[@"version"];
            NSString* currentAppVersion = [[[NSBundle mainBundle]infoDictionary ]objectForKey:@"CFBundleShortVersionString"];
            appstoreVersion = [appstoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
            currentAppVersion = [currentAppVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
            NSString* UpdateLog = dict[@"releaseNotes"];
            if (![currentAppVersion isEqualToString:appstoreVersion] ) {
                UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"更新提示" message:UpdateLog preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* cancaleAction = [UIAlertAction actionWithTitle:@"稍后提醒" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    NSString* ignoreUpdateTimeStr = [formatter stringFromDate:[NSDate date]];
                    [[NSUserDefaults standardUserDefaults] setObject:ignoreUpdateTimeStr forKey:@"ignoreUpdateTimeStr"];
                }];
                UIAlertAction* sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E5%85%94%E5%B1%95/id1265371343?mt=8"]];
                }];
                [alertVC addAction:cancaleAction];
                [alertVC addAction:sureAction];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

@end
