//
//  SettingsViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController {
    IBOutlet UILabel *settingsLabel;
    IBOutlet UILabel *backgroundSoundLabel;
    IBOutlet UILabel *storyNarrationLabel;
    IBOutlet UILabel *mealTimer;
    IBOutlet UILabel *mealAlerts;
    
    IBOutlet UISwitch *backgroundSoundSwitch;
    IBOutlet UISwitch *storyNarrationSwitch;
    
    IBOutlet UIButton *setTimerButton;
    IBOutlet UIButton *setAlertsButton;
}

- (IBAction)backgroundSoundButtonClicked:(UIButton *)sender;
- (IBAction)storyNarrationButtonClicked:(UIButton *)sender;

- (IBAction)homePressed:(id)sender; /** User pressed home button to go back to home screen */

@end
