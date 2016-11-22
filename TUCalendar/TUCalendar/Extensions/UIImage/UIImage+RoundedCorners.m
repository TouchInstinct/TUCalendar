//
//  UIImage+RoundedCorners.m
//  tutu
//
//  Created by Ivan Smolin on 21/11/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

#import "UIImage+RoundedCorners.h"
#import "TUUtils.h"

@implementation UIImage (RoundedCorners)

- (UIImage *)roundedImageWithRadius:(CGFloat)radius {
    UIImage *newImage;

    CGRect imageRect = CGRectMake(0.f, 0.f, self.size.width, self.size.height);

    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    {
        [[UIBezierPath bezierPathWithRoundedRect:imageRect cornerRadius:radius] addClip];

        [self drawInRect:imageRect];

        newImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();

    return newImage;
}

- (UIImage *)circleImage {
    return [self roundedImageWithRadius:TU_MIN(self.size.width, self.size.height) / 2.f];
}

@end
