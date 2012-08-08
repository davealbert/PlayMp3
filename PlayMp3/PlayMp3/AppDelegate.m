//
//  AppDelegate.m
//  PlayMp3
//
//  Created by Dave Albert on 07/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
  self.window.rootViewController = self.viewController;
  [self.window makeKeyAndVisible];

  news = [[MoodocityNewAndUploads alloc] initWithDelegate:self];
  return YES;
}

-(void)applicationWillEnterForeground:(UIApplication *)application {
  [news getNews];
}

-(void)moodocityNewsDidFinishLoading:(NewsViewController *)newsViewController {
  [self.viewController presentModalViewController:newsViewController animated:YES];
}

@end
