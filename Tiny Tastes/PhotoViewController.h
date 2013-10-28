//
//  PhotoViewController.h
//  Tiny Tastes
//
//  Created by guest user on 10/8/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

#define SCREEN_WIDTH 480
#define SCREEN_HEIGHT 320

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (strong, nonatomic) IBOutlet UIButton *instructionLabel;
@property (strong, nonatomic) IBOutlet UIButton *cameraIcon;

- (IBAction)takePhoto:(UIButton *)sender;

@end
