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

- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)selectFile:(id)sender {
  if (!fileSelectController) {
    NSLog(@"init fileSelectController");
    fileSelectController = [[FileSelectViewController alloc] initWithNibName:@"FileSelectViewController" bundle:nil];
    [fileSelectController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
  }
  [self presentModalViewController:fileSelectController animated:YES];
}

- (IBAction)playPause:(id)sender {
}

@end
