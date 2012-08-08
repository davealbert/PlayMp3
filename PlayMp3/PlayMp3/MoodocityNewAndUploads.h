//
//  MoodocityNewAndUploads.h
//  PlayMp3
//
//  Created by Dave Albert on 08/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoodocityDevice.h"
#import "NSURLConnection+webdata.h"
#import "NewsViewController.h"

@protocol MoodocityNewAndUploadsDelegate;

@interface MoodocityNewAndUploads : NSObject {
  NSURLConnection_webdata *newConnection;
  NSURLConnection_webdata *postConnection;
  MoodocityDevice *mooDev;
}

@property (assign, nonatomic) id <MoodocityNewAndUploadsDelegate> delegate;
@property (assign, nonatomic) BOOL loading;

- (id)initWithDelegate:(id)delegate;
- (void)getNews;

@end

@protocol MoodocityNewAndUploadsDelegate
- (void)moodocityNewsDidFinishLoading:(NewsViewController *)newsViewController;

@end