//
//  NSDateFormatter+TUDateFormatters.m
//  tutu
//
//  Created by Ivan Smolin on 14/11/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

#import "NSDateFormatter+TUDateFormatters.h"

@implementation NSDateFormatter (TUDateFormatters)

+ (NSDateFormatter *)iso8601Formatter {
    NSDateFormatter *iso8601DatesFormater = [NSDateFormatter new];
    iso8601DatesFormater.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    iso8601DatesFormater.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";

    return iso8601DatesFormater;
}

@end
