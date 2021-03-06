//
//  AddFileViewController.m
//  PlayMp3
//
//  Created by Dave Albert on 07/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import "AddFileViewController.h"

@interface AddFileViewController ()

@end

@implementation AddFileViewController
@synthesize favoriteButton;
@synthesize url;

#pragma mark - View Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

-(void)viewWillDisappear:(BOOL)animated{
  [UIView animateWithDuration:0.5f animations:^{
    [[self favoriteButton] setAlpha:0.0f];
  }];
  [[self favoriteButton] setHidden:YES];
}
- (void)viewWillAppear:(BOOL)animated {
  moodGetUrl = [[MoodocityGetURL alloc] initWithDelegate:self];  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
  [self setUrl:nil];
  [self setFavoriteButton:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - User Interaction Methods

- (IBAction)cancel:(id)sender {
  [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)saveAndAdd:(id)sender {
  [url resignFirstResponder];
  if (![[url text] hasPrefix:@"http://"]) {
    [url setText:[NSString stringWithFormat:@"http://%@",[url text]]];
  }
  alert = [[UIAlertView alloc] initWithTitle:@"Downloading" message:@"please wait..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
  [alert show];
  
  [self performSelector:@selector(downloadFile) withObject:self afterDelay:1.0f];
}

- (IBAction)showFavorites:(id)sender {
}

#pragma mark - supporting Methods

- (void)downloadFile {
  NSURL  *myurl = [NSURL URLWithString:[url text]];
  
  NSURLRequest *theRequest = [NSURLRequest requestWithURL:myurl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10.0];
  connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
  connection = nil;
}

#pragma mark - Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  //  filesize = [NSNumber numberWithUnsignedInteger:[response expectedContentLength]];
}

- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error {
  [alert dismissWithClickedButtonIndex:0 animated:NO];
  [[[UIAlertView alloc]initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)recievedData {
  if (data==nil) {
		data =	[[NSMutableData alloc] initWithCapacity:2048];
  }
  [data appendData:recievedData];
  //  NSNumber *resourceLength = [NSNumber numberWithUnsignedInteger:[data length]]; //MAGIC
  //  float progress = [resourceLength floatValue] / [filesize floatValue];
  //  NSLog(@"%f",progress);
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
  if (data) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray *split = [[url text] componentsSeparatedByString:@"/"];
    NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,[split objectAtIndex:([split count] - 1)]];
    
    [data writeToFile:filePath atomically:YES];
    
    connection=nil;
    data=nil;
  }
  [alert dismissWithClickedButtonIndex:0 animated:YES];
  [self dismissModalViewControllerAnimated:YES];
}

- (void)alertViewCancel:(UIAlertView *)alertView {
  [connection cancel];  
}

- (void)moodocityGetUrlDidFinish:(MoodocityGetURL *)moodocityUrl withConnection:(NSURLConnection_webdata *)conn{
  if (![conn webdata]) {
    // Just checking for connection
    if ([moodGetUrl isOnline]) {
      [[self favoriteButton] setAlpha:0.0f];
      [[self favoriteButton] setHidden:NO];
      [UIView animateWithDuration:0.5f animations:^{
        [[self favoriteButton] setAlpha:1.0f];
      }];
    } else {
      [[self favoriteButton] setHidden:YES];
    }
  }
}

@end
