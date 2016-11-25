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

@end

@interface TUCalendarMonthSectionView : UIView

@property (nonatomic, nonnull) TUCalendarMonthSectionViewAppearance *monthSectionAppearance UI_APPEARANCE_SELECTOR;

@property (nonatomic, nonnull) NSCalendar *calendar;

- (void)setMonthIndex:(NSUInteger)monthIndex;

@end
