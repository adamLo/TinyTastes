//
//  EatViewController.m
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "EatViewController.h"
#import "FeedbackViewController.h"
#import "UIFont+TinyTastes.h"
#import "XMLDictionary.h"
#import "Constants.h"
#import "UIView+TTAnimation.h"

@interface EatViewController () {
    NSTimer *countdownTimer;
    NSMutableArray *animationImageArray;
    int secondsCount;
    int secondsCountFinal;
    int lastEaten;
    NSInteger currentFrame;
    int animationDuration;
    bool blinkStatus;
    bool phraseStatus;
    
    AVAudioPlayer *audioPlayer1;
    AVAudioPlayer *audioPlayer2;
    AVAudioPlayer *audioPlayer3;
    AVAudioPlayer *audioPlayer4;
    AVAudioPlayer *audioPlayer5;
    AVAudioPlayer *audioPlayer6;
    AVAudioPlayer *audioPlayer7;
    AVAudioPlayer *audioPlayer8;
    
}

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
    self.allFinishedButton.hidden = YES;
    self.partiallyFinishedButton.hidden = YES;
    self.notFinishedButton.hidden = YES;
    self.resumeButton.hidden = YES;
    
    self.chooseLabel.font = [UIFont ttFont40];
    self.timeLeftLabel.font = [UIFont ttFont55];
    [self.pauseButton.titleLabel setFont:[UIFont ttFont55]];
    [self.resumeButton.titleLabel setFont:[UIFont ttFont55]];
    self.chooseLabel.hidden = YES;
    self.redLine.hidden = YES;
    
    self.countdownLabel.textAlignment = NSTextAlignmentCenter;
    self.countdownLabel.font = [UIFont ttFont70];
    
    lastEaten = -12;
    phraseStatus = YES;
    
    // set timer
    [self setTimer];
    secondsCountFinal = secondsCount;
    [self setUpAudioPlayers];
    
    animationImageArray = [NSMutableArray arrayWithObjects:
                           [UIImage imageNamed:@"disappearing-food_00.png"],
                           [UIImage imageNamed:@"disappearing-food_01.png"],
                           [UIImage imageNamed:@"disappearing-food_02.png"],
                           [UIImage imageNamed:@"disappearing-food_03.png"],
                           [UIImage imageNamed:@"disappearing-food_04.png"],
                           [UIImage imageNamed:@"disappearing-food_05.png"],
                           [UIImage imageNamed:@"disappearing-food_06.png"],
                           [UIImage imageNamed:@"disappearing-food_07.png"],
                           [UIImage imageNamed:@"disappearing-food_08.png"],
                           [UIImage imageNamed:@"disappearing-food_09.png"],
                           [UIImage imageNamed:@"disappearing-food_10.png"],
                           [UIImage imageNamed:@"disappearing-food_11.png"],
                           [UIImage imageNamed:@"disappearing-food_12.png"],
                           nil];
    
    self.disappearingFood.animationImages = animationImageArray;
    
    // display critter animation -- 3 seconds eating, 12 seconds with spoon back down on plate
    self.eatingCritter.animationImages = @[[UIImage imageNamed:@"tiny_eating_1"], [UIImage imageNamed:@"tiny_eating_2"],
                                      [UIImage imageNamed:@"tiny_eating_2"],
                                      [UIImage imageNamed:@"tiny_eating_2"],
                                      [UIImage imageNamed:@"tiny_eating_2"]];
    self.eatingCritter.animationDuration = 15;
    
    //Set button fonts
    [self.allFinishedButton.titleLabel setFont:[UIFont ttFont50]];
    [self.allFinishedButton setTitle:NSLocalizedString(@"all finished!", @"All finished button title") forState:UIControlStateNormal];
    
    [self.partiallyFinishedButton.titleLabel setFont:[UIFont ttFont50]];
    [self.partiallyFinishedButton setTitle:NSLocalizedString(@"tried some", @"Tried some button title") forState:UIControlStateNormal];
    
    [self.notFinishedButton.titleLabel setFont:[UIFont ttFont40]];
    [self.notFinishedButton setTitle:NSLocalizedString(@"none this time", @"None this time button title") forState:UIControlStateNormal];
    
    [self.doneButton.titleLabel setFont:[UIFont ttFont50]];
    [self.doneButton setTitle:NSLocalizedString(@"I\'m done", @"Done button title") forState:UIControlStateNormal];
    
    // TODO: Replace hardcoded accessory xml files array with argument
    self.accessoryFiles = @[@"accessory_spoon_red.xml"];

}

- (void)viewWillAppear:(BOOL)animated {
    
    //Display food
    if (!self.foodImage) {
        self.foodImage = [UIImage imageNamed:@"greenpeas_cutout.png"];
    }
    self.foodImageView.image = self.foodImage;
    
    self.disappearingFood.image = [self.disappearingFood.animationImages firstObject];
    self.disappearingFood.animationDuration = secondsCount;
    animationDuration = secondsCount;
    
    //Add accessory animations
    [self addAccessoryViews];
    
}

- (void)viewDidAppear:(BOOL)animated {
    //Start animations
    [self.disappearingFood startAnimating];
    
    //Start Tiny animation
    [self.eatingCritter startAnimating];
    
    //Start accessories
    for (id subview in self.eatingCritter.subviews) {
        if ([subview respondsToSelector:@selector(startAnimating)]) {
            [subview performSelector:@selector(startAnimating)];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    
    //Stop all audio players when navigating away to make sure all sounds canceled
    [self stopAudioPlayers];
    
    //Stop animations
    [self.disappearingFood stopAnimating];
    [self.eatingCritter stopAnimating];
    
    //Sop accessories
    for (id subview in self.eatingCritter.subviews) {
        if ([subview respondsToSelector:@selector(stopAnimating)]) {
            [subview performSelector:@selector(stopAnimating)];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    //Remove all accessories
    for (id subview in self.eatingCritter.subviews) {
        if ([subview respondsToSelector:@selector(removeFromSuperview)]) {
            [subview performSelector:@selector(removeFromSuperview)];
        }
    }
}

#pragma mark - Accessories

- (void)addAccessoryViews {

    for (NSString *fileName in self.accessoryFiles) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        if (path) {
            
            //Get item details
            [XMLDictionaryParser sharedInstance].attributesMode = XMLDictionaryAttributesModeUnprefixed;
            NSDictionary *itemData = [NSDictionary dictionaryWithXMLFile:path];
            if (itemData) {
                //Add images
                if ([[itemData objectForKey:kStoryDictionaryKeyImage] isKindOfClass:[NSDictionary class]]) {
                    //Single image
                    UIImageView *imageView = [self.eatingCritter addImageViewFromDictionary:[itemData objectForKey:kStoryDictionaryKeyImage] sequence:0];
                    if (![itemData objectForKey:kStoryDictionaryKeyRepeat]) {
                        imageView.animationRepeatCount = self.eatingCritter.animationRepeatCount;
                    }
                    if (![itemData objectForKey:kStoryDictionaryKeyDuration]) {
                        imageView.animationDuration = self.eatingCritter.animationDuration;
                    }
                }
                else if ([[itemData objectForKey:kStoryDictionaryKeyImage] isKindOfClass:[NSArray class]]) {
                    //Multiple images
                    
                    //Add imageview
                    NSInteger sequence = 0;
                    for (NSDictionary *imageDict in [itemData objectForKey:kStoryDictionaryKeyImage]) {
                        UIImageView *imageView = [self.view addImageViewFromDictionary:imageDict sequence:sequence];
                        if (![itemData objectForKey:kStoryDictionaryKeyRepeat]) {
                            imageView.animationRepeatCount = self.eatingCritter.animationRepeatCount;
                        }
                        if (![itemData objectForKey:kStoryDictionaryKeyDuration]) {
                            imageView.animationDuration = self.eatingCritter.animationDuration;
                        }
                        sequence++;
                    }
                }
            }
            else {
                NSLog(@"Dictionary could not be parsed from %@", path);
            }
        }
        else {
            NSLog(@"File not found: %@", fileName);
        }
    }
    
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

- (void)resetTimer {
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats: YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    FeedbackViewController *controller = (FeedbackViewController *)segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"allFinishedSegue"]){
        controller.feedbackText = @"Great job!";
        controller.numCoins = 3;
        controller.eating = YES;
    }
    if ([segue.identifier isEqualToString:@"triedSomeSegue"]){
        controller.feedbackText = @"Thanks for eating with me!";
        controller.numCoins = 1;
        controller.eating = YES;
    }
    if ([segue.identifier isEqualToString:@"notFinishedSegue"]){
        controller.feedbackText = @"Maybe we can try next time!";
        controller.numCoins = 0;
        controller.eating = YES;
    }
    
    [self stopAudioPlayers];
}

- (void)blink{
    
    if (blinkStatus == FALSE){
        self.redLine.hidden = NO;
        blinkStatus = TRUE;
    }
    else {
        self.redLine.hidden = YES;
        blinkStatus = FALSE;
    }
}

- (void)stopAudioPlayers{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"backgroundSound"] == YES) {
        [audioPlayer1 stop];
        [audioPlayer2 stop];
        [audioPlayer3 stop];
        [audioPlayer4 stop];
        [audioPlayer5 stop];
        [audioPlayer6 stop];
        [audioPlayer7 stop];
        [audioPlayer8 stop];
        audioPlayer1 = nil;
        audioPlayer2 = nil;
        audioPlayer3 = nil;
        audioPlayer4 = nil;
        audioPlayer5 = nil;
        audioPlayer6 = nil;
        audioPlayer7 = nil;
        audioPlayer8 = nil;
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
    
    //Stop tiny
    [self.eatingCritter stopAnimating];
    //Stop accessories
    for (id subview in self.eatingCritter.subviews) {
        if ([subview respondsToSelector:@selector(stopAnimating)]) {
            [subview performSelector:@selector(stopAnimating)];
        }
    }
    
    [self.disappearingFood stopAnimating];
    
    self.disappearingFood.image = [self.disappearingFood.animationImages lastObject];
    self.foodImageView.hidden = YES;
    self.pauseButton.hidden = YES;
    self.resumeButton.hidden = YES;
    self.countdownLabel.hidden = YES;
    self.timeLeftLabel.hidden = YES;
    
    [self stopAudioPlayers];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (![prefs boolForKey:@"HasLaunchedEatScreenOnce"]) {
        NSLog(@"first time launching in Eat screen");
        self.redLine.hidden = NO;
        [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)(1.0)  target:self selector:@selector(blink) userInfo:nil repeats:TRUE];
        blinkStatus = TRUE;
        [prefs setBool:YES forKey:@"HasLaunchedEatScreenOnce"];
        [prefs synchronize];
    }
}

- (IBAction)pauseButtonClicked:(id)sender {
    self.pauseButton.hidden = YES;
    self.resumeButton.hidden = NO;
    
    // Pause the timer
    [countdownTimer invalidate];
    
    [self stopAudioPlayers];
    
    //Stop Tiny
    [self.eatingCritter stopAnimating];
    //Stop accessories
    for (id subview in self.eatingCritter.subviews) {
        if ([subview respondsToSelector:@selector(stopAnimating)]) {
            [subview performSelector:@selector(stopAnimating)];
        }
    }
    
    
    [self.disappearingFood stopAnimating];
    currentFrame = self.disappearingFood.animationImages.count * (animationDuration - secondsCount) / animationDuration;
    animationDuration = secondsCount;
    [self.disappearingFood setImage:[[self.disappearingFood animationImages] objectAtIndex:currentFrame]];
    

    
}

- (IBAction)resumeButtonClicked:(id)sender {
    self.resumeButton.hidden = YES;
    self.pauseButton.hidden = NO;
    
    [self setUpAudioPlayers];
    [self playSoundBite];
    
    // reset the disappearing food image to match the remaining time
    currentFrame = [animationImageArray indexOfObject: self.disappearingFood.image];
    
    for (int i = 0; i < currentFrame; i++) {
        [animationImageArray removeObjectAtIndex:0];
    }
    
    self.disappearingFood.animationImages = animationImageArray;
    self.disappearingFood.animationDuration = secondsCount;
    
    //Start Tiny
    [self.eatingCritter startAnimating];
    //Start accessories
    for (id subview in self.eatingCritter.subviews) {
        if ([subview respondsToSelector:@selector(startAnimating)]) {
            [subview performSelector:@selector(startAnimating)];
        }
    }
    
    [self.disappearingFood startAnimating];
    
    // Resume the timer
    [self resetTimer];
    
}

- (IBAction)homePressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
