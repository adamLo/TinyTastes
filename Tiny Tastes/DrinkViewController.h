//
//  DrinkViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef enum {
    TTDrinkSippy = 0,
    TTDrinkJuicebox = 1,
    TTDrinkGlass = 2,
    TTDrinkPediasure = 3,
    TTDrinkBottle = 4
}  TTDrinkType; /** Drink holder types */

@interface DrinkViewController : UIViewController {
}

@property (nonatomic, weak) IBOutlet UILabel *countdownLabel;
@property (nonatomic, weak) IBOutlet UILabel *chooseLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLeftLabel;

//@property (weak, nonatomic) IBOutlet UIImage *drinkingImage1;
//@property (weak, nonatomic) IBOutlet UIImage *drinkingImage2;

@property (weak, nonatomic) IBOutlet UIImageView *drinkingCritter;
@property (weak, nonatomic) IBOutlet UIImageView *redLine;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *allFinishedButton;
@property (weak, nonatomic) IBOutlet UIButton *partiallyFinishedButton;
@property (weak, nonatomic) IBOutlet UIButton *notFinishedButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *resumeButton;

@property (nonatomic, assign) NSInteger timeToDrink; /** Time in seconds for drink countdown timer */
@property (nonatomic, assign) TTDrinkType selectedDrinkType; /** Selected drink type */

- (IBAction)homeButtonPressed:(id)sender; /** User pressed home buttoon to go back to home screen */
- (IBAction)backPressed:(id)sender; /**User pressed back button to go back to previous screen */

@end