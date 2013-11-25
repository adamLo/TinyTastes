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
    int secondsCount;
    int secondsCountFinal;
    int lastEaten;
    bool blinkStatus;
    bool phraseStatus;
    
    IBOutlet UIImageView *eatingCritter;
    IBOutlet UIImageView *foodImageView;
    IBOutlet UIImageView *disappearingFood;
    IBOutlet UIImageView *redLine;
    
    IBOutlet UIButton *doneButton;
    IBOutlet UIButton *allFinishedButton;
    IBOutlet UIButton *partiallyFinishedButton;
    IBOutlet UIButton *notFinishedButton;
}

@property (weak, nonatomic) IBOutlet UIImage *foodImage;
@property int timeToEat;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer1;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer2;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer3;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer4;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer5;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer6;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer7;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer8;

@end
