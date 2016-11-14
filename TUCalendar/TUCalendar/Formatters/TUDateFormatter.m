//
//  TUDateFormatter.m
//  tutu
//
//  Created by Иван Смолин on 22/09/15.
//  Copyright (c) 2015 Touch Instinct. All rights reserved.
//

#import "TUDateFormatter.h"
#import "TUUtils.h"
#import "NSCalendar+TimeUnits.h"

static NSDateFormatter *iso8601DatesFormater = nil;
static NSDateFormatter *utcDefaultDatesFormater = nil;

static const NSUInteger kNumberOfDaysInWeek = 7;

@implementation TUDateFormatter

+ (void)initialize {
    // http://stackoverflow.com/a/16254918

    NSLocale *posixLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];

    iso8601DatesFormater = [NSDateFormatter new];
    iso8601DatesFormater.locale = posixLocale;
    iso8601DatesFormater.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";

    utcDefaultDatesFormater = [NSDateFormatter new];
    utcDefaultDatesFormater.dateFormat = @"dd.MM.yyyy";
    utcDefaultDatesFormater.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
}

+ (NSDateFormatter *)iso8601Formatter {
    return [iso8601DatesFormater copy];
}

+ (NSDateFormatter *)utcDefaultDatesFormater {
    return [utcDefaultDatesFormater copy];
}

+ (NSString *)hourMinuteFromDate:(NSDate *)date withCalendar:(NSCalendar *)calendar {
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];

    return [NSString stringWithFormat:@"%u:%02u", (uint8_t)components.hour, (uint8_t)components.minute];
}

+ (NSString *)shortDateMonthStringFromDate:(NSDate *)date withCalendar:(NSCalendar *)calendar {
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth)
                                               fromDate:date];

    NSString *monthString = [calendar.monthSymbols[(NSUInteger) components.month - 1] substringToIndex:3];

    return [NSString stringWithFormat:@"%@ %@", @(components.day), monthString];
}

+ (NSString *)shortDayMonthWeekdayStringFromDate:(NSDate *)date withCalendar:(NSCalendar *)calendar {
    return [self dayMonthWeekdayStringFromDate:date withCalendar:calendar andMaxMonthSymbolsCount:3];
}

+ (NSString *)longDayMonthWeekdayStringFromDate:(NSDate *)date withCalendar:(NSCalendar *)calendar {
    return [self dayMonthWeekdayStringFromDate:date withCalendar:calendar andMaxMonthSymbolsCount:UINT_MAX];
}

+ (NSString *)longDayMonthStringFromDate:(NSDate *)date withCalendar:(NSCalendar *)calendar {
    return [self longDayMonthYearStringFromDate:date withCalendar:calendar withYear:NO];
}

+ (NSString *)longDayMonthYearStringFromDate:(NSDate *)date withCalendar:(NSCalendar *)calendar {
    return [self longDayMonthYearStringFromDate:date withCalendar:calendar withYear:YES];
}

+ (NSString *)longDayMonthYearStringFromDate:(NSDate *)date withCalendar:(NSCalendar *)calendar withYear:(BOOL)withYear {
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear)
                                               fromDate:date];
    
    NSString *monthString = calendar.monthSymbols[(NSUInteger) components.month - 1];
    
    NSString *resultString = [NSString stringWithFormat:@"%@ %@", @(components.day), monthString];
    if (withYear) {
        resultString = [NSString stringWithFormat:@"%@ %@", resultString, @(components.year)];
    }
    
    return resultString;
}

+ (NSString *)dayMonthWeekdayStringFromDate:(NSDate *)date withCalendar:(NSCalendar *)calendar andMaxMonthSymbolsCount:(NSUInteger)maxMonthSymbolsCount {
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitWeekday)
                                               fromDate:date];

    NSString *monthString = calendar.monthSymbols[(NSUInteger) components.month - 1];

    NSUInteger lastIndex = TU_MIN(maxMonthSymbolsCount, monthString.length);
    NSString *trimmedMonthString = [monthString substringToIndex:lastIndex];

    NSString *dayOfWeekString = calendar.veryShortWeekdaySymbols[(NSUInteger) components.weekday - 1];

    return [NSString stringWithFormat:@"%@ %@, %@", @(components.day), trimmedMonthString, dayOfWeekString];
}

+ (NSString *)veryShortWeekdaySymbolForDayOfWeek:(NSUInteger)dayNumber inCalendar:(NSCalendar *)calendar {
    return calendar.veryShortWeekdaySymbols[(dayNumber + 1) % kNumberOfDaysInWeek]; //set monday as first day of week
}

+ (NSString *)minutesSecondsBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate inCalendar:(NSCalendar *)calendar {
    NSUInteger secondsBetweenTwoDates = (NSUInteger) [endDate timeIntervalSinceDate:startDate];

    const NSUInteger secondsInMinute = [calendar secondsInMinuteForDate:endDate];

    NSUInteger minutes = secondsBetweenTwoDates / secondsInMinute;
    NSUInteger seconds = secondsBetweenTwoDates - minutes * secondsInMinute;

    return [NSString stringWithFormat:@"%02u:%02u", (uint8_t)minutes, (uint8_t)seconds];
}

@end
