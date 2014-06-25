//
//  AddMealNotificationViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 10/8/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMealNotificationViewController : UIViewController {
    IBOutlet UILabel *mealLabel;
    IBOutlet UILabel *remindMeAtLabel;
    IBOutlet UILabel *editReminderLabel;
    
    IBOutlet UIButton *cancelButton;
    IBOutlet UIButton *saveButton;    
}

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property(nonatomic) NSString *currentMeal;
@property(nonatomic) NSDate *currentNotificationTime;

- (IBAction)backPressed:(id)sender; /** User pressed back button to go back to previous screen */
- (IBAction)save:(id)sender; /** User pressed save button to persist changes and go back */

@end
