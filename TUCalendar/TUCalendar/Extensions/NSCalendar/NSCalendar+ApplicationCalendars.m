//
//  NSCalendar+ApplicationCalendars.m
//  tutu
//
//  Created by Ivan Smolin on 14/11/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

#import "NSCalendar+ApplicationCalendars.h"

@implementation NSCalendar (ApplicationCalendars)

+ (instancetype)currentRUCalendar {
    NSCalendar *localCalendar = [self currentCalendar];
    localCalendar.firstWeekday = 2; // set monday as first day of week
    localCalendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru"];

    return localCalendar;
}

@end
