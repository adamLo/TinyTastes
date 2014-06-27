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

@interface PhotoViewController ()

@end

@implementation PhotoViewController

AVCaptureStillImageOutput *stillImageOutput;
OverlayView *overlay;
AVCaptureSession *session;
AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

static CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};


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
    [mealOrSnackControl setFrame:CGRectMake(300, 300, 300, 300)];
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.83 alpha:1.0];
    [self.instructionLabel.titleLabel setFont: [UIFont fontWithName:@"KBZipaDeeDooDah" size:60]];
    self.instructionLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    [eatLabel.titleLabel setFont: [UIFont fontWithName:@"KBZipaDeeDooDah" size:35]];
    [retakeLabel.titleLabel setFont: [UIFont fontWithName:@"KBZipaDeeDooDah" size:65]];
    customizeTimerLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:60];
    timeDisplayLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    mealOrSnackLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    
    mealStepper.minimumValue = 1;
    mealStepper.maximumValue = 60;
    mealStepper.wraps = YES;
    mealStepper.autorepeat = YES;
    mealStepper.continuous = YES;
    
    customizeTimerLabel.hidden = YES;
    timeDisplayLabel.hidden = YES;
    mealStepper.hidden = YES;
    retakeLabel.hidden = YES;
    eatLabel.hidden = YES;
    
    //Hide instruction if this is not the first time the app was launched
    //if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedEatScreenOnce"]) {
        //thoughtBubble.hidden = YES;
        //cameraInstructionLabel.hidden = YES
    //}

    //Change font of segment control
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont fontWithName:@"KBZipaDeeDooDah" size:30], NSFontAttributeName,
                                [UIColor grayColor], NSForegroundColorAttributeName, nil];
    [mealOrSnackControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary *highlightedAttributes = [NSDictionary
                                           dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
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
        //chosenImage = [UIImage imageNamed:@"frenchfries.jpg"];
        chosenImage = [UIImage imageNamed:@"IMG_0609.JPG"];
        //chosenImage = [UIImage imageNamed:@"mcdonalds-filet-o-fish.png"];
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
    customizeTimerLabel.hidden = NO;
    timeDisplayLabel.hidden = NO;
    mealStepper.hidden = NO;
    retakeLabel.hidden = NO;
    eatLabel.hidden = NO;
    
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
    
    UIImage *mask = [UIImage imageNamed:@"cutout.jpg"];
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) {
        //Rotate image by 180 degrees if held home button to left
        chosenImage = [chosenImage rotate:UIImageOrientationDown];
    }
    
    // Crop the image with an image mask
    chosenImage = [self maskImage :chosenImage withMask:mask];
    
    UIImage *overlayGraphic = [UIImage imageNamed:@"camera_overlay.jpg"];
    UIImageView *overlayGraphicView = [[UIImageView alloc] initWithImage:overlayGraphic];
    overlayGraphicView.frame = CGRectMake(0, 0, overlayGraphic.size.width, overlayGraphic.size.height);
    [self.view addSubview:overlayGraphicView];
    
    UIImageView *foodImageView = [[UIImageView alloc] init];
    foodImageView.opaque = NO;
    foodImageView.backgroundColor = [UIColor clearColor];
    foodImageView.contentMode = UIViewContentModeScaleAspectFit;
    foodImageView.image = chosenImage;
    
    foodImageView.frame = CGRectMake(0, 0, 1024, 768);
    [self.view addSubview:foodImageView];
    
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
        controller.timeToEat = mealStepper.value;
    }
}

@end
