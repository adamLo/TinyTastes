//
//  FeedbackViewController.m
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 10/22/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "FeedbackViewController.h"
#import "UIFont+TinyTastes.h"
#import "Constants.h"

@interface FeedbackViewController () {
    AVAudioPlayer *audioPlayer;
}

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
    
	self.feedbackLabel.font = [UIFont ttFont80];
    self.goShoppingLabel.titleLabel.font = [UIFont ttFont35];
    self.mainMenuLabel.titleLabel.font = [UIFont ttFont35];
    self.coinsNotifLabel.font = [UIFont ttFont80];

    self.feedbackLabel.text = self.feedbackText;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (![prefs boolForKey:@"HasLaunchedOnce"]) { //first time the app was launched
        [prefs setBool:YES forKey:@"HasLaunchedOnce"];
        // Initialize user's coins to 0
        [prefs setInteger:0 forKey:TTDefaultsKeyPurseCoins];
        [prefs synchronize];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    // Add earned number of coins to user's total
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger myNumCoins = [prefs integerForKey:TTDefaultsKeyPurseCoins] + self.numCoins;
    [prefs setInteger:myNumCoins forKey:TTDefaultsKeyPurseCoins];
    [prefs synchronize];
    
    NSString *soundPath;
    if (self.numCoins == 1) {  //Tried some
        
        //Show one coin only
        self.coinView1.hidden = YES;
        self.coinView2.hidden = NO;
        self.coinView3.hidden = YES;
        
        self.coinsNotifLabel.text = @"+1";
        
        soundPath = [[NSBundle mainBundle]pathForResource:(self.eating ? @"eating_tried_some_feedback" : @"drinking_tried_some_feedback") ofType:@"m4a"];
        
    } else if (self.numCoins == 3) {  //All finished
        
        //Show all 3 coins
        self.coinView1.hidden = NO;
        self.coinView2.hidden = NO;
        self.coinView3.hidden = NO;

        self.coinsNotifLabel.text = @"+3";
        soundPath = [[NSBundle mainBundle]pathForResource:@"all_finished_feedback" ofType:@"m4a"];
        
    } else {  //None this time
        
        //Hide all 3 coins
        self.coinView1.hidden = YES;
        self.coinView2.hidden = YES;
        self.coinView3.hidden = YES;
        
        soundPath = [[NSBundle mainBundle]pathForResource:(self.eating ? @"eating_none_this_time_feedback" : @"drinking_none_this_time_feedback") ofType:@"m4a"];
    }
    
    //Play feedback soundbite
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundPath] error:NULL];
    [audioPlayer setVolume:0.5];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"backgroundSound"] == YES) {
        [audioPlayer play];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    //Stop audio
    [audioPlayer stop];
    audioPlayer = nil;
}
    
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homePressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)shopPressed:(id)sender {
    [self performSegueWithIdentifier:@"goShopping" sender:sender];
}
@end
