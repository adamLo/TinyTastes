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
    IBOutlet UILabel *soundLabel;
    IBOutlet UILabel *mealTimer;
    IBOutlet UILabel *mealAlerts;
    IBOutlet UILabel *backLabel;
    
    IBOutlet UISwitch *soundSwitch;
    
    IBOutlet UIButton *setTimerButton;
    IBOutlet UIButton *setAlertsButton;
}

- (IBAction)soundButtonClicked:(UIButton *)sender;

@end
