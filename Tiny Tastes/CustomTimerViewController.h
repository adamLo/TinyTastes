//
//  CustomTimerViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 11/1/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTimerViewController : UIViewController {
    
}

@property (nonatomic, weak) IBOutlet UILabel *customizeTimerLabel;
@property (nonatomic, weak) IBOutlet UILabel *mealTimerLabel;
@property (nonatomic, weak) IBOutlet UILabel *snackTimerLabel;
@property (nonatomic, weak) IBOutlet UILabel *drinkTimerLabel;
@property (nonatomic, weak) IBOutlet UILabel *mealTimerText;
@property (nonatomic, weak) IBOutlet UILabel *snackTimerText;
@property (nonatomic, weak) IBOutlet UILabel *drinkTimerText;
@property (nonatomic, weak) IBOutlet UILabel *minutesText1;
@property (nonatomic, weak) IBOutlet UILabel *minutesText2;
@property (nonatomic, weak) IBOutlet UILabel *minutesText3;

@property (nonatomic, weak) IBOutlet UIStepper *mealStepper;
@property (nonatomic, weak) IBOutlet UIStepper *snackStepper;
@property (nonatomic, weak) IBOutlet UIStepper *drinkStepper;

- (IBAction)mealStepperValueChanged:(id)sender;
- (IBAction)snackStepperValueChanged:(id)sender;
- (IBAction)drinkStepperValueChanged:(id)sender;

- (IBAction)backPressed:(id)sender; /** User pressed back button to go back to previous screen */

@end
