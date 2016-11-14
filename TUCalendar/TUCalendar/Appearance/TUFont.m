//
//  TUFont.m
//  tutu
//
//  Created by Иван Смолин on 19/11/15.
//  Copyright © 2015 Touch Instinct. All rights reserved.
//

#import "TUFont.h"

static NSString *const kFiraSansRegularFontName = @"FiraSans-Regular";
static NSString *const kFiraSansMediumFontName = @"FiraSans-Medium";
static NSString *const kFiraSansLightFontName = @"FiraSans-Light";

@implementation TUFont

+ (UIFont *)firaSansRegularOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:kFiraSansRegularFontName size:fontSize];
}

+ (UIFont *)firaSansMediumOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:kFiraSansMediumFontName size:fontSize];
}

+ (UIFont *)firaSansLightOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:kFiraSansLightFontName size:fontSize];
}

@end
