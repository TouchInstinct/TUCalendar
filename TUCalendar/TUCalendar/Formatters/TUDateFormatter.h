//
//  TUDateFormatter.h
//  tutu
//
//  Created by Иван Смолин on 22/09/15.
//  Copyright (c) 2015 Touch Instinct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TUDateFormatter : NSObject

+ (NSDateFormatter *)iso8601Formatter; // 2015-07-01T13:24:00+04:00

+ (NSDateFormatter *)utcDefaultDatesFormater;

+ (NSString *)hourMinuteFromDate:(NSDate *)date withCalendar:(NSCalendar *)calendar; // 12:45, 9:15, 8:00, 0:05

+ (NSString *)shortDateMonthStringFromDate:(NSDate *)date withCalendar:(NSCalendar *)calendar;  // 17 ноя

+ (NSString *)shortDayMonthWeekdayStringFromDate:(NSDate *)date withCalendar:(NSCalendar *)calendar; // 17 ноя, вт

+ (NSString *)longDayMonthWeekdayStringFromDate:(NSDate *)date withCalendar:(NSCalendar *)calendar; // 17 ноября, вт

+ (NSString *)longDayMonthYearStringFromDate:(NSDate *)date withCalendar:(NSCalendar *)calendar; // 17 ноября 2015

+ (NSString *)longDayMonthStringFromDate:(NSDate *)date withCalendar:(NSCalendar *)calendar; // 17 ноября

+ (NSString *)veryShortWeekdaySymbolForDayOfWeek:(NSUInteger)dayNumber inCalendar:(NSCalendar *)calendar;

+ (NSString *)minutesSecondsBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate inCalendar:(NSCalendar *)calendar;

@end
