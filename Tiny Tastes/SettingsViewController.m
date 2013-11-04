//
//  SettingsViewController.m
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController



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
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0f green:256/255.0f blue:179/255.0f alpha:1.0f];
    
    // Set customized font for labels
    settingsLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:70];
    soundLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    mealTimer.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    mealAlerts.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    backLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:35];
    setTimerButton.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    setAlertsButton.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    


}

- (IBAction)soundButtonClicked:(UIButton *)sender
{
    if (soundSwitch.on) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"sound"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"sound"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
