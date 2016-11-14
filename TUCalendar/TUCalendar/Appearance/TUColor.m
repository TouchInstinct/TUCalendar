//
//  TUColor.m
//  tutu
//
//  Created by Иван Смолин on 02/09/15.
//  Copyright (c) 2015 Touch Instinct. All rights reserved.
//

#import "TUColor.h"
#import <UIColor_Hex/UIColor+Hex.h>

@implementation TUColor

+ (UIColor *)mainBlueColor {
    return [UIColor colorWithHex:0x0099FF];
}

+ (UIColor *)mainGrayColor {
    return [UIColor colorWithHex:0x7B95AA];
}

+ (UIColor *)mainBlackColor {
    return [UIColor colorWithHex:0x374149];
}

+ (UIColor *)mainRedColor {
    return [UIColor colorWithHex:0xC33D1B];
}

+ (UIColor *)wizardErrorRedColor {
    return [UIColor colorWithHex:0xE23B11];
}

+ (UIColor *)mainLightRedColor {
    return [UIColor colorWithHex:0xFFEAEA];
}

+ (UIColor *)mainWhiteTransparentColor {
    return [UIColor colorWithWhite:1.f alpha:0.5];
}

@end
