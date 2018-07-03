//
//  APIDefine.h
//  yidianche
//
//  Created by 罗文琦 on 2018/5/21.
//  Copyright © 2018年 罗文琦. All rights reserved.
//

#ifndef APIDefine_h
#define APIDefine_h


//获取验证码
static NSString* const  kPRVerifyCodeApi = @"/user/send_capcha";

//注册
static NSString* const  kPRRegisterApi = @"/user/reg/phone";

//登录
static NSString* const  kPRLoginApi = @"/user/login";

//修改密码
static NSString* const  kPRResetPwdApi = @"/user/reset_password/phone";


//保存渲染
#define kPRRenderApi(videoId) [NSString stringWithFormat:@"/user/video/%@/render",videoId]

//保存草稿
#define kPRSaveApi(videoId) [NSString stringWithFormat:@"/user/video/%@/save",videoId]

#endif /* APIDefine_h */
