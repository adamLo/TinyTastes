//
//  StoryPageController.m
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.05..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import "StoryPageController.h"
#import <AVFoundation/AVFoundation.h>

@interface StoryPageController () {
    
    NSTimer *pageDelayTimer; //Delay timer to defer narration and animation
    NSMutableArray *audioPlayers; //Array of audio players for sound files on page
    
    UITapGestureRecognizer *tapGestureRecognizer; //Tap gesture recognizer for the page
    
}

@end

@implementation StoryPageController

NSTimeInterval const kStoryDelayAfterAppear = 0.33; //Postpone animation after page appeared


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Initialize audio players
    audioPlayers = [[NSMutableArray alloc] init];
    
    //Initializer tap gesture recognizer to detect link taps on page
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageTappedWithRecognizer:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.view.userInteractionEnabled = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    
    //Schedule narration and animation start
    pageDelayTimer = [NSTimer scheduledTimerWithTimeInterval:kStoryDelayAfterAppear target:self selector:@selector(pageDelayTimerFired:) userInfo:nil repeats:NO];
    
    //Enable tapping
    tapGestureRecognizer.enabled = YES;
    
}

- (void)pageDelayTimerFired:(NSTimer*)timer {
    
    //Start playing narration
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"storyNarration"] == YES) {
        for (AVAudioPlayer *audioPlayer in audioPlayers) {
            [audioPlayer setCurrentTime:0.0];
            [audioPlayer play];
        }
    }
    
    //Start animations
    for (id subView in self.view.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView*)subView;
            if (imageView.animationImages.count) {
                if (imageView.animationRepeatCount > 0) {
                    //Set default image of animation sequence to last frame if animation not continous
                    imageView.image = [imageView.animationImages lastObject];
                }
                [imageView startAnimating];
            }
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    //Cancel timer if not yet fired
    [pageDelayTimer invalidate];
    pageDelayTimer = nil;
    
    //Stop sounds
    for (AVAudioPlayer *audioPlayer in audioPlayers) {
        [audioPlayer stop];
    }
    
    //Disable taps
    tapGestureRecognizer.enabled = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    //Stop all animations
    for (id subview in self.view.subviews) {
        if ([subview respondsToSelector:@selector(stopAnimating)]) {
            //This is an imageview
            [subview performSelector:@selector(stopAnimating) withObject:nil];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadStoryPage:(NSDictionary *)storyPage {

    //Assign data
    self.pageData = storyPage;
    
    //Build page
    [self buildPageImages];
    
    //Load sounds
    [self buildSoundPlayers];

}

#pragma mark - Images

- (UIImageView*)imageViewFromDictionary:(NSDictionary*)imageDict {

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([[imageDict objectForKey:kStoryDictionaryKeyX] floatValue], [[imageDict objectForKey:kStoryDictionaryKeyY]floatValue], [[imageDict objectForKey:kStoryDictionaryKeyW] floatValue], [[imageDict objectForKey:kStoryDictionaryKeyH] floatValue])];
    imageView.image = [UIImage imageNamed:[imageDict objectForKey:kStoryDictionaryKeyPath]];
    
    return imageView;
    
}

/**
 *  Constructs page views
 */
- (void)buildPageImages {
    
    //Add images
    if ([[self.pageData objectForKey:kStoryDictionaryKeyImage] isKindOfClass:[NSDictionary class]]) {
        //Single image
        [self.view addSubview:[self imageViewFromDictionary:[self.pageData objectForKey:kStoryDictionaryKeyImage]]];
    }
    else if ([[self.pageData objectForKey:kStoryDictionaryKeyImage] isKindOfClass:[NSArray class]]) {
        for (NSDictionary *imageDict in [self.pageData objectForKey:kStoryDictionaryKeyImage]) {
            //Multiple images
            [self.view addSubview:[self imageViewFromDictionary:imageDict]];
        }
    }
    
}

#pragma mark - Sounds

/**
 *  Construct an Audio player from the dictionary
 *
 *  @param audioDict Dictionary describing sound
 *
 *  @return Audio player
 */
- (AVAudioPlayer*)audioPlayerFromDictionary:(NSDictionary*)audioDict {
    
    //Get file
    NSString *path = [[NSBundle mainBundle] pathForResource:[audioDict objectForKey:kStoryDictionaryKeyPath] ofType:[audioDict objectForKey:kStoryDictionaryKeyType]];
    
    if (path) {
        //Load sound data
        NSData *soundData = [NSData dataWithContentsOfFile:path];
        
        if (soundData) {
            //Construct player
            NSError *error = nil;
            AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:soundData error:&error];
            
            if (!error) {
                return player;
            }
            else {
                NSLog(@"Failed to constructg audio player for sound dict %@ error: %@", audioDict, error);
            }
        }
    }
    
    return nil;
}

- (void)buildSoundPlayers {
    
    if ([[self.pageData objectForKey:kStoryDictionaryKeySound] isKindOfClass:[NSDictionary class]]) {
        AVAudioPlayer *player = [self audioPlayerFromDictionary:[self.pageData objectForKey:kStoryDictionaryKeySound]];
        if (player) {
            [audioPlayers addObject:player];
        }
    }
    else if ([[self.pageData objectForKey:kStoryDictionaryKeySound] isKindOfClass:[NSArray class]]) {
        for (NSDictionary *audioDict in [self.pageData objectForKey:kStoryDictionaryKeySound]) {
            AVAudioPlayer *player = [self audioPlayerFromDictionary:audioDict];
            if (player) {
                [audioPlayers addObject:player];
            }
        }
    }
    
}

#pragma mark - Tap gesture

- (void)pageTappedWithRecognizer:(UITapGestureRecognizer*)recognizer {
    NSLog(@"Tapped page");
}

@end
