//
//  UIImage+MUCommon.h
//  BigCalculate
//
//  Created by 罗文琦 on 16/10/27.
//  Copyright © 2016年 罗文琦. All rights reserved.
//
//

#import "UIImage+category.h"

@implementation UIImage (category)


+ (UIImage *)imageWithGradientStyle:(UIGradientStyle)gradientStyle gradientSize:(CGSize)size  andColors:(NSArray *)colors{
    CAGradientLayer *backgroundGradientLayer = [CAGradientLayer layer];
    backgroundGradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    NSMutableArray *cgColors = [[NSMutableArray alloc] init];
    for (UIColor *color in colors) {
        [cgColors addObject:(id)[color CGColor]];
    }
    UIImage* backgroundColorImage;
    CGPoint  startPoint = CGPointZero;
    CGPoint  endPoint = CGPointZero;
    switch (gradientStyle) {
        case UIGradientStyleRadial: {
            UIGraphicsBeginImageContextWithOptions(size,NO, [UIScreen mainScreen].scale);
            CGFloat locations[2] = {0.0, 1.0};
            CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
            CFArrayRef arrayRef = (__bridge CFArrayRef)cgColors;
            CGGradientRef myGradient = CGGradientCreateWithColors(myColorspace, arrayRef, locations);
            CGPoint myCentrePoint = CGPointMake(0.5 * size.width, 0.5 * size.height);
            float myRadius = MIN(size.width, size.height) * 1.0;
            CGContextDrawRadialGradient (UIGraphicsGetCurrentContext(), myGradient, myCentrePoint,
                                         0, myCentrePoint, myRadius,
                                         kCGGradientDrawsAfterEndLocation);
            backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext();
            CGColorSpaceRelease(myColorspace); // Necessary?
            CGGradientRelease(myGradient); // Necessary?
            UIGraphicsEndImageContext();
        }
            break;
        case   UIGradientStyleDiagonal :
            backgroundGradientLayer.colors = cgColors;
            startPoint = CGPointMake(0.0, 0.0);
            endPoint = CGPointMake(1.0, 1.0);
            break;
        case UIGradientStyleTopToBottom:
            startPoint = CGPointMake(0.5, 0);
            endPoint = CGPointMake(0.5, 1.0);
            break;
        case UIGradientStyleLeftToRight:
            startPoint = CGPointMake(0, 0.5 );
            endPoint = CGPointMake(1, 0.5);
            break;
        default:
            break;
    }
    if (backgroundColorImage == nil) {
        backgroundGradientLayer.colors = cgColors;
        [backgroundGradientLayer setStartPoint:startPoint];
        [backgroundGradientLayer setEndPoint:endPoint];
        UIGraphicsBeginImageContextWithOptions(backgroundGradientLayer.bounds.size,NO, [UIScreen mainScreen].scale);
        [backgroundGradientLayer renderInContext:UIGraphicsGetCurrentContext()];
        backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return backgroundColorImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
        // 描述矩形         
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        // 开启位图上下文
        UIGraphicsBeginImageContext(rect.size);
        // 获取位图上下文
        CGContextRef context = UIGraphicsGetCurrentContext();
        // 使用color演示填充上下文
        CGContextSetFillColorWithColor(context, [color CGColor]);
        // 渲染上下文
        CGContextFillRect(context, rect);
        // 从上下文中获取图片
        UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
        // 结束上下文
        UIGraphicsEndImageContext();
        return theImage;
}


#pragma mark - 修正图片旋转
-(UIImage *)fixOrientation{
    if (self.imageOrientation == UIImageOrientationUp)
        return self;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
