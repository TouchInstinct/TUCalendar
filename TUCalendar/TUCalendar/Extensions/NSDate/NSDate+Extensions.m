//
// Created by Иван Смолин on 18/08/15.
// Copyright (c) 2015 Touch Instinct. All rights reserved.
//

#import "NSDate+Extensions.h"
#import "NSDateFormatter+TUDateFormatters.h"

@implementation NSDate (Extensions)

- (NSDate *)firstDateForComponents:(NSCalendarUnit)units inCalendar:(NSCalendar *)calendar {
    NSDateComponents *components = nil;

    if (units & NSCalendarUnitMonth) {
        if (units & NSCalendarUnitWeekOfMonth) {
            components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday)
                                     fromDate:self];

            components.weekOfMonth = 1;
            components.weekday = calendar.firstWeekday;
        } else {
            components = [calendar components:kYearMonthDateFlags
                                     fromDate:self];
            components.day = 1;
        }
    }

    return components ? [calendar dateFromComponents:components] : nil;
}

- (BOOL)isEqualToDate:(NSDate *)anotherDate withUnitFlags:(NSCalendarUnit)unitFlags calendar:(NSCalendar *)calendar {
    return [[self dateWithComponents:unitFlags calendar:calendar] isEqualToDate:[anotherDate dateWithComponents:unitFlags
                                                                                                       calendar:calendar]];
}

- (BOOL)isSameDayWithDate:(NSDate *)anotherDate calendar:(NSCalendar *)calendar {
    return [self isEqualToDate:anotherDate
                 withUnitFlags:kYearMonthDateFlags
                      calendar:calendar];
}

- (NSDate *)dateWithComponents:(NSCalendarUnit)unitFlags calendar:(NSCalendar *)calendar {
    return [calendar dateFromComponents:[calendar components:unitFlags fromDate:self]];
}

+ (NSDate *)dateWithoutTimeInCalendar:(NSCalendar *)calendar {
    return [[self date] timelessDateInCalendar:calendar];
}

+ (NSDate *)tommorowDateInCalendar:(NSCalendar *)calendar {
    return [[calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:[self date] options:1] timelessDateInCalendar:calendar];
}

- (NSDate *)timelessDateInCalendar:(NSCalendar *)calendar {
    return [self dateWithComponents:kYearMonthDateFlags
                           calendar:calendar];
}

- (BOOL)isDateBetweenStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate {
    NSComparisonResult startDateResult = [self compare:startDate];
    NSComparisonResult endDateResult = [self compare:endDate];

    return (startDate && endDate)
            && (startDateResult == NSOrderedDescending || startDateResult == NSOrderedSame)
            && (endDateResult == NSOrderedAscending || endDateResult == NSOrderedSame);
}

- (instancetype)dateMovedFromCalendar:(NSCalendar *)dateCalendar toCalendar:(NSCalendar *)newCalendar unitFlags:(NSCalendarUnit)flags {
    return [newCalendar dateFromComponents:[dateCalendar components:flags fromDate:self]];
}

+ (instancetype)localDateFromISO8601StringDate:(NSString *)stringDate utcCalendar:(NSCalendar *)utcCalendar {
    NSDateFormatter *iso8601Formatter = [NSDateFormatter iso8601Formatter];

    NSDate *utcDate = [iso8601Formatter dateFromString:stringDate];

    NSUInteger timezoneIndex = [stringDate rangeOfString:@"+"].location;

    BOOL isPlus = YES;

    if (timezoneIndex == NSNotFound) {
        NSUInteger timeAndTimezoneLocation = [stringDate rangeOfString:@"T"].location;

        NSString *timeAndTimeZone = [stringDate substringFromIndex:timeAndTimezoneLocation + 1];
        timezoneIndex = (timeAndTimezoneLocation + 1) + ([timeAndTimeZone rangeOfString:@"-"].location + 1);

        isPlus = NO;
    }

    NSString *hourMinuteTimezone = [stringDate substringFromIndex:timezoneIndex];
    NSArray<NSString *> *hourMinuteComponents = [hourMinuteTimezone componentsSeparatedByString:@":"];

    NSString *hourComponentString = hourMinuteComponents.firstObject;
    NSString *minuteComponentString = hourMinuteComponents.lastObject;

    NSInteger hourComponent = [hourComponentString integerValue];
    NSInteger minuteComponent = [minuteComponentString integerValue];

    NSInteger sign = isPlus ? 1 : -1;

    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.hour = hourComponent * sign;
    dateComponents.minute = minuteComponent * sign;

    return [utcCalendar dateByAddingComponents:dateComponents toDate:utcDate options:0];
}

- (instancetype)dateShiftedToDayOfDate:(NSDate *)otherDay inCalendar:(NSCalendar *)calendar {
    NSDateComponents *otherDateComponents = [calendar components:kYearMonthDateFlags fromDate:otherDay];

    NSDateComponents *dateComponents = [calendar components:kYearMonthDateFlags | NSCalendarUnitHour | NSCalendarUnitMinute
                                                   fromDate:self];
    dateComponents.year = otherDateComponents.year;
    dateComponents.month = otherDateComponents.month;
    dateComponents.day = otherDateComponents.day;

    return [calendar dateFromComponents:dateComponents];
}

@end
