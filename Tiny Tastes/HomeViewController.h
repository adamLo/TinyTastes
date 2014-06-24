//
//  HomeViewController.h
//  Tiny Tastes
//
//  Created by davile2 on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface HomeViewController : UIViewController {
    IBOutlet UIButton *storyModeLabel;
    IBOutlet UIButton *letsDrinkLabel;
    IBOutlet UIButton *letsEatLabel;
    IBOutlet UIButton *tinyShopLabel;
    IBOutlet UIButton *settingsLabel;
}

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@property (weak, nonatomic) IBOutlet UIImageView *animatedTiny; /** ImageView for Animated tiny phase images */

@end
