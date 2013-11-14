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
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.83 alpha:1.0];
    
	self.feedbackLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:80];
    self.goShoppingLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:35];
    self.mainMenuLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:35];

    self.feedbackLabel.text = self.feedbackText;
    
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
    
    if (self.numCoins == 1) {
        UIImage *image = [UIImage imageNamed:@"coin_icon.jpg"];
        [self.coinView2 setImage:image];
    } else if (self.numCoins == 3) {
        UIImage *image = [UIImage imageNamed:@"coin_icon.jpg"];
        [self.coinView1 setImage:image];
        [self.coinView2 setImage:image];
        [self.coinView3 setImage:image];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
