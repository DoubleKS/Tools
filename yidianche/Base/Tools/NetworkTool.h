//
//  PRNewWorkTool.h
//  语法糖
//
//  Created by 罗文琦 on 2017/6/23.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"



typedef enum : NSUInteger {
    NetworkResultError = -1, //失败
    NetworkResultSuccess = 1, //成功
    NetworkResultNoFunctionAuthority = 2, //没有功能权限
    NetworkResultNoDataAuthority = 3, //没有数据权限
    NetworkResultJsonError = 4, //请求JSON格式错误
    NetworkResultTokenInvail = 10, //会话失效（token失效）
    NetworkResultLoginOther = 11, //账户在其他地方登录
    NetworkResultInfoChange = 12, //账户信息发生改变
    NetworkResultUnknow = 99 //未知错误
} NetworkResult;

typedef enum : NSUInteger {
    Get = 0, //get
    Post, //post
    Delete,
    Head
} NetworkRequestType;

typedef void (^requestResultBlock)(id responseObject,NSError *error);

/**请求成功的Block*/
typedef void(^requestSuccessBlock)(id dic);

/**请求失败的Block*/
typedef void(^requestFailureBlock)(NSError *error);

typedef void(^completionBlock)(NSURLResponse *response, id responseObject, NSError *error);



@interface NetworkTool : NSObject

@property(nonatomic , copy) requestResultBlock myResultBlock;

+ (instancetype)shared;


/*
@param urlString url
@param params 参数
@param cacheType 缓存类型
 @param type 请求void类型
@param isShowHud 是否显示hud
@param hudLoadView hud加载视图
@param errorView 错误页面加载视图
@param resultBlock 回调
*/
- (void)requsetWithURLString:(NSString *)urlString params:(NSDictionary *)params  requestType:(NetworkRequestType)type isShowHud:(BOOL)isShowHud hudLoadView:(UIView *)hudLoadView result:(requestResultBlock)resultBlock;




#pragma mark - 上传文件
- (NSURLSessionUploadTask*)uploadNetWorkWithUploadURLString:(NSString*)uploadUrlString FilePath:(NSString*)filePath Param:(NSDictionary*)dict completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock ;



/**
 上传头像
 */
- (void)uploadIconWithUploadURLString:(NSString*)uploadUrlString image:(UIImage*)image Param:(NSDictionary*)dict completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock;


- (void)uploadNetWorkWithUploadURLString:(NSString*)uploadUrlString image:(UIImage*)image Param:(NSDictionary*)dict completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock;


/**
 是否添加当前服务器前缀的请求,用来上报埋点数据
 */
- (void)requsetWithURLString:(NSString *)urlString
                      params:(NSDictionary *)params
                 requestType:(NetworkRequestType)type
                   isShowHud:(BOOL)isShowHud
                 hudLoadView:(UIView *)hudLoadView
                   errorView:(UIView *)errorView
           addKCurrentServer:(BOOL)add
                      result:(requestResultBlock)resultBlock;



@end
