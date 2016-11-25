//
//  TUCalendarMonthSectionView.m
//  tutu
//
//  Created by Иван Смолин on 21/10/15.
//  Copyright © 2015 Touch Instinct. All rights reserved.
//

#import <UIColor_Hex/UIColor+Hex.h>
#import "TUCalendarMonthSectionView.h"
#import "TUDateFormatter.h"
#import "NSCalendar+ApplicationCalendars.h"

static NSUInteger const kNumberOfDaysInWeek = 7;
static CGFloat const kMonthLabelTopToSuperviewSpace = 8.f;
static CGFloat const kMonthLabelHeight = 18.f;
static CGFloat const kDaysToMonthVerticalSpace = 10.f;
static CGFloat const kDaysLabelsLeftRightInset = 6.f;
static CGFloat const kDayLabelHeight = 14.f;


@implementation TUCalendarMonthSectionViewAppearance

- (instancetype)init {
    self = [super init];

    if (self) {
        self.titleFont = [UIFont systemFontOfSize:15.f];
        self.titleColor = [UIColor colorWithHex:0x0099FF];

        self.dayFont = [UIFont systemFontOfSize:11.f];

        self.weekdayColor = [UIColor colorWithHex:0x7B95AA];
        self.weekendColor = [UIColor colorWithHex:0xC33D1A];

        self.dividerColor = [UIColor colorWithHex:0x7B95AA];

        self.backgroundColor = [UIColor whiteColor];
    }

    return self;
}


@end

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
    UILabel *monthNameLabel = [UILabel new];
    monthNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:monthNameLabel];
    self.monthNameLabel = monthNameLabel;

    NSMutableArray<UILabel *> *daysLabels = [NSMutableArray arrayWithCapacity:kNumberOfDaysInWeek];

    NSCalendar *calendar = [NSCalendar currentRUCalendar];
    
    for (NSUInteger i = 0; i < kNumberOfDaysInWeek; i++) {
        UILabel *dayLabel = [UILabel new];
        dayLabel.alpha = 0.5f;
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.text = [[TUDateFormatter veryShortWeekdaySymbolForDayOfWeek:i inCalendar:calendar] uppercaseString];
        [self addSubview:dayLabel];
        [daysLabels addObject:dayLabel];
    }
    
    self.daysLabels = [daysLabels copy];
    
    UIView *divider = [UIView new];
    divider.alpha = 0.25;
    [self addSubview:divider];
    self.divider = divider;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.monthNameLabel.frame = CGRectMake(0.f, kMonthLabelTopToSuperviewSpace, width, kMonthLabelHeight);
    
    CGFloat dividerHeight = 0.5f;
    self.divider.frame = CGRectMake(0.f, height - dividerHeight, width, dividerHeight);
    
    CGFloat daysY = CGRectGetMaxY(self.monthNameLabel.frame) + kDaysToMonthVerticalSpace;
    CGFloat dayViewWidth = (width - 2 * kDaysLabelsLeftRightInset) / kNumberOfDaysInWeek;
    [self.daysLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull dayLabel, NSUInteger idx, BOOL * _Nonnull stop) {
        dayLabel.frame = CGRectMake(kDaysLabelsLeftRightInset + dayViewWidth * idx, daysY, dayViewWidth, kDayLabelHeight);
    }];
}

- (void)setMonthName:(NSString *)monthName {
    self.monthNameLabel.text = monthName;
}

- (void)setMonthSectionAppearance:(TUCalendarMonthSectionViewAppearance *)monthSectionAppearance {
    _monthSectionAppearance = monthSectionAppearance;

    self.monthNameLabel.font = self.monthSectionAppearance.titleFont;
    self.monthNameLabel.textColor = self.monthSectionAppearance.titleColor;

    NSArray<UIColor *> *daysColors = @[
            self.monthSectionAppearance.weekdayColor,
            self.monthSectionAppearance.weekdayColor,
            self.monthSectionAppearance.weekdayColor,
            self.monthSectionAppearance.weekdayColor,
            self.monthSectionAppearance.weekdayColor,
            self.monthSectionAppearance.weekendColor,
            self.monthSectionAppearance.weekendColor,
    ];

    for (NSUInteger i = 0; i < kNumberOfDaysInWeek; ++i) {
        self.daysLabels[i].font = self.monthSectionAppearance.dayFont;
        self.daysLabels[i].textColor = daysColors[i];
    }

    self.divider.backgroundColor = self.monthSectionAppearance.dividerColor;

    self.backgroundColor = self.monthSectionAppearance.backgroundColor;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];

    if (!self.monthSectionAppearance) {
        self.monthSectionAppearance = [TUCalendarMonthSectionViewAppearance new];
    }
}

@end
