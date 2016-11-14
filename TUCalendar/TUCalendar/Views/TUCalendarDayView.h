//
//  TUCalendarDayView.h
//  tutu
//
//  Created by Иван Смолин on 20/10/15.
//  Copyright © 2015 Touch Instinct. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TUCalendarDayView;

typedef NS_OPTIONS(NSUInteger, TUCalendarDayViewSelectionOptions) {
    TUCalendarDayViewSelectionNone = 0,
    TUCalendarDayViewSelectionLeftFull = 1 << 0,
    TUCalendarDayViewSelectionRightFull = 1 << 1,
    TUCalendarDayViewSelectionFull = TUCalendarDayViewSelectionLeftFull | TUCalendarDayViewSelectionRightFull,
    TUCalendarDayViewSelectionDate = 1 << 2,
    TUCalendarDayViewSelectionDateStrong = 1 << 3,
};


@interface TUCalendarDayViewSettings : NSObject <NSCopying>

@property (nonatomic, strong, nonnull) NSString *dateInMonth;

@property (nonatomic) BOOL isToday;

@property (nonatomic) BOOL isOldDay;

@property (nonatomic) BOOL isInvisibleDay;

@property (nonatomic) TUCalendarDayViewSelectionOptions selectionOptions;

@end

@protocol TUCalendarDayViewDelegate <NSObject>

- (void)calendarDayView:(nonnull TUCalendarDayView *)calendarViewController didSelectDate:(nonnull NSDate *)date;

@end


@interface TUCalendarDayView : UIView

@property (nonatomic, strong, nonnull) NSDate *date;

@property (nonatomic, nullable, weak) id<TUCalendarDayViewDelegate> delegate;

- (void)setSettings:(nonnull TUCalendarDayViewSettings *)settings;

@end
