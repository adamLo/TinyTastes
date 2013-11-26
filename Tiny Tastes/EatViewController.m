//
//  EatViewController.m
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "EatViewController.h"
#import "FeedbackViewController.h"

@interface EatViewController ()

@end

@implementation EatViewController

@synthesize audioPlayer1;
@synthesize audioPlayer2;
@synthesize audioPlayer3;
@synthesize audioPlayer4;
@synthesize audioPlayer5;
@synthesize audioPlayer6;
@synthesize audioPlayer7;
@synthesize audioPlayer8;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.83 alpha:1.0];
    allFinishedButton.hidden = YES;
    partiallyFinishedButton.hidden = YES;
    notFinishedButton.hidden = YES;
    
    chooseLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:40];
    timeLeftLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:55];
    chooseLabel.hidden = YES;
    redLine.hidden = YES;
    
    lastEaten = -12;
    phraseStatus = YES;
    
    // set timer
    [self setTimer];
    secondsCountFinal = secondsCount;
    [self setUpAudioPlayers];
    
    // display picture of the food
    foodImageView = [[UIImageView alloc] init];
    if (self.foodImage == NULL) {
        self.foodImage = [UIImage imageNamed:@"default_food.png"];
        foodImageView.frame = CGRectMake(362, 312, 400, 400);
        
    } else{
        foodImageView.frame = CGRectMake(312, 302, 500, 435);
    }
    
    foodImageView.image = self.foodImage;
    [self.view addSubview:foodImageView];
    
    // display disappearing food
    disappearingFood = [[UIImageView alloc] init];
    disappearingFood.frame = CGRectMake(362, 312, 400, 400);
    disappearingFood.animationImages = [NSArray arrayWithObjects:
                                        self.foodImage,
                                        [UIImage imageNamed:@"bowl1.png"],
                                        [UIImage imageNamed:@"bowl2.png"],
                                        [UIImage imageNamed:@"bowl3.png"],
                                        [UIImage imageNamed:@"bowl4.png"],
                                        [UIImage imageNamed:@"bowl5.png"],
                                        [UIImage imageNamed:@"bowl6.png"],
                                        [UIImage imageNamed:@"bowl7.png"],
                                        [UIImage imageNamed:@"bowl8.png"],
                                        [UIImage imageNamed:@"bowl9.png"],
                                        [UIImage imageNamed:@"bowl10.png"],
                                        [UIImage imageNamed:@"bowl11.png"],
                                        [UIImage imageNamed:@"bowl12.png"], nil];
    disappearingFood.animationDuration = secondsCount;
    [self.view addSubview:disappearingFood];
    [disappearingFood startAnimating];
    
    // display critter animation -- 3 seconds eating, 12 seconds with spoon back down on plate
    eatingCritter.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"eating_critter_1.jpg"],
                                     [UIImage imageNamed:@"eating_critter_2.jpg"],
                                     [UIImage imageNamed:@"eating_critter_1.jpg"],
                                     [UIImage imageNamed:@"eating_critter_1.jpg"],
                                     [UIImage imageNamed:@"eating_critter_1.jpg"],nil];
    eatingCritter.animationDuration = 15;
    [self.view addSubview:eatingCritter];
    [eatingCritter startAnimating];

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

- (void) setUpAudioPlayers {
    NSString *path = [[NSBundle mainBundle]pathForResource:@"i_like_this" ofType:@"m4a"];
    audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audioPlayer1 setVolume:0.5];
    
    path = [[NSBundle mainBundle]pathForResource:@"eating_sound_1" ofType:@"m4a"];
    audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audioPlayer2 setVolume:0.5];
    
    path = [[NSBundle mainBundle]pathForResource:@"its_fun_eating_together" ofType:@"m4a"];
    audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audioPlayer3 setVolume:0.5];
    
    path = [[NSBundle mainBundle]pathForResource:@"i_like_eating_with_you" ofType:@"m4a"];
    audioPlayer4 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audioPlayer4 setVolume:0.5];
    
    path = [[NSBundle mainBundle]pathForResource:@"trying_new_things" ofType:@"m4a"];
    audioPlayer5 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audioPlayer5 setVolume:0.5];
    
    path = [[NSBundle mainBundle]pathForResource:@"eating_sound_2" ofType:@"m4a"];
    audioPlayer6 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audioPlayer6 setVolume:0.5];
    
    path = [[NSBundle mainBundle]pathForResource:@"encouragement" ofType:@"m4a"];
    audioPlayer7 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audioPlayer7 setVolume:0.5];
    
    path = [[NSBundle mainBundle]pathForResource:@"this_is_good" ofType:@"m4a"];
    audioPlayer8 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audioPlayer8 setVolume:0.5];
}

- (void)playSoundBite {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"backgroundSound"] == YES) {
        if ((secondsCount % 180) == 0) { //play "Mmm I like this" every 3 minutes
            [audioPlayer1 play];
        } else if ((lastEaten + 15) == (secondsCountFinal-secondsCount)) {  //play sipping sound during every sip
            lastEaten = (secondsCountFinal-secondsCount);
            [audioPlayer2 play];
        } else if ((secondsCount % 150) == 0) { //play "It's fun eating together" and "I like eating with you" every 2.5 minutes
            if (phraseStatus == YES) {  //"It's fun eating together"
                phraseStatus = NO;
                [audioPlayer3 play];
            } else {
                phraseStatus = YES;  //"I like eating with you"
                [audioPlayer4 play];
            }
        } else if ((secondsCountFinal/2) == secondsCount) {  //play "It's fun trying new things!" once halfway through
            [audioPlayer5 play];
        } else if ((secondsCountFinal-6) == secondsCount) {  //play "Mmm!" after first sip
            [audioPlayer6 play];
        } else if (secondsCount == 480) {  //play encouragement sound 8 minutes before the end
            [audioPlayer7 play];
        } else if (((secondsCount % 30) == 0) && ((secondsCount % 60) != 0)) { //play "This is good!" every minute
            [audioPlayer8 play];
        }
    }
}

- (void)setTimer {
    secondsCount = 60 * self.timeToEat; //what about snacks?
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats: YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    FeedbackViewController *controller = (FeedbackViewController *)segue.destinationViewController;
    if([segue.identifier isEqualToString:@"allFinishedSegue"]){
        controller.feedbackText = @"Great job!";
        controller.numCoins = 3;
        controller.eating = YES;
    }
    if([segue.identifier isEqualToString:@"triedSomeSegue"]){
        controller.feedbackText = @"Thanks for eating with me!";
        controller.numCoins = 1;
        controller.eating = YES;
    }
    if([segue.identifier isEqualToString:@"notFinishedSegue"]){
        controller.feedbackText = @"Maybe we can try next time!";
        controller.numCoins = 0;
        controller.eating = YES;
    }
    [audioPlayer1 stop];
    [audioPlayer2 stop];
    [audioPlayer3 stop];
    [audioPlayer4 stop];
    [audioPlayer5 stop];
    [audioPlayer6 stop];
    [audioPlayer7 stop];
    [audioPlayer8 stop];
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
    doneButton.hidden = YES;
    [eatingCritter stopAnimating];
    [disappearingFood stopAnimating];
    disappearingFood.image = [UIImage imageNamed:@"bowl12.png"];
    foodImageView.hidden = YES;
    
    [audioPlayer1 stop];
    [audioPlayer2 stop];
    [audioPlayer3 stop];
    [audioPlayer4 stop];
    [audioPlayer5 stop];
    [audioPlayer6 stop];
    [audioPlayer7 stop];
    [audioPlayer8 stop];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (![prefs boolForKey:@"HasLaunchedEatScreenOnce"]) {
        NSLog(@"first time launching in Eat screen");
        redLine.hidden = NO;
        [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)(1.0)  target:self selector:@selector(blink) userInfo:nil repeats:TRUE];
        blinkStatus = TRUE;
        [prefs setBool:YES forKey:@"HasLaunchedEatScreenOnce"];
        [prefs synchronize];
    }
}

@end
