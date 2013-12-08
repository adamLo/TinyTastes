//
//  DrinkViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface DrinkViewController : UIViewController {
    IBOutlet UILabel *countdownLabel;
    IBOutlet UILabel *chooseLabel;
    IBOutlet UILabel *timeLeftLabel;

    NSTimer *countdownTimer;
    NSMutableArray *animationImageArray;
    int secondsCount;
    int secondsCountFinal;
    int currentFrame;
    int animationDuration;
    bool blinkStatus;

    IBOutlet UIImageView *drinkingCritter;
    IBOutlet UIImageView *redLine;
    
    IBOutlet UIButton *doneButton;
    IBOutlet UIButton *allFinishedButton;
    IBOutlet UIButton *partiallyFinishedButton;
    IBOutlet UIButton *notFinishedButton;
    IBOutlet UIButton *pauseButton;
    IBOutlet UIButton *resumeButton;
}
@property (weak, nonatomic) IBOutlet UIImage *drinkingImage1;
@property (weak, nonatomic) IBOutlet UIImage *drinkingImage2;
@property int timeToDrink;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer1;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer2;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer3;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer4;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer5;

@end