//
//  CustomTimerViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 11/1/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTimerViewController : UIViewController {
    IBOutlet UILabel *customizeTimerLabel;
    IBOutlet UILabel *mealTimerLabel;
    IBOutlet UILabel *snackTimerLabel;
    IBOutlet UILabel *drinkTimerLabel;
    IBOutlet UILabel *mealTimerText;
    IBOutlet UILabel *snackTimerText;
    IBOutlet UILabel *drinkTimerText;
    IBOutlet UILabel *minutesText1;
    IBOutlet UILabel *minutesText2;
    IBOutlet UILabel *minutesText3;
    
    IBOutlet UIStepper *mealStepper;
    IBOutlet UIStepper *snackStepper;
    IBOutlet UIStepper *drinkStepper;
}

- (IBAction)mealStepperValueChanged:(id)sender;
- (IBAction)snackStepperValueChanged:(id)sender;
- (IBAction)drinkStepperValueChanged:(id)sender;

@end
