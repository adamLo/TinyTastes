//
//  DrinkViewController.m
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "DrinkViewController.h"
#import "FeedbackViewController.h"
#import "UIFont+TinyTastes.h"

@interface DrinkViewController () {
    NSTimer *countdownTimer;
    int secondsCount;
    int secondsCountFinal;
    int currentFrame;
    int animationDuration;
    bool blinkStatus;
    
    AVAudioPlayer *audioPlayer1;
    AVAudioPlayer *audioPlayer2;
    AVAudioPlayer *audioPlayer3;
    AVAudioPlayer *audioPlayer4;
    AVAudioPlayer *audioPlayer5;
    
    NSArray *animationImages; //Array of animation image arrays. Top level order is same as enum in header
    
}

@end

@implementation DrinkViewController

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
    self.allFinishedButton.hidden = YES;
    self.partiallyFinishedButton.hidden = YES;
    self.notFinishedButton.hidden = YES;
    self.resumeButton.hidden = YES;
    
    //Set button fonts
    [self.allFinishedButton.titleLabel setFont:[UIFont ttFont50]];
    [self.allFinishedButton setTitle:NSLocalizedString(@"all finished!", @"All finished button title") forState:UIControlStateNormal];
    
    [self.partiallyFinishedButton.titleLabel setFont:[UIFont ttFont50]];
    [self.partiallyFinishedButton setTitle:NSLocalizedString(@"tried some", @"Tried some button title") forState:UIControlStateNormal];
    
    [self.notFinishedButton.titleLabel setFont:[UIFont ttFont40]];
    [self.notFinishedButton setTitle:NSLocalizedString(@"none this time", @"None this time button title") forState:UIControlStateNormal];
    
    [self.doneButton.titleLabel setFont:[UIFont ttFont50]];
    [self.doneButton setTitle:NSLocalizedString(@"I\'m done", @"Done button title") forState:UIControlStateNormal];
    
    self.chooseLabel.font = [UIFont ttFont40];
    self.timeLeftLabel.font = [UIFont ttFont55];
    self.chooseLabel.hidden = YES;
    self.redLine.hidden = YES;
    
    animationImages = @[
                        @[[UIImage imageNamed:@"drinking_sippy_1"], [UIImage imageNamed:@"drinking_sippy_2"]],
                        @[[UIImage imageNamed:@"drinking_juice_1"], [UIImage imageNamed:@"drinking_juice_2"]],
                        @[[UIImage imageNamed:@"drinking_glass_1"], [UIImage imageNamed:@"drinking_glass_2"]],
                        @[[UIImage imageNamed:@"drinking_pediasure_1"], [UIImage imageNamed:@"drinking_pediasure_2"]],
                        @[[UIImage imageNamed:@"drinking_bottle_1"], [UIImage imageNamed:@"drinking_bottle_2"]],
                        ];
    
    self.drinkingCritter.animationDuration = 10;
    //[self.view addSubview:self.drinkingCritter];
    
    self.countdownLabel.textAlignment = NSTextAlignmentCenter;
    self.countdownLabel.font = [UIFont ttFont70];
    
}

- (void)viewWillAppear:(BOOL)animated {
    //Start animating
    self.drinkingCritter.image = [[animationImages objectAtIndex:self.selectedDrinkType] firstObject];
    self.drinkingCritter.animationImages = [animationImages objectAtIndex:self.selectedDrinkType];
    
    //set up audio
    [self setUpAudioPlayers];
    
}

- (void)viewDidAppear:(BOOL)animated {
    //Start animation
    [self.drinkingCritter startAnimating];
    
    //Start timer
    [self setTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    //Stop audio players when navigation away from screen to make sure they stop
    [self stopAudioPlayers];
    
    //Stop animation
    [self.drinkingCritter stopAnimating];
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
    self.countdownLabel.text = timerOutput;
    
    [self playSoundBite];

    if (secondsCount == 0) {
        [countdownTimer invalidate];
        countdownTimer = nil;
        [self doneButtonClicked];
    }
    
}

- (void)setUpAudioPlayers {
    NSString *path = [[NSBundle mainBundle]pathForResource:@"i_like_this" ofType:@"m4a"];
    audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audioPlayer1 setVolume:0.5];

    path = [[NSBundle mainBundle]pathForResource:@"slurping" ofType:@"mp3"];
    audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audioPlayer2 setVolume:0.1];

    path = [[NSBundle mainBundle]pathForResource:@"this_is_good" ofType:@"m4a"];
    audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audioPlayer3 setVolume:0.5];

    path = [[NSBundle mainBundle]pathForResource:@"eating_sound_2" ofType:@"m4a"];
    audioPlayer4 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audioPlayer4 setVolume:0.5];

    path = [[NSBundle mainBundle]pathForResource:@"encouragement" ofType:@"m4a"];
    audioPlayer5 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audioPlayer5 setVolume:0.5];
}

- (void)playSoundBite {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"backgroundSound"] == YES) {
        if ((secondsCount % 180) == 0) { //play "Mmm I like this" every 3 minutes
            [audioPlayer1 play];
        } else if (((secondsCount % 5) == 0) && ((secondsCount % 10) != 0)) {  //play sipping sound during every sip
            [audioPlayer2 play];
        } else if (((secondsCount % 30) == 0) && ((secondsCount % 60) != 0)) { //play "This is good!" every minute
            [audioPlayer3 play];
        } else if ((secondsCountFinal-10) == secondsCount) {  //play "Mmm!" after first sip
            [audioPlayer4 play];
        } else if (secondsCount == 180) {  //play encouragement sound 3 minutes before the end
            [audioPlayer5 play];
        }
    }
}

- (void)setTimer {
    secondsCount = 60 * self.timeToDrink;
    secondsCountFinal = secondsCount;
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats: YES];
}

- (void) resetTimer {
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats: YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    FeedbackViewController *controller = (FeedbackViewController *)segue.destinationViewController;
    if([segue.identifier isEqualToString:@"allFinishedSegue"]){
        controller.feedbackText = @"Great job!";
        controller.numCoins = 3;
        controller.eating = NO;
    }
    if([segue.identifier isEqualToString:@"triedSomeSegue"]){
        controller.feedbackText = @"Thanks for drinking with me!";
        controller.numCoins = 1;
        controller.eating = NO;
    }
    if([segue.identifier isEqualToString:@"notFinishedSegue"]){
        controller.feedbackText = @"Maybe we can try next time!";
        controller.numCoins = 0;
        controller.eating = NO;
    }
    [self stopAudioPlayers];
}

- (void)blink {
    if(blinkStatus == FALSE){
        self.redLine.hidden = NO;
        blinkStatus = TRUE;
    }else {
        self.redLine.hidden = YES;
        blinkStatus = FALSE;
    }
}

- (void)stopAudioPlayers {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"backgroundSound"] == YES) {
        [audioPlayer1 stop];
        [audioPlayer2 stop];
        [audioPlayer3 stop];
        [audioPlayer4 stop];
        [audioPlayer5 stop];
        audioPlayer1 = nil;
        audioPlayer2 = nil;
        audioPlayer3 = nil;
        audioPlayer4 = nil;
        audioPlayer5 = nil;
    }
}

- (IBAction)doneButtonClicked {
    [countdownTimer invalidate];
    countdownTimer = nil;
    self.allFinishedButton.hidden = NO;
    self.partiallyFinishedButton.hidden = NO;
    self.notFinishedButton.hidden = NO;
    self.chooseLabel.hidden = NO;
    self.doneButton.hidden = YES;
    self.countdownLabel.hidden = YES;
    self.timeLeftLabel.hidden = YES;
    self.pauseButton.hidden = YES;
    self.resumeButton.hidden = YES;
    
    [self stopAudioPlayers];
    
    [self.drinkingCritter stopAnimating];
    //[self.drinkingCritter setImage:self.drinkingImage1];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (![prefs boolForKey:@"HasLaunchedDrinkScreenOnce"]) {
        self.redLine.hidden = NO;
        [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)(1.0)  target:self selector:@selector(blink) userInfo:nil repeats:TRUE];
        blinkStatus = TRUE;
        [prefs setBool:YES forKey:@"HasLaunchedDrinkScreenOnce"];
        [prefs synchronize];
    }
}
- (IBAction)pauseButtonClicked:(id)sender {
    self.pauseButton.hidden = YES;
    self.resumeButton.hidden = NO;
    
    // Pause the timer
    [countdownTimer invalidate];
    
    [self stopAudioPlayers];
    
    [self.drinkingCritter stopAnimating];
    
    [self.drinkingCritter setImage:[[self.drinkingCritter animationImages] firstObject]];
}

- (IBAction)resumeButtonClicked:(id)sender {
    self.resumeButton.hidden = YES;
    self.pauseButton.hidden = NO;
    
    [self setUpAudioPlayers];
    [self playSoundBite];
    
    [self.drinkingCritter startAnimating];
    
    // Resume the timer
    [self resetTimer];
}



- (IBAction)homeButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
