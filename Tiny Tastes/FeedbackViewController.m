//
//  FeedbackViewController.m
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 10/22/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

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
    
	self.feedbackLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:80];
    self.coinsLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:65];
    self.goShoppingLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:35];
    self.mainMenuLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:35];

    self.feedbackLabel.text = self.feedbackText;
    self.coinsLabel.text = [NSString stringWithFormat:@"+%d coins", self.numCoins];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (![prefs boolForKey:@"HasLaunchedOnce"]) { //first time the app was launched
        [prefs setBool:YES forKey:@"HasLaunchedOnce"];
        [prefs synchronize];
        // Initialize user's coins to 0
        [prefs setInteger:0 forKey:@"coinsKey"];
    }
    // Add earned number of coins to user's total
    NSInteger myNumCoins = [prefs integerForKey:@"coinsKey"] + self.numCoins;
    [prefs setInteger:myNumCoins forKey:@"coinsKey"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
