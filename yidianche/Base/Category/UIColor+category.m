//
//  UIColor+category.m
//  yidianche
//
//  Created by 罗文琦 on 2018/7/3.
//  Copyright © 2018年 罗文琦. All rights reserved.
//

#import "UIColor+category.h"
#import <objc/runtime.h>

@implementation UIColor (category)

@dynamic gradientImage;

+ (UIColor *)colorWithGradientStyle:(UIGradientStyle)gradientStyle withSize:(CGSize)size andColors:(NSArray *)colors; {
    
    //Create our background gradient layer
    CAGradientLayer *backgroundGradientLayer = [CAGradientLayer layer];
    
    //Set the frame to our object's bounds
    backgroundGradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    //To simplfy formatting, we'll iterate through our colors array and create a mutable array with their CG counterparts
    NSMutableArray *cgColors = [[NSMutableArray alloc] init];
    for (UIColor *color in colors) {
        [cgColors addObject:(id)[color CGColor]];
    }
    UIImage* backgroundColorImage;
    CGPoint  startPoint = CGPointZero;
    CGPoint  endPoint = CGPointZero;
    switch (gradientStyle) {
        case UIGradientStyleLeftToRight:
            startPoint = CGPointMake(0, 0.5);
            endPoint = CGPointMake(1, 0.5);
            break;
        case UIGradientStyleTopToBottom:
            startPoint = CGPointMake(0.5, 0);
            endPoint = CGPointMake(0.5, 1);
            break;
        case UIGradientStyleDiagonal:
            startPoint = CGPointMake(0, 0);
            endPoint = CGPointMake(1, 1);
            break;
        case UIGradientStyleRadial: {
            UIGraphicsBeginImageContextWithOptions(size,NO, [UIScreen mainScreen].scale);
            //Specific the spread of the gradient (For now this gradient only takes 2 locations)
            CGFloat locations[2] = {0.0, 1.0};
            
            //Default to the RGB Colorspace
            CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
            CFArrayRef arrayRef = (__bridge CFArrayRef)cgColors;
            
            //Create our Fradient
            CGGradientRef myGradient = CGGradientCreateWithColors(myColorspace, arrayRef, locations);
            
            
            // Normalise the 0-1 ranged inputs to the width of the image
            CGPoint myCentrePoint = CGPointMake(0.5 * size.width, 0.5 * size.height);
            float myRadius = MIN(size.width, size.height) * 1.0;
            
            // Draw our Gradient
            CGContextDrawRadialGradient (UIGraphicsGetCurrentContext(), myGradient, myCentrePoint,
                                         0, myCentrePoint, myRadius,
                                         kCGGradientDrawsAfterEndLocation);
            
            // Grab it as an Image
            backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext();
            
            // Clean up
            CGColorSpaceRelease(myColorspace); // Necessary?
            CGGradientRelease(myGradient); // Necessary?
            UIGraphicsEndImageContext();
        }
        default:
            break;
    }
    
    if ( backgroundColorImage == nil) {
        //Set out gradient's colors
        backgroundGradientLayer.colors = cgColors;
        //Specify the direction our gradient will take
        [backgroundGradientLayer setStartPoint:startPoint];
        [backgroundGradientLayer setEndPoint:endPoint];
        //Convert our CALayer to a UIImage object
        UIGraphicsBeginImageContextWithOptions(backgroundGradientLayer.bounds.size,NO, [UIScreen mainScreen].scale);
        [backgroundGradientLayer renderInContext:UIGraphicsGetCurrentContext()];
        backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //[self setGradientImage:backgroundColorImage];
    }
    return [UIColor colorWithPatternImage:backgroundColorImage];
}


+ (void)setGradientImage:(UIImage *)gradientImage {
    
    objc_setAssociatedObject(self, @selector(gradientImage), gradientImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)gradientImage {
    
    return objc_getAssociatedObject(self, @selector(gradientImage));
}
@end
