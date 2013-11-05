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
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0f green:256/255.0f blue:179/255.0f alpha:1.0f];
    
    chooseDrinkLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:60];
    chooseDrinkLabel.numberOfLines = 0;
    customizeTimerLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    backLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:35];
    nextLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:35];
    timeDisplayLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    
    drinkStepper.minimumValue = 5;
    drinkStepper.maximumValue = 60;
    drinkStepper.wraps = YES;
    drinkStepper.autorepeat = YES;
    drinkStepper.continuous = YES;
    drinkStepper.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"drinkTimer"];
    timeDisplayLabel.text = [NSString stringWithFormat:@"%.f minutes", drinkStepper.value];
    
    //by default, set chosen drink to the sippy cup
    [chosenDrink setImage:[UIImage imageNamed:@"sippy.png"]];
    choiceDrink1 = [UIImage imageNamed:@"drinking_sippy_1.png"];
    choiceDrink2 = [UIImage imageNamed:@"drinking_sippy_2.png"];
}

- (IBAction)drinkStepperValueChanged:(id)sender
{
    double stepperValue = drinkStepper.value;
    timeDisplayLabel.text = [NSString stringWithFormat:@"%.f minutes", stepperValue];
    
    // Change drink timer value in user defaults
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:stepperValue forKey:@"drinkTimer"];
}

- (IBAction)sippyClicked:(UIButton *)sender
{
    [chosenDrink setImage:[UIImage imageNamed:@"sippy.png"]];
    choiceDrink1 = [UIImage imageNamed:@"drinking_sippy_1.png"];
    choiceDrink2 = [UIImage imageNamed:@"drinking_sippy_2.png"];
}

- (IBAction)pediasureClicked:(UIButton *)sender
{
    [chosenDrink setImage:[UIImage imageNamed:@"pediasure.png"]];
    choiceDrink1 = [UIImage imageNamed:@"drinking_pediasure_1.png"];
    choiceDrink2 = [UIImage imageNamed:@"drinking_pediasure_2.png"];
}

- (IBAction)juiceBoxClicked:(UIButton *)sender
{
    [chosenDrink setImage:[UIImage imageNamed:@"juicebox.png"]];
    choiceDrink1 = [UIImage imageNamed:@"drinking_juice_1.png"];
    choiceDrink2 = [UIImage imageNamed:@"drinking_juice_2.png"];
}

- (IBAction)glassClicked:(UIButton *)sender
{
    [chosenDrink setImage:[UIImage imageNamed:@"glass.png"]];
    choiceDrink1 = [UIImage imageNamed:@"drinking_glass_1.png"];
    choiceDrink2 = [UIImage imageNamed:@"drinking_glass_2.png"];
}

- (IBAction)bottleClicked:(UIButton *)sender
{
    [chosenDrink setImage:[UIImage imageNamed:@"bottle.png"]];
    choiceDrink1 = [UIImage imageNamed:@"drinking_bottle_1.png"];
    choiceDrink2 = [UIImage imageNamed:@"drinking_bottle_2.png"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"choseDrinkSegue"]){
        DrinkViewController *controller = (DrinkViewController *)segue.destinationViewController;
        controller.drinkingImage1 = choiceDrink1;
        controller.drinkingImage2 = choiceDrink2;
    }
}

@end