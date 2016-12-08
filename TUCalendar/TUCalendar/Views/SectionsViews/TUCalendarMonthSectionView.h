//
//  TUCalendarMonthSectionView.h
//  tutu
//
//  Created by Иван Смолин on 21/10/15.
//  Copyright © 2015 Touch Instinct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TUCalendarMonthSectionViewAppearance : NSObject 

@property (nonatomic, nonnull) UIFont *titleFont;
@property (nonatomic, nonnull) UIColor *titleColor;

@property (nonatomic, nonnull) UIFont *dayFont;

@property (nonatomic, nonnull) UIColor *dividerColor;

@property (nonatomic, nonnull) UIColor *backgroundColor;

@property (nonatomic, nullable) NSArray<NSString *> *weekdaysNames;
@property (nonatomic, nonnull) NSArray<UIColor *> *weekdaysColors;

@property (nonatomic) BOOL showYear;
@property (nonatomic) BOOL showWeekDays;

@property (nonatomic) UIEdgeInsets alignmentTitleLabelRectInsets;
@property (nonatomic) NSTextAlignment titleLabelTextAlignment;
@property (nonatomic) BOOL showDevider;

@property (nonatomic) CGFloat sectionHeaderHeight;

@end

@interface TUCalendarMonthSectionView : UIView

@property (nonatomic, nonnull) TUCalendarMonthSectionViewAppearance *monthSectionAppearance UI_APPEARANCE_SELECTOR;

@property (nonatomic, nonnull) NSCalendar *calendar;

- (void)setDateWithMonthIndex:(NSUInteger)monthIndex andYear:(NSUInteger)year;

@end
