//
//  DrinkViewController.m
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "DrinkViewController.h"
#import "FeedbackViewController.h"

@interface DrinkViewController ()

@end

@implementation DrinkViewController

@synthesize drinkingImage1;
@synthesize drinkingImage2;
@synthesize timeToDrink;

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
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"slurping" ofType:@"mp3"];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.83 alpha:1.0];
    allFinishedButton.hidden = YES;
    partiallyFinishedButton.hidden = YES;
    notFinishedButton.hidden = YES;
    
    chooseLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:40];
    timeLeftLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:55];
    chooseLabel.hidden = YES;
    redLine.hidden = YES;
    
    drinkingCritter.animationImages = [NSArray arrayWithObjects:drinkingImage1, drinkingImage2, nil];
    drinkingCritter.animationDuration = 10;
    [self.view addSubview:drinkingCritter];
    [drinkingCritter startAnimating];
    
    [self setTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)timerRun {
    secondsCount = secondsCount - 1;
    int minutes = secondsCount / 60;
    int seconds = secondsCount - (minutes * 60);
    
    NSString *timerOutput = [NSString stringWithFormat:@"%2d:%.2d", minutes, seconds];
    countdownLabel.text = timerOutput;
    countdownLabel.textAlignment = NSTextAlignmentCenter;
    countdownLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:68];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"sound"] == YES) {
        if (((secondsCount % 5) == 0) && ((secondsCount % 10) != 0)) {
            [audioPlayer play];
        }
    }
    
    if (secondsCount == 0) {
        [countdownTimer invalidate];
        countdownTimer = nil;
        [self doneButtonClicked];
    }
    
}
- (void)setTimer {
    secondsCount = 60 * timeToDrink;
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats: YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"allFinishedSegue"]){
        FeedbackViewController *controller = (FeedbackViewController *)segue.destinationViewController;
        controller.feedbackText = @"Great job!";
        controller.numCoins = 3;
    }
    if([segue.identifier isEqualToString:@"triedSomeSegue"]){
        FeedbackViewController *controller = (FeedbackViewController *)segue.destinationViewController;
        controller.feedbackText = @"Thanks for drinking with me!";
        controller.numCoins = 1;
    }
    if([segue.identifier isEqualToString:@"notFinishedSegue"]){
        FeedbackViewController *controller = (FeedbackViewController *)segue.destinationViewController;
        controller.feedbackText = @"Maybe we can try next time!";
        controller.numCoins = 0;
    }
}

- (void)blink{
    if(blinkStatus == FALSE){
        redLine.hidden = NO;
        blinkStatus = TRUE;
    }else {
        redLine.hidden = YES;
        blinkStatus = FALSE;
    }
}

- (IBAction)doneButtonClicked {
    [countdownTimer invalidate];
    countdownTimer = nil;
    allFinishedButton.hidden = NO;
    partiallyFinishedButton.hidden = NO;
    notFinishedButton.hidden = NO;
    chooseLabel.hidden = NO;
    redLine.hidden = NO;
    doneButton.hidden = YES;
    [drinkingCritter stopAnimating];
    [drinkingCritter setImage:drinkingImage1];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (![prefs boolForKey:@"HasLaunchedOnce"]) {
        [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)(1.0)  target:self selector:@selector(blink) userInfo:nil repeats:TRUE];
        blinkStatus = FALSE;
    }
}

@end
