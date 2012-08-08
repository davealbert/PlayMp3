//
//  NewsViewController.m
//  moodocity
//
//  Created by Dave Albert on 30/05/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController
@synthesize newsWebView;
@synthesize webData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidAppear:(BOOL)animated {
  [self.newsWebView loadData:webData MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
  [self setNewsWebView:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  [self.newsWebView loadData:webData MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:nil];

  return YES;
}

- (IBAction)closeView:(id)sender {
  [self dismissModalViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  //  Start
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  //  Finish
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
  NSString *str = [NSString stringWithFormat:@"%@",[request URL]];
  if ([str rangeOfString:@"itms"].location != NSNotFound) {
    [[UIApplication sharedApplication] openURL:[request URL]];
    return NO;
  }
	return YES;
}

@end
