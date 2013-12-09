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
@synthesize audioPlayer1;
@synthesize audioPlayer2;
@synthesize audioPlayer3;
@synthesize audioPlayer4;
@synthesize audioPlayer5;

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
    allFinishedButton.hidden = YES;
    partiallyFinishedButton.hidden = YES;
    notFinishedButton.hidden = YES;
    resumeButton.hidden = YES;
    
    chooseLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:40];
    timeLeftLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:55];
    chooseLabel.hidden = YES;
    redLine.hidden = YES;
    
    drinkingCritter.animationImages = [NSArray arrayWithObjects:drinkingImage1, drinkingImage2, nil];
    drinkingCritter.animationDuration = 10;
    [self.view addSubview:drinkingCritter];
    [drinkingCritter startAnimating];
    
    [self setUpAudioPlayers];
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
    [audioPlayer2 setVolume:0.5];

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
    secondsCount = 60 * timeToDrink;
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
        redLine.hidden = NO;
        blinkStatus = TRUE;
    }else {
        redLine.hidden = YES;
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
    allFinishedButton.hidden = NO;
    partiallyFinishedButton.hidden = NO;
    notFinishedButton.hidden = NO;
    chooseLabel.hidden = NO;
    doneButton.hidden = YES;
    countdownLabel.hidden = YES;
    timeLeftLabel.hidden = YES;
    pauseButton.hidden = YES;
    resumeButton.hidden = YES;
    
    [self stopAudioPlayers];
    
    [drinkingCritter stopAnimating];
    [drinkingCritter setImage:drinkingImage1];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (![prefs boolForKey:@"HasLaunchedDrinkScreenOnce"]) {
        redLine.hidden = NO;
        [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)(1.0)  target:self selector:@selector(blink) userInfo:nil repeats:TRUE];
        blinkStatus = TRUE;
        [prefs setBool:YES forKey:@"HasLaunchedDrinkScreenOnce"];
        [prefs synchronize];
    }
}
- (IBAction)pauseButtonClicked:(id)sender {
    pauseButton.hidden = YES;
    resumeButton.hidden = NO;
    
    // Pause the timer
    [countdownTimer invalidate];
    
    [self stopAudioPlayers];
    
    [drinkingCritter stopAnimating];
}

- (IBAction)resumeButtonClicked:(id)sender {
    resumeButton.hidden = YES;
    pauseButton.hidden = NO;
    
    [self playSoundBite];
    
    [drinkingCritter startAnimating];
    
    // Resume the timer
    [self resetTimer];
}



@end
