//
//  EatViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface EatViewController : UIViewController {
    IBOutlet UILabel *countdownLabel;
    IBOutlet UILabel *chooseLabel;
    IBOutlet UILabel *timeLeftLabel;

    NSTimer *countdownTimer;
    NSMutableArray *animationImageArray;
    int secondsCount;
    int secondsCountFinal;
    int lastEaten;
    NSInteger currentFrame;
    int animationDuration;
    bool blinkStatus;
    bool phraseStatus;
    
    
    IBOutlet UIImageView *redLine;
    
    IBOutlet UIButton *doneButton;
    IBOutlet UIButton *allFinishedButton;
    IBOutlet UIButton *partiallyFinishedButton;
    IBOutlet UIButton *notFinishedButton;
    IBOutlet UIButton *pauseButton;
    IBOutlet UIButton *resumeButton;
}

@property (nonatomic, weak) IBOutlet UIImageView *foodImageView; /** ImageView holding photo food */
@property (nonatomic, weak) IBOutlet UIImageView *disappearingFood; /** Imageview displaying animation of disappearing food (appearing plate bottom */
@property (nonatomic, weak) IBOutlet UIImageView *eatingCritter; /** Eating Tiny aniumation */

@property (weak, nonatomic) UIImage *foodImage; /** Masked image of food taken by PhotoViewController */
@property int timeToEat; /** Time in seconds counting down for eating */

@property (strong, nonatomic) AVAudioPlayer *audioPlayer1;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer2;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer3;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer4;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer5;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer6;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer7;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer8;

- (IBAction)homePressed:(id)sender; /** User pressed home button to go back to home screen */

@end
