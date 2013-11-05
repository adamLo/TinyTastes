//
//  ChooseDrinkViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 10/23/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseDrinkViewController : UIViewController {
    IBOutlet UILabel *chooseDrinkLabel;
    IBOutlet UILabel *customizeTimerLabel;
    IBOutlet UILabel *backLabel;
    IBOutlet UILabel *nextLabel;
    IBOutlet UILabel *timeDisplayLabel;
    
    IBOutlet UIImageView *chosenDrink;
    IBOutlet UIImage *choiceDrink1;
    IBOutlet UIImage *choiceDrink2;
    
    IBOutlet UIButton *sippyCupButton;
    IBOutlet UIButton *pediasureButton;
    IBOutlet UIButton *bottleButton;
    IBOutlet UIButton *glassButton;
    IBOutlet UIButton *juiceBoxButton;
    
    IBOutlet UIStepper *drinkStepper;
    
}

- (IBAction)drinkStepperValueChanged:(UIStepper *)sender;
- (IBAction)sippyClicked:(UIButton *)sender;
- (IBAction)pediasureClicked:(UIButton *)sender;
- (IBAction)juiceBoxClicked:(UIButton *)sender;
- (IBAction)glassClicked:(UIButton *)sender;
- (IBAction)bottleClicked:(UIButton *)sender;

@end
