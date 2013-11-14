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
    
    backLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:35];
    chooseLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:40];
    timeLeftLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:55];
    chooseLabel.hidden = YES;
    redLine.hidden = YES;
    
    // set timer
    [self setTimer];
    
    // display picture of the food
    if (self.foodImage == NULL) {
        self.foodImage = [UIImage imageNamed:@"default_food.png"];
    }
    foodImageView.image = self.foodImage;
    [self.view addSubview:foodImageView];
    
    // display disappearing food
    disappearingFood.animationImages = [NSArray arrayWithObjects:
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
    
    // display critter animation
    eatingCritter.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"eating_critter_1.jpg"],
                                     [UIImage imageNamed:@"eating_critter_2.jpg"], nil];
    eatingCritter.animationDuration = 10;
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
    
    if (secondsCount == 0) {
        [countdownTimer invalidate];
        countdownTimer = nil;
        [self doneButtonClicked];
    }
    
}
- (void)setTimer {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    secondsCount = 60 * [prefs integerForKey:@"mealTimer"]; //what about snacks?
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
        controller.feedbackText = @"Thanks for eating with me!";
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
    [eatingCritter stopAnimating];
    [disappearingFood stopAnimating];
    disappearingFood.image = [UIImage imageNamed:@"bowl12.png"];
    foodImageView.hidden = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)(1.0)  target:self selector:@selector(blink) userInfo:nil repeats:TRUE];
    blinkStatus = FALSE;
}

@end
