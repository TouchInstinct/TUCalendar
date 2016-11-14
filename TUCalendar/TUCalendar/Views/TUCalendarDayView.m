//
//  TUCalendarDayView.m
//  tutu
//
//  Created by Иван Смолин on 20/10/15.
//  Copyright © 2015 Touch Instinct. All rights reserved.
//

#import <UIColor_Hex/UIColor+Hex.h>
#import "TUCalendarDayView.h"
#import "TUFont.h"

static UIImage *backgroundBlueImage = nil;
static UIImage *backgroundBlueLightImage = nil;

static CGFloat const kBackgroundImageViewHeight = 36.f;
static CGFloat const kDayButtonTodayLabelVerticalSpace = - 6.f;
static CGFloat const kTodayLabelHeight = 12.f;


@implementation TUCalendarDayViewSettings

- (id)copyWithZone:(NSZone *)zone {
    TUCalendarDayViewSettings *copyOfMe = [TUCalendarDayViewSettings new];
    copyOfMe.dateInMonth = self.dateInMonth;
    copyOfMe.selectionOptions = self.selectionOptions;
    copyOfMe.isInvisibleDay = self.isInvisibleDay;
    copyOfMe.isOldDay = self.isOldDay;
    copyOfMe.isToday = self.isToday;

    return copyOfMe;
}

@end


@interface TUCalendarDayView ()

@property (weak, nonatomic) UIButton *dayButton;
@property (weak, nonatomic) UIImageView *backgroundImageView;

@property (weak, nonatomic) UILabel *todayLabel;

@property (weak, nonatomic) UIView *leftBackgroundView;
@property (weak, nonatomic) UIView *rightBackgroundView;

@end

@implementation TUCalendarDayView

+ (void)initialize {
    backgroundBlueImage = [UIImage imageNamed:@"cal_blue"];
    backgroundBlueLightImage = [UIImage imageNamed:@"cal_blue_light"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupViews];
        
        [self.dayButton addTarget:self action:@selector(dayButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self.dayButton addTarget:self action:@selector(updateBackgroundState) forControlEvents:UIControlEventAllEvents];
    }
    
    return self;
}

- (void)setupViews {
    UIColor *selectedBgColor = [UIColor colorWithHex:0xE5F4FF];
    
    UIView *leftBackgroundView = [UIView new];
    leftBackgroundView.backgroundColor = selectedBgColor;
    [self addSubview:leftBackgroundView];
    self.leftBackgroundView = leftBackgroundView;
    
    UIView *rightBackgroundView = [UIView new];
    rightBackgroundView.backgroundColor = selectedBgColor;
    [self addSubview:rightBackgroundView];
    self.rightBackgroundView = rightBackgroundView;
    
    UIImageView *backgroundImageView = [UIImageView new];
    [self addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;
    
    UIButton *dayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dayButton.titleLabel.font = [TUFont firaSansRegularOfSize:18];
    [dayButton setTitleColor:[UIColor colorWithHex:0x6D7F8D] forState:UIControlStateNormal];
    [dayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [dayButton setTitleColor:[UIColor colorWithHex:0xD1DAE1] forState:UIControlStateDisabled];
    [self addSubview:dayButton];
    self.dayButton = dayButton;
    
    UILabel *todayLabel = [UILabel new];
    todayLabel.font = [TUFont firaSansLightOfSize:10];
    todayLabel.textColor = [UIColor colorWithHex:0x91A7B8];
    todayLabel.textAlignment = NSTextAlignmentCenter;
    todayLabel.text = NSLocalizedString(@"common_calendar_word_today",  @"cегодня");
    [self addSubview:todayLabel];
    self.todayLabel = todayLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect leftBackgroundViewFrame = self.bounds;
    leftBackgroundViewFrame.size.width /= 2.f;
    self.leftBackgroundView.frame = leftBackgroundViewFrame;
    
    CGRect rightBackgroundViewFrame = leftBackgroundViewFrame;
    rightBackgroundViewFrame.origin.x += rightBackgroundViewFrame.size.width;
    self.rightBackgroundView.frame = rightBackgroundViewFrame;
    
    self.backgroundImageView.frame = CGRectMake(0.f, 0.f, kBackgroundImageViewHeight, kBackgroundImageViewHeight);
    self.backgroundImageView.center = CGPointMake(self.frame.size.width/2.f, self.frame.size.height/2.f);
    
    self.dayButton.frame = self.bounds;
    
    CGRect todayLabelFrame = CGRectMake(0.f,  CGRectGetMaxY(self.dayButton.frame) + kDayButtonTodayLabelVerticalSpace, self.frame.size.width, kTodayLabelHeight);
    self.todayLabel.frame = todayLabelFrame;
}

- (void)dayButtonTouchUpInside:(UIButton *)sender {
    [self.delegate calendarDayView:self didSelectDate:self.date];
}

- (void)setSettings:(nonnull TUCalendarDayViewSettings *)settings {
    self.dayButton.selected = NO;
    self.dayButton.highlighted = NO;
    self.dayButton.enabled = NO;

    if (settings.isInvisibleDay) {
        [self.dayButton setTitle:@"" forState:UIControlStateDisabled];
    } else if (settings.isOldDay) {
        [self.dayButton setTitle:settings.dateInMonth forState:UIControlStateDisabled];
    } else {
        [self.dayButton setTitle:settings.dateInMonth forState:UIControlStateNormal];
        [self.dayButton setTitle:settings.dateInMonth forState:UIControlStateSelected];
        [self.dayButton setTitle:settings.dateInMonth forState:UIControlStateHighlighted];

        self.dayButton.enabled = YES;
    }

    self.todayLabel.hidden = !settings.isToday || settings.isInvisibleDay;

    if (!settings.isOldDay) {
        BOOL overlapsTodayLabel = settings.selectionOptions & TUCalendarDayViewSelectionDate
                || settings.selectionOptions & TUCalendarDayViewSelectionDateStrong;

        self.todayLabel.hidden = self.todayLabel.hidden || overlapsTodayLabel;


        if (settings.selectionOptions == TUCalendarDayViewSelectionNone) {
            self.dayButton.selected = NO;
            self.dayButton.highlighted = NO;
        } else if (!settings.isInvisibleDay) {
            if (settings.selectionOptions & TUCalendarDayViewSelectionDateStrong) {
                self.dayButton.highlighted = YES;
            } else if (settings.selectionOptions & TUCalendarDayViewSelectionDate) {
                self.dayButton.selected = YES;
            }
        }
    }

    [self updateBackgroundState];

    self.leftBackgroundView.hidden = !(settings.selectionOptions & TUCalendarDayViewSelectionLeftFull);
    self.rightBackgroundView.hidden = !(settings.selectionOptions & TUCalendarDayViewSelectionRightFull);
}

- (void)updateBackgroundState {
    UIControlState buttonState = self.dayButton.state;

    if (buttonState == UIControlStateHighlighted) {
        self.backgroundImageView.image = backgroundBlueImage;
    } else if (buttonState == UIControlStateSelected) {
        self.backgroundImageView.image = backgroundBlueLightImage;
    } else {
        self.backgroundImageView.image = nil;
    }
}

@end
