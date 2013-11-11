//
//  OverlayView.m
//  Tiny Tastes
//
//  Created by guest user on 10/27/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "OverlayView.h"

@implementation OverlayView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
		// Clear the background of the overlay:
		self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];
		
		// Load the image to show in the overlay:
		UIImage *overlayGraphic = [UIImage imageNamed:@"camera_overlay.jpg"];
		UIImageView *overlayGraphicView = [[UIImageView alloc] initWithImage:overlayGraphic];
		overlayGraphicView.frame = CGRectMake(280, 180, overlayGraphic.size.width, overlayGraphic.size.height);
		[self addSubview:overlayGraphicView];


    }
    return self;
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.picker takePicture];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
