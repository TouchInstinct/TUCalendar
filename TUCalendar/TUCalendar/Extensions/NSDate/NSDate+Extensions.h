//
// Created by Иван Смолин on 18/08/15.
// Copyright (c) 2015 Touch Instinct. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSCalendarUnit kYearMonthDateFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

@interface NSDate (Extensions)

+ (instancetype)localDateFromISO8601StringDate:(NSString *)stringDate utcCalendar:(NSCalendar *)utcCalendar; // 2016-02-08T18:35:29+03:00 -> 2016-02-08T18:35:29+00:00

+ (NSDate *)dateWithoutTimeInCalendar:(NSCalendar *)calendar;

+ (NSDate *)tommorowDateInCalendar:(NSCalendar *)calendar;

- (NSDate *)firstDateForComponents:(NSCalendarUnit)units inCalendar:(NSCalendar *)calendar;

- (BOOL)isEqualToDate:(NSDate *)anotherDate withUnitFlags:(NSCalendarUnit)unitFlags calendar:(NSCalendar *)calendar;

- (BOOL)isSameDayWithDate:(NSDate *)anotherDate calendar:(NSCalendar *)calendar;

- (NSDate *)dateWithComponents:(NSCalendarUnit)unitFlags calendar:(NSCalendar *)calendar;

- (NSDate *)timelessDateInCalendar:(NSCalendar *)calendar;

- (BOOL)isDateBetweenStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate;

- (instancetype)dateMovedFromCalendar:(NSCalendar *)dateCalendar toCalendar:(NSCalendar *)newCalendar unitFlags:(NSCalendarUnit)flags;

- (instancetype)dateShiftedToDayOfDate:(NSDate *)otherDay inCalendar:(NSCalendar *)calendar;

@end
