//
//  SettingsViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController {
}

@property (nonatomic, weak) IBOutlet UILabel *settingsLabel;
@property (nonatomic, weak) IBOutlet IBOutlet UILabel *backgroundSoundLabel;
@property (nonatomic, weak) IBOutlet IBOutlet UILabel *storyNarrationLabel;
@property (nonatomic, weak) IBOutlet IBOutlet UILabel *mealTimer;
@property (nonatomic, weak) IBOutlet IBOutlet UILabel *mealAlerts;

@property (nonatomic, weak) IBOutlet IBOutlet UISwitch *backgroundSoundSwitch;
@property (nonatomic, weak) IBOutlet IBOutlet UISwitch *storyNarrationSwitch;

@property (nonatomic, weak) IBOutlet IBOutlet UIButton *setTimerButton;
@property (nonatomic, weak) IBOutlet IBOutlet UIButton *setAlertsButton;

- (IBAction)backgroundSoundButtonClicked:(UIButton *)sender;
- (IBAction)storyNarrationButtonClicked:(UIButton *)sender;

- (IBAction)homePressed:(id)sender; /** User pressed home button to go back to home screen */

@end
