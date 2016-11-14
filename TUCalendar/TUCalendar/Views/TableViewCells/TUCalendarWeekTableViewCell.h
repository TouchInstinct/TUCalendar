//
//  TUCalendarWeekTableViewCell.h
//  tutu
//
//  Created by Иван Смолин on 20/10/15.
//  Copyright © 2015 Touch Instinct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TUReuseIdentifierProtocol.h"

@class TUCalendarDayViewSettings;

@protocol TUCalendarWeekTableViewCellDataSource <NSObject>

- (nonnull TUCalendarDayViewSettings *)calendarDayViewSettingsForDate:(nonnull NSDate *)date;

@end

@protocol TUCalendarWeekTableViewCellDelegate <NSObject>

- (void)calendarWeekTableViewCellSelectDate:(nonnull NSDate *)date;

@end

@interface TUCalendarWeekTableViewCell : UITableViewCell <TUReuseIdentifierProtocol>

@property (nonatomic, nullable, weak) id<TUCalendarWeekTableViewCellDelegate> delegate;

- (void)setFirstDateOfWeek:(nonnull NSDate *)firstDayInWeek
            withDataSource:(nonnull id<TUCalendarWeekTableViewCellDataSource>)dataSource
               monthNumber:(NSInteger)monthNumber
             departureDate:(nullable NSDate *)departureDate
                returnDate:(nullable NSDate *)returnDate;

@property (nonatomic, nonnull, strong) NSCalendar *calendar;

@end
