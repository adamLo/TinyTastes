//
//  PhotoViewController.m
//  Tiny Tastes
//
//  Created by Jei Min Yoo on 10/8/13.
//  Reference: http://www.appcoda.com/ios-programming-camera-iphone-app/
//  http://www.pushplay.net/2010/03/one-tap-uiimagepickercontroller-iphone-camera/
//  Cropping & Masking: http://iosdevelopertips.com/cocoa/how-to-mask-an-image.html#comment-58842
//  More on image masking: https://developer.apple.com/library/mac/documentation/graphicsimaging/conceptual/drawingwithquartz2d/dq_images/dq_images.html#//apple_ref/doc/uid/TP30001066-CH212-CJBJCJCE
//  storing image using NSUserDefaults: http://stackoverflow.com/questions/7620165/iphonehow-can-i-store-uiimage-using-nsuserdefaults
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "PhotoViewController.h"
#import "OverlayView.h"
#import "EatViewController.h"
#import <QuartzCore/QuartzCore.h>

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
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //first time photo page is launched
    if (![prefs boolForKey:@"photoView"]) {
        [prefs setBool:YES forKey:@"photoView"];
        [prefs synchronize];
    } else {
        thoughtBubble.hidden = YES;
        cameraInstructionLabel.hidden = YES;
    }
    
    [mealOrSnackControl setFrame:CGRectMake(300, 300, 300, 300)];
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.83 alpha:1.0];
    [self.instructionLabel.titleLabel setFont: [UIFont fontWithName:@"KBZipaDeeDooDah" size:60]];
    [self.instructionLabel.titleLabel setTextAlignment:UITextAlignmentCenter];
    [eatLabel.titleLabel setFont: [UIFont fontWithName:@"KBZipaDeeDooDah" size:35]];
    [retakeLabel.titleLabel setFont: [UIFont fontWithName:@"KBZipaDeeDooDah" size:50]];
    customizeTimerLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:60];
    timeDisplayLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    mealOrSnackLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:60];

    mealStepper.minimumValue = 5;
    mealStepper.maximumValue = 60;
    mealStepper.wraps = YES;
    mealStepper.autorepeat = YES;
    mealStepper.continuous = YES;
    
    customizeTimerLabel.hidden = YES;
    timeDisplayLabel.hidden = YES;
    mealStepper.hidden = YES;
    retakeLabel.hidden = YES;
    
    // Show Start button on Step 1 for Simulator
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPad Simulator"]) {
        eatLabel.hidden = NO;
    } else {
        eatLabel.hidden = YES;
    }
    
    //Change settings (font, size) of segment control
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont fontWithName:@"KBZipaDeeDooDah" size:35], UITextAttributeFont,
                                [UIColor grayColor], UITextAttributeTextColor, nil];
    [mealOrSnackControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary *highlightedAttributes = [NSDictionary
                                           dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [mealOrSnackControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mealStepperValueChanged:(id)sender
{
    double stepperValue = mealStepper.value;
    timeDisplayLabel.text = [NSString stringWithFormat:@"%.f minutes", stepperValue];
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
    customizeTimerLabel.hidden = NO;
    timeDisplayLabel.hidden = NO;
    mealStepper.hidden = NO;
    retakeLabel.hidden = NO;
    eatLabel.hidden = NO;
    
    chosenImage = info[UIImagePickerControllerEditedImage];
    self.cameraIcon.hidden = YES;
    self.instructionLabel.hidden = YES;
    mealOrSnackControl.hidden = YES;
    mealOrSnackLabel.hidden = YES;
    thoughtBubble.hidden = YES;
    cameraInstructionLabel.hidden = YES;
    
    if (mealOrSnackControl.selectedSegmentIndex == 0) {
        mealStepper.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"mealTimer"];
    } else {
        mealStepper.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"snackTimer"];
    }
    timeDisplayLabel.text = [NSString stringWithFormat:@"%.f minutes", mealStepper.value];
    
    // Crop the image with an image mask
    chosenImage = [self maskImage :chosenImage withMask:[UIImage imageNamed:@"cutout.jpg"]];
    

    
    UIImage *overlayGraphic = [UIImage imageNamed:@"camera_overlay.jpg"];
    UIImageView *overlayGraphicView = [[UIImageView alloc] initWithImage:overlayGraphic];
    overlayGraphicView.frame = CGRectMake(180, 200, overlayGraphic.size.width, overlayGraphic.size.height);
    [self.view addSubview:overlayGraphicView];
    
    UIImageView *foodImageView = [[UIImageView alloc] init];
    foodImageView.image = chosenImage;
    
    foodImageView.frame = CGRectMake(200, 20, chosenImage.size.width/1.2, chosenImage.size.height/1.2);
    [self.view addSubview:foodImageView];
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(CGImageRef) CopyImageAndAddAlphaChannel :(CGImageRef) sourceImage
{
    CGImageRef retVal = NULL;
    
    size_t width = CGImageGetWidth(sourceImage);
    size_t height = CGImageGetHeight(sourceImage);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL, width, height,
                                                          8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    if (offscreenContext != NULL) {
        CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), sourceImage);
        
        retVal = CGBitmapContextCreateImage(offscreenContext);
        CGContextRelease(offscreenContext);
    }
    
    CGColorSpaceRelease(colorSpace);
    
    return retVal;
}

- (UIImage*)maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef sourceImage = [image CGImage];
    CGImageRef imageWithAlpha = sourceImage;
    //add alpha channel for images that don’t have one (ie GIF, JPEG, etc…)
    //this however has a computational cost
    if (CGImageGetAlphaInfo(sourceImage) == kCGImageAlphaNone) {
        imageWithAlpha = [self CopyImageAndAddAlphaChannel :sourceImage];
    }
    
    CGImageRef masked = CGImageCreateWithMask(imageWithAlpha, mask);
    CGImageRelease(mask);
    
    //release imageWithAlpha if it was created by CopyImageAndAddAlphaChannel
    if (sourceImage != imageWithAlpha) {
        CGImageRelease(imageWithAlpha);
    }
    
    UIImage* retImage = [UIImage imageWithCGImage:masked];
    CGImageRelease(masked);
    
    return retImage;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"letsEatSegue"]){
        EatViewController *controller = (EatViewController *)segue.destinationViewController;
        controller.foodImage = chosenImage;
        controller.timeToEat = mealStepper.value;
    }
}

@end
