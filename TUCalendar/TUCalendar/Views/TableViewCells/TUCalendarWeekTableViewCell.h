//
//  TUCalendarWeekTableViewCell.h
//  tutu
//
//  Created by Иван Смолин on 20/10/15.
//  Copyright © 2015 Touch Instinct. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TUStaticViewHeightProtocol.h"

@class TUCalendarDayViewState;

@protocol TUCalendarWeekTableViewCellDataSource <NSObject>

- (nonnull TUCalendarDayViewState *)calendarDayViewSettingsForDate:(nonnull NSDate *)date;

@end

@protocol TUCalendarWeekTableViewCellDelegate <NSObject>

- (void)calendarWeekTableViewCellSelectDate:(nonnull NSDate *)date;

@end

@interface TUCalendarWeekTableViewCellAppearance : NSObject

@property (nonatomic, nonnull) UIColor *backgroundColor;

@end

@interface TUCalendarWeekTableViewCell : UITableViewCell <TUStaticViewHeightProtocol>

@property (nonatomic, nullable, weak) id<TUCalendarWeekTableViewCellDelegate> delegate;

- (void)setFirstDateOfWeek:(nonnull NSDate *)firstDayInWeek
            withDataSource:(nonnull id<TUCalendarWeekTableViewCellDataSource>)dataSource
          currentMonthDate:(nullable NSDate *)currentMonthDate
             departureDate:(nullable NSDate *)departureDate
                returnDate:(nullable NSDate *)returnDate;

@property (nonatomic, nonnull, strong) NSCalendar *calendar;

@property (nonatomic, nonnull) TUCalendarWeekTableViewCellAppearance* weekCellAppearance UI_APPEARANCE_SELECTOR;

@end
