//
//  HomeViewController.h
//  Tiny Tastes
//
//  Created by davile2 on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

/**
 *  Controller for home screen
 */
@interface HomeViewController : UIViewController {
    
}

@property (weak, nonatomic) IBOutlet UIButton *storyModeButton; /** Button that takes user to story book screen */
@property (weak, nonatomic) IBOutlet UIButton *letsDrinkButton; /** Button that takes user to drinking screen */
@property (weak, nonatomic) IBOutlet UIButton *letsEatButton;  /** Button that takes user to eating screen */
@property (weak, nonatomic) IBOutlet UIButton *tinyShopButton;  /** Button that takes user to shop screen */
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;  /** Button that takes user to settings screen */
@property (weak, nonatomic) IBOutlet UIImageView *animatedTiny; /** ImageView for Animated tiny phase images */

@property (strong, nonatomic) AVAudioPlayer *audioPlayer; /** Audio player to play background music */

@end
