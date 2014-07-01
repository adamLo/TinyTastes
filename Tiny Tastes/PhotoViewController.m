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
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <ImageIO/ImageIO.h>
#import "UIImage+Rotate.h"
#import "UIFont+TinyTastes.h"

@interface PhotoViewController () {
    UIImageView *cameraOverlay; //Empty bowl that will hold image of food
    UIImageView *foodImage; //Imageview displaying masked food in the bowl
    UIImage *chosenImage; //Maked, resized photo
    
    AVCaptureStillImageOutput *stillImageOutput;
    OverlayView *overlay;
    AVCaptureSession *session;
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
}

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
    [self.mealOrSnackControl setFrame:CGRectMake(300, 300, 300, 300)];
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.83 alpha:1.0];
    [self.instructionLabel.titleLabel setFont: [UIFont ttFont60]];
    self.instructionLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.eatLabel.titleLabel setFont: [UIFont ttFont35]];
    [self.retakeLabel.titleLabel setFont: [UIFont ttFont65]];
    self.customizeTimerLabel.font = [UIFont ttFont60];
    self.timeDisplayLabel.font = [UIFont ttFont50];
    self.mealOrSnackLabel.font = [UIFont ttFont50];
    
    self.mealStepper.minimumValue = 1;
    self.mealStepper.maximumValue = 60;
    self.mealStepper.wraps = YES;
    self.mealStepper.autorepeat = YES;
    self.mealStepper.continuous = YES;
    
    self.customizeTimerLabel.hidden = YES;
    self.timeDisplayLabel.hidden = YES;
    self.mealStepper.hidden = YES;
    self.retakeLabel.hidden = YES;
    self.eatLabel.hidden = YES;
    
    //Hide instruction if this is not the first time the app was launched
    //if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedEatScreenOnce"]) {
        //thoughtBubble.hidden = YES;
        //cameraInstructionLabel.hidden = YES
    //}

    //Change font of segment control
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont ttFont30], NSFontAttributeName,
                                [UIColor grayColor], NSForegroundColorAttributeName, nil];
    [self.mealOrSnackControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary *highlightedAttributes = [NSDictionary
                                           dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [self.mealOrSnackControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    //Remove food
    [foodImage removeFromSuperview];
    foodImage = nil;
    
    //Remove bowl
    [cameraOverlay removeFromSuperview];
    cameraOverlay = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mealStepperValueChanged:(id)sender
{
    double stepperValue = self.mealStepper.value;
    self.timeDisplayLabel.text = [NSString stringWithFormat:@"%.f minutes", stepperValue];
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        session = [[AVCaptureSession alloc] init];
        session.sessionPreset = AVCaptureSessionPresetPhoto;
        
        captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
        
        captureVideoPreviewLayer.frame = self.view.bounds;
        [self.view.layer addSublayer:captureVideoPreviewLayer];
        
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (!input) {
            // Handle the error appropriately.
            NSLog(@"ERROR: trying to open camera: %@", error);
        }
        [session addInput:input];
        
		
        stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
        [stillImageOutput setOutputSettings:outputSettings];
        
        [session addOutput:stillImageOutput];
        
        [session startRunning];
        
        overlay = [[OverlayView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        overlay.photoViewController = self;
        
        [self.view addSubview:overlay];
        
        AVCaptureConnection *previewLayerConnection=captureVideoPreviewLayer.connection;
        
        if ([previewLayerConnection isVideoOrientationSupported]) {
            [previewLayerConnection setVideoOrientation:(AVCaptureVideoOrientation)[[UIApplication sharedApplication] statusBarOrientation]];
        }
        
        
    } else {
#ifdef DEBUG
        //Add a sample photo when running on simulator
        chosenImage = [UIImage imageNamed:@"greenpeas.jpg"];
        [self processImage];
#else
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"This device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
#endif
    }

    
}

- (BOOL)shouldAutorotate {
    return NO;
}


-(IBAction)captureNow {
	AVCaptureConnection *videoConnection = nil;
	for (AVCaptureConnection *connection in stillImageOutput.connections)
	{
		for (AVCaptureInputPort *port in [connection inputPorts])
		{
			if ([[port mediaType] isEqual:AVMediaTypeVideo] )
			{
				videoConnection = connection;
				break;
			}
		}
		if (videoConnection) { break; }
	}
	
	NSLog(@"about to request a capture from: %@", stillImageOutput);
	[stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        
        if (!error && imageSampleBuffer) {
                
            //Get still image data in jpeg format
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
            chosenImage = [[UIImage alloc] initWithData:imageData];
                
            //Process image
            [self processImage];
                
        }
        else {
            //Display error
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error dialog title") message:NSLocalizedString(@"Photo could not be taken. Please try again with better focus and/or lighting.", @"Error message when failed to take photo") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            NSLog(@"Error taking photo:%@ samplebuffer is empty:%d", error, (imageSampleBuffer == NULL));
        }
        
	 }];
    
    [session stopRunning];
    [captureVideoPreviewLayer removeFromSuperlayer];
    
}

- (IBAction)homeButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)processImage {
    self.customizeTimerLabel.hidden = NO;
    self.timeDisplayLabel.hidden = NO;
    self.mealStepper.hidden = NO;
    self.retakeLabel.hidden = NO;
    self.eatLabel.hidden = NO;
    
    self.cameraIcon.hidden = YES;
    self.instructionLabel.hidden = YES;
    self.mealOrSnackControl.hidden = YES;
    self.mealOrSnackLabel.hidden = YES;
    self.thoughtBubble.hidden = YES;
    self.cameraInstructionLabel.hidden = YES;
    
    if (self.mealOrSnackControl.selectedSegmentIndex == 0) {
        self.mealStepper.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"mealTimer"];
    } else {
        self.mealStepper.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"snackTimer"];
    }
    self.timeDisplayLabel.text = [NSString stringWithFormat:@"%.f minutes", self.mealStepper.value];
    
    UIImage *mask = [UIImage imageNamed:@"cutout"];
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) {
        //Rotate image by 180 degrees if held home button to left
        chosenImage = [chosenImage rotate:UIImageOrientationDown];
    }
    
    // Crop the image with an image mask
    chosenImage = [self maskImage :chosenImage withMask:mask];
    
    UIImage *overlayGraphic = [UIImage imageNamed:@"camera_overlay"];
    cameraOverlay = [[UIImageView alloc] initWithImage:overlayGraphic];
    cameraOverlay.frame = self.view.frame;
    [self.view addSubview:cameraOverlay];
    
    foodImage = [[UIImageView alloc] init];
    foodImage.opaque = NO;
    foodImage.backgroundColor = [UIColor clearColor];
    foodImage.contentMode = UIViewContentModeScaleAspectFit;
    foodImage.image = chosenImage;
    foodImage.frame = self.view.frame;
    [self.view addSubview:foodImage];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (CGImageRef)CopyImageAndAddAlphaChannel :(CGImageRef) sourceImage
{
    CGImageRef retVal = NULL;
    
    size_t width = CGImageGetWidth(sourceImage);
    size_t height = CGImageGetHeight(sourceImage);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL, width, height,
                                                          8, 0, colorSpace, (CGBitmapInfo) kCGImageAlphaPremultipliedFirst);
    
    if (offscreenContext != NULL) {
        CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), sourceImage);
        
        retVal = CGBitmapContextCreateImage(offscreenContext);
    }
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(offscreenContext);
    
    CGImageRelease(retVal);
    
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
    //CGImageRef imageWithAlpha = sourceImage;
    //add alpha channel for images that don’t have one (ie GIF, JPEG, etc…)
    //this however has a computational cost
    
    CGImageRef masked;
    if (CGImageGetAlphaInfo(sourceImage) == kCGImageAlphaNone) {
        CGImageRef imageWithAlpha = [self CopyImageAndAddAlphaChannel :sourceImage];
        CGImageRetain(imageWithAlpha);
        masked = CGImageCreateWithMask(imageWithAlpha, mask);
        CGImageRelease(imageWithAlpha);
    }
    else {
        masked = CGImageCreateWithMask(sourceImage, mask);
    }
    
    CGImageRelease(mask);
    
    UIImage* retImage = [UIImage imageWithCGImage:masked];
    CGImageRelease(masked);
    
    return retImage;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"letsEatSegue"]){
        EatViewController *controller = (EatViewController *)segue.destinationViewController;
        controller.foodImage = chosenImage;
        controller.timeToEat = self.mealStepper.value;
    }
}

@end
