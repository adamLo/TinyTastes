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
    
}

@property (weak, nonatomic) IBOutlet UIButton *storyModeLabel;
@property (weak, nonatomic) IBOutlet UIButton *letsDrinkLabel;
@property (weak, nonatomic) IBOutlet UIButton *letsEatLabel;
@property (weak, nonatomic) IBOutlet UIButton *tinyShopLabel;
@property (weak, nonatomic) IBOutlet UIButton *settingsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *animatedTiny; /** ImageView for Animated tiny phase images */

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end
