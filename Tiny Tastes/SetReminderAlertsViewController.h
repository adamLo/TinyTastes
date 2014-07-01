//
//  SetReminderAlertsViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 11/2/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetReminderAlertsViewController : UIViewController {
    
}

@property (nonatomic, weak) IBOutlet UILabel *setRemindersHeadingLabel;

@property (nonatomic, weak) IBOutlet UILabel *breakfastLabel;
@property (nonatomic, weak) IBOutlet UILabel *morningSnackLabel;
@property (nonatomic, weak) IBOutlet UILabel *lunchLabel;
@property (nonatomic, weak) IBOutlet UILabel *afternoonSnackLabel;
@property (nonatomic, weak) IBOutlet UILabel *dinnerLabel;
@property (nonatomic, weak) IBOutlet UILabel *eveningSnackLabel;

@property (nonatomic, weak) IBOutlet UILabel *breakfastTime;
@property (nonatomic, weak) IBOutlet UILabel *morningSnackTime;
@property (nonatomic, weak) IBOutlet UILabel *lunchTime;
@property (nonatomic, weak) IBOutlet UILabel *afternoonSnackTime;
@property (nonatomic, weak) IBOutlet UILabel *dinnerTime;
@property (nonatomic, weak) IBOutlet UILabel *eveningSnackTime;

@property (nonatomic, weak) IBOutlet UIButton *breakfastEdit;
@property (nonatomic, weak) IBOutlet UIButton *morningSnackEdit;
@property (nonatomic, weak) IBOutlet UIButton *lunchEdit;
@property (nonatomic, weak) IBOutlet UIButton *afternoonSnackEdit;
@property (nonatomic, weak) IBOutlet UIButton *dinnerEdit;
@property (nonatomic, weak) IBOutlet UIButton *eveningSnackEdit;

@property (nonatomic, weak) IBOutlet UISwitch *breakfastSwitch;
@property (nonatomic, weak) IBOutlet UISwitch *morningSnackSwitch;
@property (nonatomic, weak) IBOutlet UISwitch *lunchSwitch;
@property (nonatomic, weak) IBOutlet UISwitch *afternoonSnackSwitch;
@property (nonatomic, weak) IBOutlet UISwitch *dinnerSwitch;
@property (nonatomic, weak) IBOutlet UISwitch *eveningSnackSwitch;

- (void)scheduleDefaultNotifications;
- (void)scheduleDailyNotification:(NSString *)mealName setHour:(int)hour setMinute:(int)minute;
- (void)cancelDailyNotification:(NSString *)mealName;
- (NSDate *)getNotificationFireDate:(NSString *)mealName;
- (IBAction)toggleBreakfastAlert:(id)sender;
- (IBAction)toggleMorningSnackAlert:(id)sender;
- (IBAction)toggleLunchAlert:(id)sender;
- (IBAction)toggleAfternoonSnackAlert:(id)sender;
- (IBAction)toggleDinnerAlert:(id)sender;
- (IBAction)toggleEveningSnackAlert:(id)sender;

- (IBAction)backPressed:(id)sender; /** User pressed back button to go back to previous screen */

@end
