//
//  ViewController.m
//  PlayMp3
//
//  Created by Dave Albert on 07/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View Lifecycle
@synthesize fileName;

- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload {
  [self setFileName:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - User Interaction Methods

- (IBAction)selectFile:(id)sender {
  if (!fileSelectController) {
    fileSelectController = [[FileSelectViewController alloc] initWithNibName:@"FileSelectViewController" bundle:nil];
    [fileSelectController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [fileSelectController setReturnDelegate:self];
  }
  [self presentModalViewController:fileSelectController animated:YES];
}

- (IBAction)playPause:(id)sender {
}

#pragma mark - Delegate Methods

- (void)fileSelectDidFinish:(FileSelectViewController *)fsvc withShortName:(NSString *)shortName withLongName:(NSString *)longName {
  NSLog(@"L: %@ , S: %@",longName,shortName);
  [fileName setText:shortName];
}

@end
