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
    allFinishedButton.hidden = YES;
    allFinishedButtonImage.alpha = 0;
    partiallyFinishedButton.hidden = YES;
    partiallyFinishedButtonImage.alpha = 0;
    notFinishedButton.hidden = YES;
    notFinishedButtonImage.alpha = 0;
    
    drinkingCritter.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"drinking_critter_1.jpg"],
                                     [UIImage imageNamed:@"drinking_critter_2.jpg"], nil];
    //drinkingCritter.contentMode = UIViewContentModeLeft;    

    drinkingCritter.animationDuration = 4;
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
    
    if (secondsCount == 0) {
        [countdownTimer invalidate];
        countdownTimer = nil;
        [self doneButtonClicked];
    }
    
}
- (void)setTimer {
    secondsCount = 100; //hard-coded value, change this
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

- (IBAction)doneButtonClicked {
    [countdownTimer invalidate];
    countdownTimer = nil;
    allFinishedButton.hidden = NO;
    partiallyFinishedButton.hidden = NO;
    notFinishedButton.hidden = NO;
    doneButton.hidden = 0;
    allFinishedButtonImage.alpha = 1;
    partiallyFinishedButtonImage.alpha = 1;
    notFinishedButtonImage.alpha = 1;
    doneButtonImage.alpha = 0;
    [drinkingCritter stopAnimating];
}

@end
