//
//  MoodocityGetURL.h
//  PlayMp3
//
//  Created by Dave Albert on 08/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSURLConnection+webdata.h"

@protocol MoodocityGetURLDelegate;

@interface MoodocityGetURL : NSObject {
  NSURLConnection_webdata *onlineCheck;
}

@property (assign, nonatomic) BOOL isOnline;
@property (assign, nonatomic) id <MoodocityGetURLDelegate> delegate;

- (id)initWithDelegate:(id)delegate;
- (void)getUrl:(NSString *)url; // Returned in delegate method

@end

@protocol MoodocityGetURLDelegate
-(void)moodocityGetUrlDidFinish:(MoodocityGetURL *)moodocityUrl withConnection:(NSURLConnection_webdata *)conn;
@end