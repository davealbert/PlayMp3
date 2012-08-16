//
//  MoodocityGetURL.m
//  PlayMp3
//
//  Created by Dave Albert on 08/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import "MoodocityGetURL.h"

@implementation MoodocityGetURL
@synthesize isOnline = _isOnline;
@synthesize delegate = _delegate;

- (id)initWithDelegate:(id)delegate {
  self = [super init];
  if (self) {
    self.delegate = delegate;
    [self checkOnline];
  }
  return self;
}

- (void)checkOnline {
  NSURL* url = [[NSURL alloc] initWithString:@"http://apps.moodocity.com/dot.html"];
  NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
  onlineCheck = [[NSURLConnection_webdata alloc] initWithRequest:request delegate:self startImmediately:YES];
  if (!onlineCheck) {
    NSLog(@"checkOnline -- MoodocityGetURL.m : failed"); // Should never happen.
  }
}

- (void)getUrl:(NSString *)url {
  NSURL* theUrl = [[NSURL alloc] initWithString:url];
  NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
  NSURLConnection_webdata *getUrlConnection = [[NSURLConnection_webdata alloc] initWithRequest:request delegate:self startImmediately:YES];
  if (!getUrlConnection) {
    NSLog(@"getUrl -- MoodocityGetURL.m : failed"); // Should never happen.
  }
}
#pragma mark - Delegate Methods

-(void)connection:(NSURLConnection_webdata*)connection didReceiveResponse:(NSURLResponse*)response {
  connection.webdata = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection_webdata*)connection didReceiveData:(NSData*)data {
  [connection.webdata appendData:data];
}

-(void)connection:(NSURLConnection_webdata*)connection didFailWithError:(NSError*)error {
  // Handle the error properly
  [self setIsOnline:NO];
  [[self delegate]moodocityGetUrlDidFinish:self withConnection:connection];
}

-(void)connectionDidFinishLoading:(NSURLConnection_webdata *)connection {
  if ([connection isEqual:onlineCheck]) {
    NSString* newStr = [[NSString alloc] initWithData:connection.webdata encoding:NSUTF8StringEncoding];
    if ([newStr hasPrefix:@"."]) {
      // Connection Active
      connection.webdata = nil;
      [self setIsOnline:YES];      
    } else {
      NSLog(@"'%@'",newStr);
    }
  } 
  [[self delegate]moodocityGetUrlDidFinish:self withConnection:connection];
}

@end
