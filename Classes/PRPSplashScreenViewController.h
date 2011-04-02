//
//  PRPSplashScreenViewController.h
//  FoodReminder
//
//  Created by Oscar Del Ben on 4/2/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PRPSplashScreenDelegate;

@interface PRPSplashScreenViewController : UIViewController {
    
}

@property (nonatomic, retain) UIImage *splashImage;
@property (nonatomic, retain) id delegate;

- (void)showInWindow:(UIWindow *)window;
- (void)performTransition;

@end

@protocol PRPSplashScreenDelegate <NSObject>

@optional
- (void)splashScreenDidAppear:(PRPSplashScreenViewController *)splashScreen;
- (void)splashScreenWillDisappear:(PRPSplashScreenViewController *)splashScreen;
- (void)splashScreenDidDisappear:(PRPSplashScreenViewController *)splashScreen;

@end