//
//  ChooseDrinkViewController.m
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 10/23/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "ChooseDrinkViewController.h"
#import "DrinkViewController.h"

@interface ChooseDrinkViewController ()

@end

@implementation ChooseDrinkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.83 alpha:1.0];
    
    chooseDrinkLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:60];
    chooseDrinkLabel.numberOfLines = 0;
    customizeTimerLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:60];
    backLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:35];
    [backLabel setTextColor:[UIColor whiteColor]];
    nextLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:35];
    [nextLabel setTextColor:[UIColor whiteColor]];
    timeDisplayLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    
    drinkStepper.minimumValue = 5;
    drinkStepper.maximumValue = 60;
    drinkStepper.wraps = YES;
    drinkStepper.autorepeat = YES;
    drinkStepper.continuous = YES;
    drinkStepper.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"drinkTimer"];
    timeDisplayLabel.text = [NSString stringWithFormat:@"%.f minutes", drinkStepper.value];
    
    //by default, set chosen drink to the sippy cup
    choiceDrink1 = [UIImage imageNamed:@"drinking_sippy_1.jpg"];
    choiceDrink2 = [UIImage imageNamed:@"drinking_sippy_2.jpg"];
}

- (IBAction)drinkStepperValueChanged:(id)sender
{
    double stepperValue = drinkStepper.value;
    timeDisplayLabel.text = [NSString stringWithFormat:@"%.f minutes", stepperValue];
}

- (IBAction)sippyClicked:(UIButton *)sender
{
    choiceDrink1 = [UIImage imageNamed:@"drinking_sippy_1.jpg"];
    choiceDrink2 = [UIImage imageNamed:@"drinking_sippy_2.jpg"];
}

- (IBAction)pediasureClicked:(UIButton *)sender
{
    choiceDrink1 = [UIImage imageNamed:@"drinking_pediasure_1.jpg"];
    choiceDrink2 = [UIImage imageNamed:@"drinking_pediasure_2.jpg"];
}

- (IBAction)juiceBoxClicked:(UIButton *)sender
{
    choiceDrink1 = [UIImage imageNamed:@"drinking_juice_1.jpg"];
    choiceDrink2 = [UIImage imageNamed:@"drinking_juice_2.jpg"];
}

- (IBAction)glassClicked:(UIButton *)sender
{
    choiceDrink1 = [UIImage imageNamed:@"drinking_glass_1.jpg"];
    choiceDrink2 = [UIImage imageNamed:@"drinking_glass_2.jpg"];
}

- (IBAction)bottleClicked:(UIButton *)sender
{
    choiceDrink1 = [UIImage imageNamed:@"drinking_bottle_1.jpg"];
    choiceDrink2 = [UIImage imageNamed:@"drinking_bottle_2.jpg"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"choseDrinkSegue"]){
        DrinkViewController *controller = (DrinkViewController *)segue.destinationViewController;
        controller.timeToDrink = drinkStepper.value;
        controller.drinkingImage1 = choiceDrink1;
        controller.drinkingImage2 = choiceDrink2;
    }
}

@end