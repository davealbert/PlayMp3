//
//  MoodocityDeviceID.h
//  PlayMp3
//
//  Created by Dave Albert on 08/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoodocityDevice : NSObject

@property (strong, nonatomic) NSString *deviceId;

- (int)getAppLaunchCount;
- (int)getAppLaunchCountAndInc;

@end
