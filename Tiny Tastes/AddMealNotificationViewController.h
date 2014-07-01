//
//  AddMealNotificationViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 10/8/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMealNotificationViewController : UIViewController {
}

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *mealLabel;
@property (weak, nonatomic) IBOutlet UILabel *remindMeAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *editReminderLabel;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property(nonatomic, weak) NSString *currentMeal;
@property(nonatomic, weak) NSDate *currentNotificationTime;

- (IBAction)backPressed:(id)sender; /** User pressed back button to go back to previous screen */
- (IBAction)save:(id)sender; /** User pressed save button to persist changes and go back */

@end
