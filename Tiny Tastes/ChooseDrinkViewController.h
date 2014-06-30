//
//  ChooseDrinkViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 10/23/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseDrinkViewController : UIViewController {
    
}

@property (nonatomic, weak) IBOutlet UILabel *chooseDrinkLabel;
@property (nonatomic, weak) IBOutlet UILabel *customizeTimerLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeDisplayLabel;
@property (nonatomic, weak) IBOutlet UIStepper *drinkStepper;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *selectionBackgrounds; /** Collection of selection backgrounds behind drink buttons to display selection animation */

- (IBAction)drinkStepperValueChanged:(UIStepper *)sender;
- (IBAction)homePressed:(id)sender; /** User pressed home button to go back to home screen */
- (IBAction)drinkSelected:(UIButton *)sender; /** User pressed a drink button to select drink type */


@end
