//
//  MoodocityNewAndUploads.m
//  PlayMp3
//
//  Created by Dave Albert on 08/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import "MoodocityNewAndUploads.h"

@implementation MoodocityNewAndUploads

@synthesize delegate = _delegate;
@synthesize loading  = _loading;

- (id)init {
  [self setLoading:YES];
  self = [super init];
  if (self) {
    if (!mooDev) {
      mooDev = [[MoodocityDevice alloc] init];
    }
  }
  
  [self getNews];
  return self;
}

- (id)initWithDelegate:(id)delegate{
  [self setLoading:YES];
  self = [super init];
  if (self) {
    if (!mooDev) {
      mooDev = [[MoodocityDevice alloc] init];
    }
    [self setLoading:YES];
    self.delegate = delegate;  
  }
  
  [self getNews];
  return self;
}

- (void)getNews {
  NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://apps.moodocity.com/news.php?app=PlayMp3&DeviceID=%@&Count=%d",[mooDev deviceId],[mooDev getAppLaunchCountAndInc]]];
  NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
  newConnection = [[NSURLConnection_webdata alloc] initWithRequest:request delegate:self startImmediately:YES];
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
  NSLog(@"error");
}

-(void)connectionDidFinishLoading:(NSURLConnection_webdata *)connection {
  NSString* newStr = [[NSString alloc] initWithData:connection.webdata encoding:NSUTF8StringEncoding];
  
  if ([newStr isEqualToString:@".\n"]) {
    // No news
  } else {
    NewsViewController *news;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      news = [[NewsViewController alloc] initWithNibName:@"NewsViewController-iPhone" bundle:nil];
    } else {
      news = [[NewsViewController alloc] initWithNibName:@"NewsViewController-iPad" bundle:nil];
    }
    
    news.webData = connection.webdata;
    // Don't forget to  [#import NewsViewController.h] into the delegate
    // Then in the delegate : [self (.viewController) presentModalViewController:newsViewController animated:YES];
  
    [self.delegate moodocityNewsDidFinishLoading:news];
  }
    [self setLoading:NO];
}

@end
