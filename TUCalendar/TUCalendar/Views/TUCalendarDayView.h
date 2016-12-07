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


@interface TUCalendarDayViewState : NSObject <NSCopying>

@property (nonatomic, strong, nonnull) NSString *dateInMonth;

@property (nonatomic) BOOL isToday;

@property (nonatomic) BOOL isOldDay;

@property (nonatomic) BOOL isInvisibleDay;

@property (nonatomic) TUCalendarDayViewSelectionOptions selectionOptions;

@end

@protocol TUCalendarDayViewDelegate <NSObject>

- (void)calendarDayView:(nonnull TUCalendarDayView *)calendarViewController didSelectDate:(nonnull NSDate *)date;

@end

@interface TUCalendarDayViewAppearance : NSObject

@property (nonatomic, nonnull) UIColor *selectedBackgroundColor;

@property (nonatomic, nonnull) UIImage *highlightedBackgroundImage;
@property (nonatomic, nonnull) UIImage *selectedBackgroundImage;

@property (nonatomic, nonnull) UIFont *titleFont;
@property (nonatomic, nonnull) UIColor *titleColor;
@property (nonatomic, nonnull) UIColor *hightlightedTitleColor;
@property (nonatomic, nonnull) UIColor *disabledTitleColor;
@property (nonatomic, nonnull) UIColor *rangeTitleColor;

@property (nonatomic, nonnull) UIFont *todayTitleFont;
@property (nonatomic, nonnull) UIColor *todayTitleColor;
@property (nonatomic, nonnull) NSString *todayText;

@property (nonatomic, nonnull) UIColor *backgroundColor;

+ (nullable UIImage *)backgroundImageWithColor:(nonnull UIColor *)color;

@end


@interface TUCalendarDayView : UIView

@property (nonatomic, nonnull) NSDate *date;

@property (nonatomic, nullable, weak) id<TUCalendarDayViewDelegate> delegate;

@property (nonatomic, nonnull) TUCalendarDayViewAppearance* dayViewAppearance UI_APPEARANCE_SELECTOR;

- (void)setState:(nonnull TUCalendarDayViewState *)state;

@end
