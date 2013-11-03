//
//  PhotoViewController.m
//  Tiny Tastes
//
//  Created by Jei Min Yoo on 10/8/13.
//  Reference: http://www.appcoda.com/ios-programming-camera-iphone-app/
//  http://www.pushplay.net/2010/03/one-tap-uiimagepickercontroller-iphone-camera/
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "PhotoViewController.h"
#import "OverlayView.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.instructionLabel.titleLabel setFont: [UIFont fontWithName:@"KBZipaDeeDooDah" size:50]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // Create a new image picker instance:
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        // Set the image picker source:
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // Hide the controls:
        picker.showsCameraControls = YES;
        picker.navigationBarHidden = YES;
        picker.toolbarHidden = YES;
        
        // Insert the overlay:
        OverlayView *overlay = [[OverlayView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        overlay.picker = picker;
        picker.cameraOverlayView = overlay;
        
        // Show the picker:
        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"This device has no camera"
                                                        delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
        [myAlertView show];
    }
    
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    if (info == NULL) {
        NSLog(@"info null");
    }
    
    if (info[UIImagePickerControllerEditedImage] == NULL) {
        NSLog(@"image null");
    }
        
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        self.imageView.image = chosenImage;
        self.cameraIcon.hidden = YES;
        self.instructionLabel.hidden = YES;
        
        [picker dismissViewControllerAnimated:YES completion:NULL];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
