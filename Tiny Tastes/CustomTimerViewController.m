//
//  CustomTimerViewController.m
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 11/1/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "CustomTimerViewController.h"

@interface CustomTimerViewController ()

@end

@implementation CustomTimerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.83 alpha:1.0];

	customizeTimerLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:70];
    mealTimerLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:60];
    snackTimerLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:60];
    drinkTimerLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:60];
    mealTimerText.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    snackTimerText.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    drinkTimerText.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    minutesText1.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    minutesText2.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    minutesText3.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];

    mealStepper.minimumValue = 5;
    snackStepper.minimumValue = 5;
    drinkStepper.minimumValue = 5;
    
    mealStepper.maximumValue = 60;
    snackStepper.maximumValue = 60;
    drinkStepper.maximumValue = 60;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if(![[[prefs dictionaryRepresentation] allKeys] containsObject:@"mealTimer"]) {
        
        // Initialize user's coins to 0
        [prefs setInteger:30 forKey:@"mealTimer"];
        [prefs setInteger:15 forKey:@"snackTimer"];
        [prefs setInteger:10 forKey:@"drinkTimer"];
        mealStepper.value = 30;
        snackStepper.value = 15;
        drinkStepper.value = 10;
    } else {
        NSInteger myMealTimer = [prefs integerForKey:@"mealTimer"];
        mealStepper.value = myMealTimer;
        NSInteger mySnackTimer = [prefs integerForKey:@"snackTimer"];
        snackStepper.value = mySnackTimer;
        NSInteger myDrinkTimer = [prefs integerForKey:@"drinkTimer"];
        drinkStepper.value = myDrinkTimer;
    }
    
    mealStepper.wraps = YES;
    snackStepper.wraps = YES;
    drinkStepper.wraps = YES;
    mealStepper.autorepeat = YES;
    snackStepper.autorepeat = YES;
    drinkStepper.autorepeat = YES;
    mealStepper.continuous = YES;
    snackStepper.continuous = YES;
    drinkStepper.continuous = YES;
    
    mealTimerText.text = [NSString stringWithFormat:@"%.f", mealStepper.value];
    snackTimerText.text = [NSString stringWithFormat:@"%.f", snackStepper.value];
    drinkTimerText.text = [NSString stringWithFormat:@"%.f", drinkStepper.value];
}

- (IBAction)mealStepperValueChanged:(id)sender
{
    double stepperValue = mealStepper.value;
    mealTimerText.text = [NSString stringWithFormat:@"%.f", stepperValue];
    
    // Change meal timer value in user defaults
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:stepperValue forKey:@"mealTimer"];
}

- (IBAction)snackStepperValueChanged:(id)sender
{
    double stepperValue = snackStepper.value;
    snackTimerText.text = [NSString stringWithFormat:@"%.f", stepperValue];
    
    // Change snack timer value in user defaults
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:stepperValue forKey:@"snackTimer"];
}

- (IBAction)drinkStepperValueChanged:(id)sender
{
    double stepperValue = drinkStepper.value;
    drinkTimerText.text = [NSString stringWithFormat:@"%.f", stepperValue];
    
    // Change drink timer value in user defaults
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:stepperValue forKey:@"drinkTimer"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
