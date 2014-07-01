//
//  ChooseDrinkViewController.m
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 10/23/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "ChooseDrinkViewController.h"
#import "DrinkViewController.h"
#import "UIFont+TinyTastes.h"

@interface ChooseDrinkViewController () {
    TTDrinkType chosenDrink; //Chosen drink type
    NSArray *selectionAnimation; //Array of selection animation images
}

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

- (void)awakeFromNib {
    //by default, set chosen drink to the Pediasure
    chosenDrink = TTDrinkPediasure;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.83 alpha:1.0];
    
    self.chooseDrinkLabel.font = [UIFont ttFont60];
    self.chooseDrinkLabel.numberOfLines = 0;
    self.customizeTimerLabel.font = [UIFont ttFont60];
    self.timeDisplayLabel.font = [UIFont ttFont50];
    
    self.drinkStepper.minimumValue = 1;
    self.drinkStepper.maximumValue = 60;
    self.drinkStepper.wraps = YES;
    self.drinkStepper.autorepeat = YES;
    self.drinkStepper.continuous = YES;
    
    //Seelction animation (glowing blue circle) around selected drink
    selectionAnimation = @[[UIImage imageNamed:@"drink_selection_01.png"], [UIImage imageNamed:@"drink_selection_02.png"]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    //Set stepper
    self.drinkStepper.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"drinkTimer"];
    self.timeDisplayLabel.text = [NSString stringWithFormat:@"%.f minutes", self.drinkStepper.value];
    
    //Display animation
    [self selectDrinkWithType:chosenDrink];
}

- (void)viewDidDisappear:(BOOL)animated {
    //Stop animation
    for (UIImageView *background in self.selectionBackgrounds) {
        [background stopAnimating];
    }
}

- (IBAction)drinkStepperValueChanged:(id)sender {
    double stepperValue = self.drinkStepper.value;
    self.timeDisplayLabel.text = [NSString stringWithFormat:@"%.f minutes", stepperValue];
}

- (IBAction)homePressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"choseDrinkSegue"]){
        DrinkViewController *controller = (DrinkViewController *)segue.destinationViewController;
        //Pass selection and timer to drink controller
        controller.timeToDrink = self.drinkStepper.value;
        controller.selectedDrinkType = chosenDrink;
    }
}

- (void)selectDrinkWithType:(NSInteger)drinkType {
    
    //Clear current selection
    for (UIImageView *background in self.selectionBackgrounds) {
        [background stopAnimating];
        background.animationImages = nil;
    }
    
    //Make new selection
    UIImageView* selection = [self.selectionBackgrounds objectAtIndex:drinkType];
    selection.animationImages = selectionAnimation;
    selection.animationDuration = 1.0;
    [selection startAnimating];
    
    //Store selection
    chosenDrink = drinkType;
}

- (IBAction)drinkSelected:(UIButton *)sender {
    [self selectDrinkWithType:sender.tag];
}

@end