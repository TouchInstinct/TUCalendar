//
//  TUCalendarMonthSectionView.m
//  tutu
//
//  Created by Иван Смолин on 21/10/15.
//  Copyright © 2015 Touch Instinct. All rights reserved.
//

#import <UIColor_Hex/UIColor+Hex.h>
#import "TUCalendarMonthSectionView.h"
#import "TUFont.h"
#import "TUDateFormatter.h"
#import "TUColor.h"
#import "NSCalendar+ApplicationCalendars.h"

static NSUInteger const kNumberOfDaysInWeek = 7;
static CGFloat const kMonthLabelTopToSuperviewSpace = 8.f;
static CGFloat const kMonthLabelHeight = 18.f;
static CGFloat const kDaysToMonthVerticalSpace = 10.f;
static CGFloat const kDaysLabelsLeftRightInset = 6.f;
static CGFloat const kDayLabelHeight = 14.f;

@interface TUCalendarMonthSectionView ()

@property (strong, nonatomic) UILabel *monthNameLabel;
@property (strong, nonatomic) NSArray<UILabel *> *daysLabels;
@property (strong, nonatomic) UIView *divider;

@end

@implementation TUCalendarMonthSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *monthNameLabel = [UILabel new];
    monthNameLabel.textColor = [TUColor mainBlueColor];
    monthNameLabel.font = [TUFont firaSansRegularOfSize:15];
    monthNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:monthNameLabel];
    self.monthNameLabel = monthNameLabel;
    
    UIColor *weekdayColor = [UIColor colorWithHex:0x7B95AA];
    UIColor *weekendColor = [UIColor colorWithHex:0xC33D1A];
    
    NSArray<UIColor *> *daysColors = @[
                           weekdayColor,
                           weekdayColor,
                           weekdayColor,
                           weekdayColor,
                           weekdayColor,
                           weekendColor,
                           weekendColor,
                           ];
    
    NSMutableArray<UILabel *> *daysLabels = [NSMutableArray arrayWithCapacity:kNumberOfDaysInWeek];

    NSCalendar *calendar = [NSCalendar currentRUCalendar];
    
    for (NSUInteger i = 0; i < kNumberOfDaysInWeek; i++) {
        UILabel *dayLabel = [UILabel new];
        dayLabel.textColor = daysColors[i];
        dayLabel.alpha = 0.5f;
        dayLabel.font = [TUFont firaSansRegularOfSize:11];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.text = [[TUDateFormatter veryShortWeekdaySymbolForDayOfWeek:i inCalendar:calendar] uppercaseString];
        [self addSubview:dayLabel];
        [daysLabels addObject:dayLabel];
    }
    
    self.daysLabels = [daysLabels copy];
    
    UIView *divider = [UIView new];
    divider.backgroundColor = [UIColor colorWithHex:0x7B95AA];
    divider.alpha = 0.25;
    [self addSubview:divider];
    self.divider = divider;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    self.monthNameLabel.frame = CGRectMake(0.f, kMonthLabelTopToSuperviewSpace, selfWidth, kMonthLabelHeight);
    
    CGFloat dividerHeight = 0.5f;
    self.divider.frame = CGRectMake(0.f, selfHeight - dividerHeight, selfWidth, dividerHeight);
    
    CGFloat daysY = CGRectGetMaxY(self.monthNameLabel.frame) + kDaysToMonthVerticalSpace;
    CGFloat dayViewWidth = (selfWidth - 2 * kDaysLabelsLeftRightInset) / kNumberOfDaysInWeek;
    [self.daysLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull dayLabel, NSUInteger idx, BOOL * _Nonnull stop) {
        dayLabel.frame = CGRectMake(kDaysLabelsLeftRightInset + dayViewWidth * idx, daysY, dayViewWidth, kDayLabelHeight);
    }];
}

- (void)setMonthName:(NSString *)monthName {
    self.monthNameLabel.text = monthName;
}

@end
