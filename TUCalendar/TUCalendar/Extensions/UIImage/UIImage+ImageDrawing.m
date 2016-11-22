//
//  UIImage+ImageDrawing.m
//  tutu
//
//  Created by Ivan Smolin on 21/11/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

#import "UIImage+ImageDrawing.h"

@implementation UIImage (ImageDrawing)

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size {
    UIImage *image;

    UIGraphicsBeginImageContextWithOptions(size, NO, 0.f);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();

        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, CGRectMake(0.f, 0.f, size.width, size.height));

        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();

    return image;
}

@end
