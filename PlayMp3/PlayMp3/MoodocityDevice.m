//
//  MoodocityDeviceID.m
//  PlayMp3
//
//  Created by Dave Albert on 08/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import "MoodocityDevice.h"

@implementation MoodocityDevice

@synthesize deviceId = _deviceId;

- (id)init {
  self = [super init];
  if (self) {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [self setDeviceId:[[prefs stringForKey:@"moodocityDeviceID"] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    if (![self deviceId]) {
      [self setDeviceId:[self genRandStringLength:20]];
      [prefs setObject:[self deviceId] forKey:@"moodocityDeviceID"];
      [prefs synchronize];
    }
  }
  return self;
}

-(NSString *) genRandStringLength:(int)len {
  NSString *letters = @"ABCDEF0123456789";
  NSMutableString *randomString = [NSMutableString stringWithCapacity: len];

  for (int i=0; i<len; i++) {
    [randomString appendFormat: @"%c", [letters characterAtIndex: arc4random() %[letters length]]];
  }

  return randomString;
}

- (int)getAppLaunchCount{
  NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  int cnt = [prefs integerForKey:@"moodocityCount"];
  return cnt;
}

- (int)getAppLaunchCountAndInc{
  NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  int cnt = [prefs integerForKey:@"moodocityCount"];
  cnt ++;
  
  [prefs setInteger:cnt forKey:@"moodocityCount"];
  [prefs synchronize];
  return cnt;
}

@end
