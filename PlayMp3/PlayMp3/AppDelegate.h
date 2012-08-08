//
//  AppDelegate.h
//  PlayMp3
//
//  Created by Dave Albert on 07/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoodocityNewAndUploads.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, MoodocityNewAndUploadsDelegate> {
  MoodocityNewAndUploads *news;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
