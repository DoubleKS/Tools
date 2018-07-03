//
//  PRNewWorkTool.m
//  语法糖
//
//  Created by 罗文琦 on 2017/6/23.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "NetworkTool.h"
#import <MBProgressHUD.h>
#import "MBProgressHUD+category.h"


@interface NetworkTool ()

@property (nonatomic, strong) AFHTTPSessionManager * manager;

@property (nonatomic, strong) AFURLSessionManager * urlManager;

@property(nonatomic , strong) NSString * urlString;

@property(nonatomic , strong) NSDictionary *params;

@property(nonatomic , assign) NetworkRequestType type;

@property(nonatomic , assign) BOOL isShowHud;

@property(nonatomic , strong) UIView *hudLoadView;

@property(nonatomic , strong) UIView *errorView;

@end

@implementation NetworkTool



+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    static NetworkTool * shared = nil;
    dispatch_once(&onceToken, ^{
        shared = [[NetworkTool alloc] init];
        
    });
    return shared;
}

#pragma mark - 网络请求管理
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //暂时采取服务端单向认证，需要做以下配置
        AFSecurityPolicy *securitypolicy = [AFSecurityPolicy defaultPolicy];
        //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
        securitypolicy.allowInvalidCertificates = YES;
        //validatesDomainName 是否需要验证域名，默认为YES；
        securitypolicy.validatesDomainName = NO;
        _manager.securityPolicy = securitypolicy;
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [_manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        [_manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"DeviceType"];
        [_manager.requestSerializer setValue:@"7" forHTTPHeaderField:@"x-api-version"];
        _manager.requestSerializer.timeoutInterval = 30;
        _manager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    }
    return _manager;
}


- (AFURLSessionManager *)urlManager{
    if(!_urlManager){
        _urlManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        AFHTTPResponseSerializer* responseSer = [AFHTTPResponseSerializer serializer];
        responseSer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/JavaScript",@"text/html",@"text/plain", nil];
        _urlManager.responseSerializer = responseSer;
    }
    return _urlManager;
}



- (void)requsetWithURLString:(NSString *)urlString
                      params:(NSDictionary *)params
                 requestType:(NetworkRequestType)type
                   isShowHud:(BOOL)isShowHud
                 hudLoadView:(UIView *)hudLoadView
                      result:(requestResultBlock)resultBlock{
    _urlString = urlString;
    _params = params;
    _type = type;
    _isShowHud = isShowHud;
    _hudLoadView = hudLoadView;
    _myResultBlock = resultBlock;
    switch (type) {
        case Get:{
            if (isShowHud) [MBProgressHUD yd_showHUDLoadingImageArrWithShowView:hudLoadView];
            [self logDebugStartWithApiName:urlString params:params];
            [self.manager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (isShowHud)     [MBProgressHUD yd_dissmissShowView:hudLoadView];
                if (resultBlock)   resultBlock(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error.domain);
                //                NSLog(@"---------------------------------------------%zd",error.code);
                if (isShowHud) [MBProgressHUD yd_dissmissShowView:hudLoadView];
                if(resultBlock) resultBlock(nil,error);
                [self logDebugEndWithApiName:urlString error:error];
                if (error.code == -1009) {
                    [MBProgressHUD yd_showHUDText:@"网络连接丢失" toView:hudLoadView andAfterDelay:1];
                    return ;
                }else if (error.code == -1001) {
                    [MBProgressHUD yd_showHUDText:@"服务器忙" toView:hudLoadView andAfterDelay:1];
                    return ;
                }else{
                    [MBProgressHUD yd_showHUDText:@"未知错误" toView:hudLoadView andAfterDelay:1];
                    return ;
                }
            }];
        }
            break;
        case Post:
        {
            if (isShowHud) [MBProgressHUD yd_showHUDLoadingImageArrWithShowView:hudLoadView];
            [self logDebugStartWithApiName:urlString params:params];
            [self.manager POST:urlString parameters:params  progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self logDebugEndWithApiName:urlString response:responseObject];
                if (isShowHud) [MBProgressHUD yd_dissmissShowView:hudLoadView];
                if (resultBlock) resultBlock(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [self logDebugEndWithApiName:urlString error:error];
                if (isShowHud) [MBProgressHUD yd_dissmissShowView:hudLoadView];
                 if (resultBlock) resultBlock(nil,error);
                //********************对接口异常的情况进行记录*******************
                if (error.code == -1009) {
                    [MBProgressHUD yd_showHUDText:@"网络连接丢失" toView:hudLoadView andAfterDelay:1];
                    return ;
                }else if (error.code == -1001) {
                    [MBProgressHUD yd_showHUDText:@"服务器忙" toView:hudLoadView andAfterDelay:1];
                    return ;
                }else{
                    [MBProgressHUD yd_showHUDText:@"未知错误" toView:hudLoadView andAfterDelay:1];
                    return ;
                }
            }];
        }
            break;
        case Delete:
        {
            if (isShowHud) [MBProgressHUD yd_showHUDLoadingImageArrWithShowView:hudLoadView];
            [self logDebugStartWithApiName:urlString params:params];
            [self.manager DELETE:urlString parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (isShowHud) [MBProgressHUD yd_dissmissShowView:hudLoadView];
                [self logDebugEndWithApiName:urlString response:responseObject];
                if (resultBlock) resultBlock(responseObject,nil);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if(isShowHud)   [MBProgressHUD yd_dissmissShowView:hudLoadView];
                [self logDebugEndWithApiName:urlString error:error];
                if (resultBlock) resultBlock(nil,error);
            }];
        }
            break;
        case Head:
            [self.manager HEAD:urlString parameters:params success:^(NSURLSessionDataTask * _Nonnull task) {
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            }];
            break;
        default:
            break;
    }
}


#pragma mark - 请求网络开始,打印网络请求参数
- (void)logDebugStartWithApiName:(NSString *)apiName params:(NSDictionary *)params
{
#ifdef DEBUG
    NSMutableString * logString = [NSMutableString stringWithString:@"\n\n**************************************************************\n*                    API Request Start                       *\n**************************************************************\n\n"];
    [logString appendFormat:@"API Name:\t\t%@\n", apiName];
    if (params) {
        NSError * error = nil;
        NSData * data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        NSString * paramsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [logString appendFormat:@"Params:\n%@", paramsString];
    }else{
        [logString appendFormat:@"Params:\n%@", params];
    }
    [logString appendString:@"\n\n|------------------------Start Log END-----------------------|\n\n"];
    NSLog(@"%@", logString);
#endif
}

#pragma mark - 网络请求成功，打印返回参数
- (void)logDebugEndWithApiName:(NSString *)apiName response:(id)response
{
#ifdef DEBUG
    NSMutableString * logString = [NSMutableString stringWithString:@"\n\n============================\n=API Response                        =\n=======================\n\n"];
    [logString appendFormat:@"API Name:\t\t%@\n", apiName];
    if (response) {
        NSError * error = nil;
        NSData * data = [NSJSONSerialization dataWithJSONObject:response options:NSJSONWritingPrettyPrinted error:&error];
        NSString * responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [logString appendFormat:@"Response:\n\t%@\n\n", responseString];
    }
    [logString appendString:@"|----------------------Response Log END----------------------|\n\n"];
    // NSLog(@"%@", logString);
#endif
}

#pragma mark - 网络请求失败，打印失败参数
- (void)logDebugEndWithApiName:(NSString *)apiName error:(NSError *)error
{
#ifdef DEBUG
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n=========================\n=  API Error                        =\n================================\n\n"];
    [logString appendFormat:@"API Name:\t\t%@\n", apiName];
    
    if (error) {
        [logString appendFormat:@"Error Domain Code:\t\t\t\t%ld\n", (long)error.code];
        [logString appendFormat:@"Error Localized Description:\t%@\n", error.localizedDescription];
    }
    [logString appendString:@"|----------------------Error Log END----------------------|\n\n"];
    NSLog(@"%@", logString);
#endif
}



#pragma mark - 上传文件

- (NSURLSessionUploadTask*)uploadNetWorkWithUploadURLString:(NSString*)uploadUrlString FilePath:(NSString*)filePath Param:(NSDictionary*)dict completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock{
    NSURL* fileURL = [NSURL fileURLWithPath:filePath];
    NSLog(@"开始上传_filePath = %@   \\n_filePathURL = %@",filePath,fileURL);
    
    
    NSString* fileName = [[NSFileManager defaultManager] displayNameAtPath:filePath];
    
    
    NSString *suffix = [[filePath pathExtension] lowercaseString];
    NSLog(@"suffix = %@",suffix);
    NSString* contentType = nil;
    
    if([suffix isEqualToString:@"png"]){
        
        contentType = @"image/png";
        
    }else if([suffix isEqualToString:@"jpg"]){
        
        contentType = @"image/jpeg";
        
    }else if([suffix isEqualToString:@"mp4"]){
        
        contentType = @"video/mp4";
        
    }else{
        contentType = @"image/jpeg";
    }
    
    AFHTTPRequestSerializer *ser= [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =
    [ser multipartFormRequestWithMethod:@"POST"
                              URLString:uploadUrlString
                             parameters:dict
              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                  [formData appendPartWithFileURL:fileURL name:@"file" fileName:fileName mimeType:contentType error:nil];
                  
              } error:nil];
    
    [ser setValue:@"esee.rabbitpre.com" forHTTPHeaderField:@"referer"];
    //    [ser setValue:@"application/xml"forHTTPHeaderField:@"Content-Type"];
    //    [ser setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionUploadTask *uploadTask = [self.urlManager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"upload-progress = %@",uploadProgress);
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"request = %@", request );
        NSLog(@"response = %@", response);
        NSLog(@"Error: %@", error );
        
        if(completionBlock){
            completionBlock(response, responseObject, error);
        }
        
        [MBProgressHUD yd_dissmissShowView:[UIApplication sharedApplication].keyWindow];
    }];
    
    
    
    return uploadTask;
}



- (void)uploadIconWithUploadURLString:(NSString*)uploadUrlString image:(UIImage*)image Param:(NSDictionary*)dict completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock{
    
    [self.manager POST:uploadUrlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:UIImagePNGRepresentation(image)
                                    name:@"userFile[]"
                                fileName:@"userICON"
                                mimeType:@"application/octer-stream"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completionBlock) {
            completionBlock(nil,responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}






- (void)uploadNetWorkWithUploadURLString:(NSString*)uploadUrlString image:(UIImage*)image Param:(NSDictionary*)dict completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock{
    
    AFHTTPRequestSerializer *ser= [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =
    [ser multipartFormRequestWithMethod:@"POST"
                              URLString:uploadUrlString
                             parameters:dict
              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                  [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"file" fileName:@"" mimeType:@"image/png"];
                  //                  [formData appendPartWithFileURL:fileURL name:@"file" fileName:fileName mimeType:contentType error:nil];
                  
              } error:nil];
    
    [ser setValue:@"esee.rabbitpre.com" forHTTPHeaderField:@"referer"];
    NSURLSessionUploadTask *uploadTask = [self.urlManager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"upload-progress = %@",uploadProgress);
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"request = %@", request );
        NSLog(@"response = %@", response);
        NSLog(@"Error: %@", error );
        
        if(completionBlock){
            completionBlock(response, responseObject, error);
        }
        
        [MBProgressHUD yd_dissmissShowView:[UIApplication sharedApplication].keyWindow];
    }];
    [uploadTask resume];
}


- (void)requsetWithURLString:(NSString *)urlString
                      params:(NSDictionary *)params
                 requestType:(NetworkRequestType)type
                   isShowHud:(BOOL)isShowHud
                 hudLoadView:(UIView *)hudLoadView
                   errorView:(UIView *)errorView
           addKCurrentServer:(BOOL)add
                      result:(requestResultBlock)resultBlock{
    _urlString = urlString;
    _params = params;
    _type = type;
    _myResultBlock = resultBlock;
    switch (type) {
        case Get:{
            [self.manager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (resultBlock)  resultBlock(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (resultBlock)  resultBlock(nil,error);
            }];
        }
            break;
        case Post:
        {
            [self.manager POST:urlString parameters:params  progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self logDebugEndWithApiName:urlString response:responseObject];
                if (resultBlock)  resultBlock(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (resultBlock)  resultBlock(nil,error);
            }];
        }
            break;
        default:
            break;
    }
}





@end
