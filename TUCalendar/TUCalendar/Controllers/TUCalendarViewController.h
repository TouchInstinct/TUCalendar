//
//  TUCalendarViewController.h
//  tutu
//
//  Created by Иван Смолин on 20/10/15.
//  Copyright © 2015 Touch Instinct. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TUCalendarViewController;

@protocol TUCalendarViewControllerDelegate <NSObject>

- (void)calendarViewController:(nonnull TUCalendarViewController *)calendarViewController didSelectDate:(nonnull NSDate *)date;

- (void)calendarViewControllerCancelDateSelection:(nonnull TUCalendarViewController *)calendarViewController;

@end

@interface TUCalendarViewController : UIViewController

@property (nonatomic) BOOL isDepartureSelect;

@property (nonatomic, nullable) NSDate *departureDate;
@property (nonatomic, nullable) NSDate *returnDate;

@property (nonatomic, nonnull) NSCalendar *calendar;

@property (nonatomic, nullable, weak) id<TUCalendarViewControllerDelegate> calendarDelegate;

@end
