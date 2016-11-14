//
//  NSCalendar+TimeUnits.m
//  tutu
//
//  Created by Ivan Smolin on 01/09/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

#import "NSCalendar+TimeUnits.h"

@implementation NSCalendar (TimeUnits)

- (NSUInteger)hoursInDayForDate:(NSDate *)date {
    return [self rangeOfUnit:NSCalendarUnitHour
                      inUnit:NSCalendarUnitDay
                     forDate:date].length;
}

- (NSUInteger)minutesInHourForDate:(NSDate *)date {
    return [self rangeOfUnit:NSCalendarUnitMinute
                      inUnit:NSCalendarUnitHour
                     forDate:date].length;
}

- (NSUInteger)secondsInMinuteForDate:(NSDate *)date {
    return [self rangeOfUnit:NSCalendarUnitSecond
                      inUnit:NSCalendarUnitMinute
                     forDate:date].length;
}

- (NSUInteger)daysInYearForDate:(NSDate *)date {
    return [self rangeOfUnit:NSCalendarUnitDay
                      inUnit:NSCalendarUnitYear
                     forDate:date].length;
}

@end
