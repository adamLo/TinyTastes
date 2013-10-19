//
//  PhotoViewController.h
//  Tiny Tastes
//
//  Created by guest user on 10/8/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)takePhoto:(UIButton *)sender;


@end
