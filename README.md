# TUCalendar
Customizeable Gregorian calendar with monday as first day of week

## How to use:

Required:

1. Create UIViewController in storyboard or xib
2. Add UITableView inside this controller
3. Create outlet connection to `tableView`
4. Implement `TUCalendarViewControllerDelegate` in custom class and assign instance of that class to property `calendarDelegate` of `TUCalendarViewController`

Optionally:

1. Create label inside controller
2. Create outlet connection to `navbarTitleLabel`
3. Add localization for `common_calendar_departure_title` and `common_calendar_arrival_title` strings

## How to customize:

Customization can be done via two classes:
* [TUCalendarDayViewAppearance](https://github.com/petropavel13/TUCalendar/blob/master/TUCalendar/TUCalendar/Views/TUCalendarDayView.h#L43)
* [TUCalendarMonthSectionViewAppearance](https://github.com/petropavel13/TUCalendar/blob/master/TUCalendar/TUCalendar/Views/SectionsViews/TUCalendarMonthSectionView.h#L11)

Each class contains properties that can be modified:

### TUCalendarDayViewAppearance customization properties:
```objc
@property (nonatomic, nonnull) UIColor *highlightedBackgroundColor;
@property (nonatomic, nonnull) UIColor *selectedBackgroundColor;

@property (nonatomic, nonnull) UIImage *highlightedBackgroundImage;
@property (nonatomic, nonnull) UIImage *selectedBackgroundImage;

@property (nonatomic, nonnull) UIFont *titleFont;
@property (nonatomic, nonnull) UIColor *titleColor;
@property (nonatomic, nonnull) UIColor *hightlightedTitleColor;
@property (nonatomic, nonnull) UIColor *disabledTitleColor;

@property (nonatomic, nonnull) UIFont *todayTitleFont;
@property (nonatomic, nonnull) UIColor *todayTitleColor;
@property (nonatomic, nonnull) NSString *todayText;

@property (nonatomic, nonnull) UIColor *backgroundColor;
```

### TUCalendarMonthSectionViewAppearance customization properties:
```objc
@property (nonatomic, nonnull) UIFont *titleFont;
@property (nonatomic, nonnull) UIColor *titleColor;

@property (nonatomic, nonnull) UIFont *dayFont;

@property (nonatomic, nonnull) UIColor *weekdayColor;
@property (nonatomic, nonnull) UIColor *weekendColor;

@property (nonatomic, nonnull) UIColor *dividerColor;

@property (nonatomic, nonnull) UIColor *backgroundColor;
```

Instances of appearance classes contains default values:
* [TUCalendarDayViewAppearance default values](https://github.com/petropavel13/TUCalendar/blob/master/TUCalendar/TUCalendar/Views/TUCalendarDayView.m#L41)
* [TUCalendarMonthSectionViewAppearance default values](https://github.com/petropavel13/TUCalendar/blob/master/TUCalendar/TUCalendar/Views/SectionsViews/TUCalendarMonthSectionView.m#L28)

So, you can use their with the following way:

```objc
TUCalendarDayViewAppearance *dayViewAppearance = [TUCalendarDayViewAppearance new];
dayViewAppearance.titleFont = [TUFont firaSansRegularOfSize:18.f];
dayViewAppearance.todayTitleFont = [TUFont firaSansLightOfSize:10.f];

[TUCalendarDayView appearance].dayViewAppearance = dayViewAppearance;

TUCalendarMonthSectionViewAppearance *monthSectionViewAppearance = [TUCalendarMonthSectionViewAppearance new];
monthSectionViewAppearance.titleFont = [TUFont firaSansRegularOfSize:15.f];
monthSectionViewAppearance.dayFont = [TUFont firaSansRegularOfSize:11.f];

[TUCalendarMonthSectionView appearance].monthSectionAppearance = monthSectionViewAppearance;
```
