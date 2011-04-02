//
//  PRPSplashScreenViewController.m
//  BasicSplashScreen
//
//  Created by Matt Drance on 10/1/10.
//  Copyright 2010 Bookhouse Software, LLC. All rights reserved.
//

#import "PRPSplashScreenViewController.h"
#import <QuartzCore/QuartzCore.h>

NSString *const PRPSplashScreenFadeAnimation = @"PRPSplashScreenFadeAnimation";

@implementation PRPSplashScreenViewController

@synthesize splashImage;
@synthesize delegate;

// START:ShowInWindow
- (void)showInWindow:(UIWindow *)window {
    [window addSubview:self.view];        
}
// END:ShowInWindow


// START:ViewDidLoad
- (void)viewDidLoad {
    self.view.layer.contents = (id)self.splashImage.CGImage;
    self.view.contentMode = UIViewContentModeBottom;
}
// END:ViewDidLoad

// START:SplashImage
- (UIImage *)splashImage {
    if (splashImage == nil) {
        NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"Default" 
                                                                ofType:@"png"];
        splashImage = [[UIImage alloc] initWithContentsOfFile:defaultPath];
    }
    return splashImage;
}
// END:SplashImage

// START:Presentation
- (void)viewDidAppear:(BOOL)animated {
    if ([self.delegate respondsToSelector:@selector(splashScreenDidAppear:)]) {
        [self.delegate splashScreenDidAppear:self];
    }    
    if ([self.delegate respondsToSelector:@selector(splashScreenWillDisappear:)]) {
        [self.delegate splashScreenWillDisappear:self];
    }
    [self performTransition];
}

- (void)performTransition {
    [UIView beginAnimations:PRPSplashScreenFadeAnimation context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelegate:self];
    SEL stopSelector = @selector(splashFadeDidStop:finished:context:);
    [UIView setAnimationDidStopSelector:stopSelector];
    self.view.alpha = 0;
    [UIView commitAnimations];
}

- (void)splashFadeDidStop:(NSString *)animationID
                 finished:(BOOL)finished
                  context:(void *)context {
    [self.view removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(splashScreenDidDisappear:)]) {
        [self.delegate splashScreenDidDisappear:self];
    }
}
// END:Presentation

- (void)dealloc {
    [splashImage release], splashImage = nil;
    [super dealloc];
}


@end
