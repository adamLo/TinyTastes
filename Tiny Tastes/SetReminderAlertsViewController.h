//
//  SetReminderAlertsViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 11/2/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetReminderAlertsViewController : UIViewController {
    IBOutlet UILabel *setRemindersHeadingLabel;
    
    IBOutlet UILabel *breakfastLabel;
    IBOutlet UILabel *morningSnackLabel;
    IBOutlet UILabel *lunchLabel;
    IBOutlet UILabel *afternoonSnackLabel;
    IBOutlet UILabel *dinnerLabel;
    IBOutlet UILabel *eveningSnackLabel;
    
    IBOutlet UILabel *breakfastTime;
    IBOutlet UILabel *morningSnackTime;
    IBOutlet UILabel *lunchTime;
    IBOutlet UILabel *afternoonSnackTime;
    IBOutlet UILabel *dinnerTime;
    IBOutlet UILabel *eveningSnackTime;
    
    IBOutlet UIButton *breakfastEdit;
    IBOutlet UIButton *morningSnackEdit;
    IBOutlet UIButton *lunchEdit;
    IBOutlet UIButton *afternoonSnackEdit;
    IBOutlet UIButton *dinnerEdit;
    IBOutlet UIButton *eveningSnackEdit;
    
    IBOutlet UISwitch *breakfastSwitch;
    IBOutlet UISwitch *morningSnackSwitch;
    IBOutlet UISwitch *lunchSwitch;
    IBOutlet UISwitch *afternoonSnackSwitch;
    IBOutlet UISwitch *dinnerSwitch;
    IBOutlet UISwitch *eveningSnackSwitch;
}

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

@end
