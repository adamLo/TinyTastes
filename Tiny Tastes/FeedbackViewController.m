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

@synthesize audioPlayer;

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
    self.goShoppingLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:35];
    self.mainMenuLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:35];
    self.coinsNotifLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:80];

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
    
    NSString *path;
    if (self.numCoins == 1) {  //Tried some
        UIImage *image = [UIImage imageNamed:@"coin_icon.jpg"];
        [self.coinView2 setImage:image];
        self.coinsNotifLabel.text = @"+1";
        if (self.eating == YES) {
            path = [[NSBundle mainBundle]pathForResource:@"eating_tried_some_feedback" ofType:@"m4a"];
        } else {
            path = [[NSBundle mainBundle]pathForResource:@"drinking_tried_some_feedback" ofType:@"m4a"];
        }
    } else if (self.numCoins == 3) {  //All finished
        UIImage *image = [UIImage imageNamed:@"coin_icon.jpg"];
        [self.coinView1 setImage:image];
        [self.coinView2 setImage:image];
        [self.coinView3 setImage:image];
        self.coinsNotifLabel.text = @"+3";
        path = [[NSBundle mainBundle]pathForResource:@"all_finished_feedback" ofType:@"m4a"];
    } else {  //None this time
        if (self.eating == YES) {
            path = [[NSBundle mainBundle]pathForResource:@"eating_none_this_time_feedback" ofType:@"m4a"];
        } else {
            path = [[NSBundle mainBundle]pathForResource:@"drinking_none_this_time_feedback" ofType:@"m4a"];
        }
    }
    
    //Play feedback soundbite
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audioPlayer setVolume:0.5];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"backgroundSound"] == YES) {
        [audioPlayer play];
    }
}
    
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"backgroundSound"] == YES) {
        [audioPlayer stop];
        audioPlayer = nil;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
