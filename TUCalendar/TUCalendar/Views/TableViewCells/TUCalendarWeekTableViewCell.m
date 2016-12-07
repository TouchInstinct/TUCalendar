//
//  TUCalendarWeekTableViewCell.m
//  tutu
//
//  Created by Иван Смолин on 20/10/15.
//  Copyright © 2015 Touch Instinct. All rights reserved.
//

#import <UIColor_Hex/UIColor+Hex.h>
#import "TUCalendarWeekTableViewCell.h"
#import "TUCalendarDayView.h"
#import "NSDate+Extensions.h"

static CGFloat const kCellHeight = 48.f;
static CGFloat const kDaysViewsInset = 6.f;
static NSUInteger const kNumberOfDaysInWeek = 7;

@implementation TUCalendarWeekTableViewCellAppearance

- (instancetype)init {
    self = [super init];

    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


@end

@interface TUCalendarWeekTableViewCell () <TUCalendarDayViewDelegate>

@property (strong, nonatomic) UIView *leftSelectedRangeView;
@property (strong, nonatomic) UIView *rightSelectedRangeView;
@property (strong, nonatomic) NSArray<TUCalendarDayView *> *daysViews;

@end

@implementation TUCalendarWeekTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    NSMutableArray<TUCalendarDayView *> *daysViews = [NSMutableArray arrayWithCapacity:kNumberOfDaysInWeek];
    
    for (NSUInteger i = 0; i < kNumberOfDaysInWeek; i++) {
        TUCalendarDayView *dayView = [TUCalendarDayView new];
        [self addSubview:dayView];
        [daysViews addObject:dayView];
    }
    
    self.daysViews = [daysViews copy];
    
    UIColor *selectedBgColor = [UIColor colorWithHex:0xE5F4FF];
    
    UIView *leftSelectedRangeView = [UIView new];
    leftSelectedRangeView.backgroundColor = selectedBgColor;
    self.leftSelectedRangeView = leftSelectedRangeView;
    
    UIView *rightSelectedRangeView = [UIView new];
    rightSelectedRangeView.backgroundColor = selectedBgColor;
    self.rightSelectedRangeView = rightSelectedRangeView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat selfWidth = self.frame.size.width;
    CGFloat dayViewWidth = (selfWidth - 2 * kDaysViewsInset) / kNumberOfDaysInWeek;
    
    CGFloat dayHeight = kCellHeight - 2 * kDaysViewsInset;
    [self.daysViews enumerateObjectsUsingBlock:^(TUCalendarDayView * _Nonnull dayView, NSUInteger idx, BOOL * _Nonnull stop) {
        dayView.frame = CGRectMake(kDaysViewsInset + dayViewWidth * idx, kDaysViewsInset, dayViewWidth, dayHeight);
    }];
    
    self.leftSelectedRangeView.frame = CGRectMake(0.f, kDaysViewsInset, kDaysViewsInset, dayHeight);
    self.rightSelectedRangeView.frame = CGRectMake(selfWidth - kDaysViewsInset, kDaysViewsInset, kDaysViewsInset, dayHeight);
}

- (void)setFirstDateOfWeek:(nonnull NSDate *)firstDayInWeek
            withDataSource:(nonnull id<TUCalendarWeekTableViewCellDataSource>)dataSource
               monthNumber:(NSInteger)monthNumber
             departureDate:(nullable NSDate *)departureDate
                returnDate:(nullable NSDate *)returnDate {
    if (!self.weekCellAppearance) {
        self.weekCellAppearance = [TUCalendarWeekTableViewCellAppearance new];
    }

    self.backgroundColor = self.weekCellAppearance.backgroundColor;
    
    NSUInteger daysCount = self.daysViews.count;

    NSMutableArray *weekSettings = [NSMutableArray arrayWithCapacity:daysCount];

    NSInteger departureDateMonth = [self.calendar component:NSCalendarUnitMonth fromDate:departureDate];
    NSInteger returnDateMonth = [self.calendar component:NSCalendarUnitMonth fromDate:returnDate];

    NSDate *lastDayOfWeek = [self.calendar dateByAddingUnit:NSCalendarUnitDay value:daysCount + 1 toDate:firstDayInWeek options:0];

    for (NSUInteger dayIndex = 0; dayIndex < daysCount; ++dayIndex) {
        NSDate *currentDayDate = [self.calendar dateByAddingUnit:NSCalendarUnitDay value:dayIndex toDate:firstDayInWeek options:0];

        TUCalendarDayViewState *currentDateSettings = [[dataSource calendarDayViewSettingsForDate:currentDayDate] copy];

        NSInteger currentDateMonthNumber = [self.calendar component:NSCalendarUnitMonth fromDate:currentDayDate];

        currentDateSettings.isInvisibleDay = currentDateMonthNumber != monthNumber;

        if (departureDate && returnDate && currentDateSettings.isInvisibleDay && !([departureDate isEqualToDate:returnDate])) {
            BOOL departureDateOnThisWeek = [departureDate isDateBetweenStartDate:firstDayInWeek andEndDate:lastDayOfWeek];

            BOOL returnDateOnThisWeek = [returnDate isDateBetweenStartDate:firstDayInWeek andEndDate:lastDayOfWeek];

            if (departureDateOnThisWeek && returnDateOnThisWeek) {
                if (departureDateMonth == returnDateMonth) {
                    if (departureDateMonth != monthNumber
                            || [currentDayDate compare:returnDate] == NSOrderedDescending
                            || [currentDayDate compare:departureDate] == NSOrderedAscending)
                        currentDateSettings.selectionOptions = TUCalendarDayViewSelectionNone;
                } else if ([currentDayDate compare:returnDate] == NSOrderedDescending && returnDateMonth <= monthNumber) {
                    currentDateSettings.selectionOptions = TUCalendarDayViewSelectionNone;
                } else {
                    currentDateSettings.selectionOptions = TUCalendarDayViewSelectionFull;
                }
            } else if (departureDateOnThisWeek) {
                if (monthNumber > departureDateMonth) {
                    currentDateSettings.selectionOptions = TUCalendarDayViewSelectionFull;
                } else if ([currentDayDate compare:departureDate] == NSOrderedAscending
                        || monthNumber < departureDateMonth) {
                    currentDateSettings.selectionOptions = TUCalendarDayViewSelectionNone;
                }
            } else if (returnDateOnThisWeek) {
                if (monthNumber < returnDateMonth) {
                    currentDateSettings.selectionOptions = TUCalendarDayViewSelectionFull;
                } else if ([currentDayDate compare:returnDate] == NSOrderedDescending
                        || monthNumber > returnDateMonth) {
                    currentDateSettings.selectionOptions = TUCalendarDayViewSelectionNone;
                }
            }
        }

        TUCalendarDayView *dayView = self.daysViews[dayIndex];
        dayView.state = currentDateSettings;
        dayView.date = currentDayDate;
        dayView.delegate = self;

        [weekSettings addObject:currentDateSettings];
    }

    TUCalendarDayViewState *firstDaySettings = weekSettings.firstObject;
    self.leftSelectedRangeView.hidden = !(firstDaySettings.selectionOptions & TUCalendarDayViewSelectionLeftFull);

    TUCalendarDayViewState *lastDaySettings = weekSettings.lastObject;
    self.rightSelectedRangeView.hidden = !(lastDaySettings.selectionOptions & TUCalendarDayViewSelectionRightFull);
}

- (void)calendarDayView:(TUCalendarDayView *)calendarViewController didSelectDate:(NSDate *)date {
    [self.delegate calendarWeekTableViewCellSelectDate:date];
}

- (void)setWeekCellAppearance:(TUCalendarWeekTableViewCellAppearance *)weekCellAppearance {
    _weekCellAppearance = weekCellAppearance;

    self.backgroundColor = self.weekCellAppearance.backgroundColor;
}

#pragma mark - TUStaticViewHeightProtocol

+ (CGFloat)viewHeight {
    return kCellHeight;
}

@end
