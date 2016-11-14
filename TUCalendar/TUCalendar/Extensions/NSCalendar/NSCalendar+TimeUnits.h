//
//  NSCalendar+TimeUnits.h
//  tutu
//
//  Created by Ivan Smolin on 01/09/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (TimeUnits)

- (NSUInteger)hoursInDayForDate:(NSDate *)date;
- (NSUInteger)minutesInHourForDate:(NSDate *)date;
- (NSUInteger)secondsInMinuteForDate:(NSDate *)date;
- (NSUInteger)daysInYearForDate:(NSDate *)date;

@end
