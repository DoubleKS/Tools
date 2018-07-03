//
//  DefaultDefine.h
//  罗文琦语法糖
//
//  Created by 罗文琦 on 2017/6/21.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#ifndef DefaultDefine_h
#define DefaultDefine_h


//**************************************DEBUG下打印,非DEBUG不打印***********************
#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog(...)
#endif


//**************************************屏幕大小信息**************************************
#define KScreenWidth       [[UIScreen mainScreen] bounds].size.width            //屏幕宽度
#define KScreenHeight      [[UIScreen mainScreen] bounds].size.height          //屏幕高度
#define KScreenBounds      [[UIScreen mainScreen] bounds]                      //屏幕大小
#define KKeyWindow         [[[UIApplication sharedApplication] delegate] window] //window

//**************************************缩放尺寸**************************************
#define KScale(size)   ([[UIScreen mainScreen] bounds].size.width/375.0) * size    //根据6的尺寸缩放控件的长宽



//**************************************颜色相关**************************************
//设置颜色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a] 
//根据RGBA得到颜色值
#define RGBHEX(c)     [UIColor colorWithRed:((c>>16)&0xFF)/255.0 \
                                        green:((c>>8)&0xFF)/255.0 \
                                        blue:(c&0xFF)/255.0       \
                                        alpha:1.0]          //根据16进制数0x??????值得到色值 (如0xfeffff)
#define RGBHEXA(c,a)     [UIColor colorWithRed:((c>>16)&0xFF)/255.0 \
                                          green:((c>>8)&0xFF)/255.0 \
                                          blue:(c&0xFF)/255.0       \
                                          alpha:a]          //根据16进制数0x??????值得到色值 (如0xfeffff)
#define RGBARandom    [UIColor colorWithRed:arc4random_uniform(256)/255.0                                                         green:arc4random_uniform(256)/255.0                                                               blue:arc4random_uniform(256)/255.0 alpha:1]             //随机颜色值




//**************************************强弱引用**************************************
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif









//**************************************字体相关**************************************
#define YDPFSCRegular(x)         [UIFont fontWithName:@"PingFangSC-Regular" size:x]
#define YDPFSCLight(x)           [UIFont fontWithName:@"PingFangSC-Light" size:x]
#define YDPFSCThin(x)            [UIFont fontWithName:@"PingFangSC-Thin" size:x]
#define YDPFSCMeaium(x)          [UIFont fontWithName:@"PingFangSC-Medium" size:x]
#define YDSFNSDisplay(x)         [UIFont fontWithName:@"SFNSDisplay" size:x]
#define YDDINProMedium(x)        [UIFont fontWithName:@"DINPro-Medium" size:x]

//**************************************与iphoneX相关**************************************
#define isIPhoneX          ([[UIScreen mainScreen] bounds].size.height == 812)
#define KTopLayoutGuide    (UIApplication.shared.statusBarFrame.size.height + UINavigationController().navigationBar.frame.height)
#define KBottomLayoutGuide ([[UIScreen mainScreen] bounds].size.height == 812 ? 83 : [UITabBarController new].tabBar.frame.size.height)
#define kSafeBottom        ([[UIScreen mainScreen] bounds].size.height == 812 ? 34 : 0)



//**************************************与系统版本相关**************************************
#define iOS7Later    ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later    ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later    ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later  ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)
#define iOS10Later   ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define iOS11Later   ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)
#define iOS12Later   ([UIDevice currentDevice].systemVersion.floatValue >= 12.0f)

//**************************************其他**************************************
#define kUUID [[[UIDevice currentDevice].identifierForVendor UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""]
#define kStringFromClass(x) NSStringFromClass([x class])


#endif /* DefaultDefine_h */
