//
//  FileSelectViewController.m
//  PlayMp3
//
//  Created by Dave Albert on 07/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import "FileSelectViewController.h"

@interface FileSelectViewController ()

@end

@implementation FileSelectViewController

@synthesize fileSelector;
@synthesize returnDelegate;

#pragma mark - View Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  [fileSelector setDelegate:fileSelector];
  [fileSelector setDataSource:fileSelector];  
  [fileSelector setControllerDelegate:self];
}

- (void)viewDidUnload {
  [self setFileSelector:nil];
  [self setReturnDelegate:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - User Interaction Methods

- (IBAction)cancelFileSelection:(id)sender {
  [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Delegate Methods

- (void)fileSelectTableViewSelectionMade:(FileSelectTableView *)fstv withShortName:(NSString *)shortName withLongName:(NSString *)longName {
  [[self returnDelegate] fileSelectDidFinish:self withShortName:shortName withLongName:longName];
  [self cancelFileSelection:nil];
}

@end
