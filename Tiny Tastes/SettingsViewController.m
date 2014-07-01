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
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.83 alpha:1.0];
    
    // Set customized font for labels
    self.settingsLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:70];
    self.backgroundSoundLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.storyNarrationLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.mealTimer.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.mealAlerts.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.setTimerButton.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.setAlertsButton.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    
}

- (void)viewWillAppear:(BOOL)animated {
    // Set background sound button state
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"backgroundSound"] == YES) {
        [self.backgroundSoundSwitch setOn:YES animated:YES];
    } else {
        [self.backgroundSoundLabel setTextColor:[UIColor grayColor]];
        [self.backgroundSoundSwitch setOn:NO animated:YES];
    }
    
    // Set story narration sound button state
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"storyNarration"] == YES) {
        [self.storyNarrationSwitch setOn:YES animated:YES];
    } else {
        [self.storyNarrationLabel setTextColor:[UIColor grayColor]];
        [self.storyNarrationSwitch setOn:NO animated:YES];
    }
}


- (IBAction)backgroundSoundButtonClicked:(UIButton *)sender
{
    if (self.backgroundSoundSwitch.on) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"backgroundSound"];
        [self.backgroundSoundLabel setTextColor:[UIColor blackColor]];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"backgroundSound"];
        [self.backgroundSoundLabel setTextColor:[UIColor grayColor]];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)storyNarrationButtonClicked:(UIButton *)sender
{
    if (self.storyNarrationSwitch.on) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"storyNarration"];
        [self.storyNarrationLabel setTextColor:[UIColor blackColor]];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"storyNarration"];
        [self.storyNarrationLabel setTextColor:[UIColor grayColor]];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)homePressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
