//
//  PhotoViewController.h
//  Tiny Tastes
//
//  Created by guest user on 10/8/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    
    UIImage *chosenImage;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *instructionLabel;
@property (strong, nonatomic) IBOutlet UIButton *cameraIcon;
@property (strong, nonatomic) IBOutlet UILabel *backLabel;


- (IBAction)takePhoto:(UIButton *)sender;

@end
