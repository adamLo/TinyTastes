//
//  AddMealNotificationViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 10/8/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMealNotificationViewController : UIViewController {
    IBOutlet UILabel *cancelLabel;
    IBOutlet UILabel *saveLabel;
    IBOutlet UILabel *mealLabel;
    IBOutlet UILabel *remindMeAtLabel;
    IBOutlet UILabel *editReminderLabel;
    
    IBOutlet UIButton *cancelButton;
    IBOutlet UIButton *saveButton;    
}

- (IBAction)save:(id)sender;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property(nonatomic) NSString *currentMeal;
@property(nonatomic) NSDate *currentNotificationTime;

@end
