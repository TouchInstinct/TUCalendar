//
//  TUCalendarViewController.m
//  tutu
//
//  Created by Иван Смолин on 20/10/15.
//  Copyright © 2015 Touch Instinct. All rights reserved.
//

#import "TUCalendarViewController.h"
#import "UITableView+CellRegistration.h"
#import "TUCalendarWeekTableViewCell.h"
#import "TUCalendarMonthSectionView.h"
#import "NSDate+Extensions.h"
#import "NSCalendar+ApplicationCalendars.h"
#import "TUCalendarDayView.h"
#import "UITableViewCell+DequeueFromTableView.h"
#import "NSCalendar+TimeUnits.h"

static const NSInteger kNumberOfDaysInWeek = 7;


@interface TUCalendarViewController () <UITableViewDataSource, UITableViewDelegate, TUCalendarWeekTableViewCellDataSource, TUCalendarWeekTableViewCellDelegate> {
    NSMutableDictionary<NSDate *, TUCalendarDayViewState *> *_calculatedSettings;
    NSDictionary<NSIndexPath *, NSDate *> *_firstDayOfWeekForIndexPath;
    NSDictionary<NSDate *, NSNumber *> *_numberOfWeeksInMonth;
    NSDate *_today;

    NSArray<NSDate *> *_monthDates;

    NSUInteger _numberOfMonthsInYear;

    NSUInteger _numberOfDaysInYear;

    NSArray<TUCalendarMonthSectionView *> *_preloadedMonthSectionViews;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *navbarTitleLabel;

@end

@implementation TUCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.isDepartureSelect) {
        NSString *deparuteDateTitle = NSLocalizedString(@"common_calendar_departure_title", @"Дата вылета");

        self.navbarTitleLabel.text = deparuteDateTitle ? deparuteDateTitle : @"Departure date";
    } else {
        NSString *returnDateTitle = NSLocalizedString(@"common_calendar_arrival_title", @"Дата возвращения");

        self.navbarTitleLabel.text = returnDateTitle ? returnDateTitle : @"Return date";
    }

    [self initInstanceVariables];

    [self.tableView registerCellClass:[TUCalendarWeekTableViewCell class]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSDate *firstSelectedDate = self.departureDate ? self.departureDate : self.returnDate;

    if (firstSelectedDate) {
        NSDate *firstDateInCalendar = _firstDayOfWeekForIndexPath[[NSIndexPath indexPathForRow:0 inSection:0]];

        // firstDateInCalendar can be from previous month, so use last date of week (+7)
        NSDate *lastDayInWeekForIndexPath = [self.calendar dateByAddingUnit:NSCalendarUnitDay
                                                                      value:kNumberOfDaysInWeek
                                                                     toDate:firstDateInCalendar
                                                                    options:0];

        // and pick first day of month next
        NSDate *firstDateInMonth = [lastDayInWeekForIndexPath firstDateForComponents:NSCalendarUnitMonth 
                                                                          inCalendar:self.calendar];

        // calculate section as difference between first day of first month in calendar and selected date
        NSInteger monthesBetween = [self.calendar components:NSCalendarUnitMonth
                                                    fromDate:firstDateInMonth
                                                      toDate:firstSelectedDate
                                                     options:0].month;

        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:monthesBetween]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:NO];
    }
}

- (void)initInstanceVariables {
    self.calendar = self.calendar ? self.calendar : [NSCalendar currentRUCalendar];

    _today = [NSDate dateWithoutTimeInCalendar:self.calendar];

    _numberOfMonthsInYear = self.calendar.monthSymbols.count;

    _numberOfDaysInYear = [self.calendar daysInYearForDate:_today];

    [self initMonthIVars];

    [self initCalculatedSettings];

    [self initNumberOfWeeksInMonths];

    [self initFirstDaysOfWeeksForIndexPath];
}

- (void)initFirstDaysOfWeeksForIndexPath {
    NSMutableDictionary *mutableFirstDaysOfWeek = [NSMutableDictionary dictionaryWithCapacity:_numberOfDaysInYear / kNumberOfDaysInWeek];

    for (NSUInteger section = 0; section < [self numberOfSectionsInTableView:self.tableView]; ++section) {
        for (NSUInteger row = 0; row < [self tableView:self.tableView numberOfRowsInSection:section]; ++row) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];

            NSDate *firstDayInMonthWeek = [self getFirstDayInMonthWeekForSection:section];

            NSDate *rowFirstDayInWeek = [self.calendar dateByAddingUnit:NSCalendarUnitWeekOfMonth value:row toDate:firstDayInMonthWeek options:0];

            mutableFirstDaysOfWeek[indexPath] = rowFirstDayInWeek;
        }
    }

    _firstDayOfWeekForIndexPath = [mutableFirstDaysOfWeek copy];
}

- (void)initNumberOfWeeksInMonths {
    NSMutableDictionary *mutableNumberOfWeeksInMonth = [NSMutableDictionary dictionaryWithCapacity:_numberOfMonthsInYear];

    for (NSDate *monthDate in _monthDates) {
        NSUInteger numberOfWeeksInMonth = [self.calendar rangeOfUnit:NSCalendarUnitWeekOfMonth
                                                              inUnit:NSCalendarUnitMonth
                                                             forDate:monthDate].length;

        mutableNumberOfWeeksInMonth[monthDate] = @(numberOfWeeksInMonth);
    }

    _numberOfWeeksInMonth = [mutableNumberOfWeeksInMonth copy];
}

- (void)initCalculatedSettings {
    NSDate *lastMonthDate = _monthDates.lastObject;

    NSDate *nextMonthAfterLast = [self.calendar dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:lastMonthDate options:0];
    nextMonthAfterLast = [self.calendar dateByAddingUnit:NSCalendarUnitWeekOfMonth value:1 toDate:nextMonthAfterLast options:0];

    NSDate *currentDate = [_today firstDateForComponents:NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth inCalendar:self.calendar];

    _calculatedSettings = [NSMutableDictionary dictionaryWithCapacity:_numberOfDaysInYear]; // approximately

    while ([currentDate compare:nextMonthAfterLast] == NSOrderedAscending) {
        _calculatedSettings[currentDate] = [self calculateSettingsForDate:currentDate];
        currentDate = [self.calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:currentDate options:0]; // increment
    }
}

- (TUCalendarDayViewState *)calculateSettingsForDate:(NSDate *)date {
    TUCalendarDayViewState *settings = [TUCalendarDayViewState new];

    settings.isOldDay = [date compare:_today] == NSOrderedAscending;
    settings.isToday = [_today isSameDayWithDate:date calendar:self.calendar];
    settings.dateInMonth = @([self.calendar component:NSCalendarUnitDay fromDate:date]).stringValue;
    settings.selectionOptions = TUCalendarDayViewSelectionNone;

    BOOL isDepartureDate = self.departureDate && [date isEqualToDate:self.departureDate];
    BOOL isReturnDate = self.returnDate && [date isEqualToDate:self.returnDate];

    if (isDepartureDate || isReturnDate) {
        BOOL hightlightSelectedDate = (isDepartureDate && self.isDepartureSelect) || (isReturnDate && !self.isDepartureSelect);

        if (hightlightSelectedDate) {
            settings.selectionOptions |= TUCalendarDayViewSelectionDateStrong;
        } else {
            settings.selectionOptions |= TUCalendarDayViewSelectionDate;
        }

        if (!(isDepartureDate && isReturnDate)) {
            if (isDepartureDate && self.returnDate) {
                settings.selectionOptions |= TUCalendarDayViewSelectionRightFull;
            } else if (isReturnDate && self.departureDate) {
                settings.selectionOptions |= TUCalendarDayViewSelectionLeftFull;
            }
        }
    } else if ([date isDateBetweenStartDate:self.departureDate andEndDate:self.returnDate]) {
        settings.selectionOptions |= TUCalendarDayViewSelectionFull;
    }

    return settings;
}

- (void)initMonthIVars {
    NSMutableArray *mutableMonthDays = [NSMutableArray arrayWithCapacity:_numberOfMonthsInYear];

    NSMutableArray *mutablePreloadedMonthViews = [NSMutableArray arrayWithCapacity:_numberOfMonthsInYear];

    for (NSUInteger i = 0; i < _numberOfMonthsInYear; ++i) {
        NSDate *nextMonthDate = [self.calendar dateByAddingUnit:NSCalendarUnitMonth value:i toDate:_today options:0];

        TUCalendarMonthSectionView *monthSectionView = [TUCalendarMonthSectionView new];
        NSInteger currentMonth = [self.calendar component:NSCalendarUnitMonth fromDate:_today];
        NSInteger nextMonthYear = [self.calendar component:NSCalendarUnitYear fromDate:nextMonthDate];
        NSInteger sectionMonthIndex = (currentMonth + i - 1) % _numberOfMonthsInYear;

        monthSectionView.calendar = self.calendar;
        [monthSectionView setMonthIndex:sectionMonthIndex andYear: nextMonthYear];

        mutablePreloadedMonthViews[i] = monthSectionView;

        mutableMonthDays[i] = [nextMonthDate dateWithComponents:(NSCalendarUnitYear | NSCalendarUnitMonth)
                                                       calendar:self.calendar];
    }

    _preloadedMonthSectionViews = [mutablePreloadedMonthViews copy];

    _monthDates = [mutableMonthDays copy];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _numberOfMonthsInYear;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSNumber *numberOfWeeksInMounth = _numberOfWeeksInMonth[_monthDates[(NSUInteger) section]];

    return [numberOfWeeksInMounth integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TUCalendarWeekTableViewCell *weekCell = [TUCalendarWeekTableViewCell dequeueReusableCellFromTableView:tableView
                                                                                             forIndexPath:indexPath];

    NSDate *rowFirstDayInWeek = _firstDayOfWeekForIndexPath[indexPath];

    NSDate *monthDateForSection = _monthDates[(NSUInteger) indexPath.section];

    weekCell.calendar = self.calendar;

    [weekCell setFirstDateOfWeek:rowFirstDayInWeek
                  withDataSource:self
                currentMonthDate:monthDateForSection
                   departureDate:self.departureDate
                      returnDate:self.returnDate];

    weekCell.delegate = self;

    return weekCell;
}

- (NSDate *)getFirstDayInMonthWeekForSection:(NSInteger)section {
    NSDate *sectionMonth = _monthDates[(NSUInteger) section];

    return [sectionMonth firstDateForComponents:NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth inCalendar:self.calendar];
}

- (TUCalendarDayViewState *)calendarDayViewSettingsForDate:(NSDate *)date {
    TUCalendarDayViewState *settings = _calculatedSettings[date];

    if (!settings) {
        settings = [self calculateSettingsForDate:date];
        _calculatedSettings[date] = settings;
    }

    return settings;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TUCalendarWeekTableViewCell viewHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [TUCalendarMonthSectionView appearance].monthSectionAppearance.sectionHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _preloadedMonthSectionViews[(NSUInteger) section];
}

#pragma mark - Actions

- (IBAction)cancelButtonClicked:(UIButton *)sender {
    [self.calendarDelegate calendarViewControllerCancelDateSelection:self];
}

#pragma mark - TUCalendarWeekTableViewCellDelegate

- (void)calendarWeekTableViewCellSelectDate:(NSDate *)date {
    [self.calendarDelegate calendarViewController:self didSelectDate:date];
}

@end
