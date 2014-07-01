//
//  CustomTimerViewController.m
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 11/1/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "CustomTimerViewController.h"
#import "UIFont+TinyTastes.h"

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

	self.customizeTimerLabel.font = [UIFont ttFont70];
    self.mealTimerLabel.font = [UIFont ttFont60];
    self.snackTimerLabel.font = [UIFont ttFont60];
    self.drinkTimerLabel.font = [UIFont ttFont60];
    self.mealTimerText.font = [UIFont ttFont50];
    self.snackTimerText.font = [UIFont ttFont50];
    self.drinkTimerText.font = [UIFont ttFont50];
    self.minutesText1.font = [UIFont ttFont50];
    self.minutesText2.font = [UIFont ttFont50];
    self.minutesText3.font = [UIFont ttFont50];

    self.mealStepper.minimumValue = 1;
    self.snackStepper.minimumValue = 1;
    self.drinkStepper.minimumValue = 1;
    
    self.mealStepper.maximumValue = 60;
    self.snackStepper.maximumValue = 60;
    self.drinkStepper.maximumValue = 60;
    
    self.mealStepper.wraps = YES;
    self.snackStepper.wraps = YES;
    self.drinkStepper.wraps = YES;
    self.mealStepper.autorepeat = YES;
    self.snackStepper.autorepeat = YES;
    self.drinkStepper.autorepeat = YES;
    self.mealStepper.continuous = YES;
    self.snackStepper.continuous = YES;
    self.drinkStepper.continuous = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if(![[[prefs dictionaryRepresentation] allKeys] containsObject:@"mealTimer"]) {
        
        // Initialize user's coins to 0
        [prefs setInteger:30 forKey:@"mealTimer"];
        [prefs setInteger:15 forKey:@"snackTimer"];
        [prefs setInteger:10 forKey:@"drinkTimer"];
        self.mealStepper.value = 30;
        self.snackStepper.value = 15;
        self.drinkStepper.value = 10;
    } else {
        NSInteger myMealTimer = [prefs integerForKey:@"mealTimer"];
        self.mealStepper.value = myMealTimer;
        NSInteger mySnackTimer = [prefs integerForKey:@"snackTimer"];
        self.snackStepper.value = mySnackTimer;
        NSInteger myDrinkTimer = [prefs integerForKey:@"drinkTimer"];
        self.drinkStepper.value = myDrinkTimer;
    }
    
    self.mealTimerText.text = [NSString stringWithFormat:@"%.f", self.mealStepper.value];
    self.snackTimerText.text = [NSString stringWithFormat:@"%.f", self.snackStepper.value];
    self.drinkTimerText.text = [NSString stringWithFormat:@"%.f", self.drinkStepper.value];
    
}

- (IBAction)mealStepperValueChanged:(id)sender
{
    double stepperValue = self.mealStepper.value;
    self.mealTimerText.text = [NSString stringWithFormat:@"%.f", stepperValue];
    
    // Change meal timer value in user defaults
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:stepperValue forKey:@"mealTimer"];
}

- (IBAction)snackStepperValueChanged:(id)sender
{
    double stepperValue = self.snackStepper.value;
    self.snackTimerText.text = [NSString stringWithFormat:@"%.f", stepperValue];
    
    // Change snack timer value in user defaults
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:stepperValue forKey:@"snackTimer"];
}

- (IBAction)drinkStepperValueChanged:(id)sender
{
    double stepperValue = self.drinkStepper.value;
    self.drinkTimerText.text = [NSString stringWithFormat:@"%.f", stepperValue];
    
    // Change drink timer value in user defaults
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:stepperValue forKey:@"drinkTimer"];
}

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
