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
@synthesize plauPauseButton;
@synthesize scrubber;
@synthesize time;

- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload {
  [self setFileName:nil];
  [self setPlauPauseButton:nil];
  [self setScrubber:nil];
  [self setTime:nil];
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
  if ([audioPlayer isPlaying]) {
    [audioPlayer pause];
  } else {
    [audioPlayer play];
  }

  if ([audioPlayer isPlaying]) {
    [plauPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
  } else {
    [plauPauseButton setTitle:@"Play" forState:UIControlStateNormal];
  }
}

- (IBAction)scrubbing:(UISlider *)sender {
  [audioPlayer setCurrentTime:([audioPlayer duration] * sender.value)];
}

#pragma mark - Supporting Methods

- (void)playTimerFire {
  if ([audioPlayer isPlaying]) {
    long currentPlaybackTime = [audioPlayer currentTime];
    int currentHours = (currentPlaybackTime / 3600);
    int currentMinutes = ((currentPlaybackTime / 60) - currentHours*60);
    int currentSeconds = (currentPlaybackTime % 60);
    [time setText:[NSString stringWithFormat:@"%i:%02d:%02d", currentHours, currentMinutes, currentSeconds]];
    [scrubber setValue:([audioPlayer currentTime]/[audioPlayer duration])];
  }
}

#pragma mark - Delegate Methods

- (void)fileSelectDidFinish:(FileSelectViewController *)fsvc withShortName:(NSString *)shortName withLongName:(NSString *)longName {
  audioPlayer = nil;
  [playTimer invalidate];
  playTimer = nil;
  [fileName setText:shortName];
  NSURL *url = [NSURL fileURLWithPath:longName];

  NSError *error;
  audioPlayer  = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];


  if (audioPlayer == nil)
    NSLog(@"%@",[error description]);
  else {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    NSLog(@"%@",[error description]);
    [audioPlayer setNumberOfLoops:-1];

    playTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(playTimerFire)
                                               userInfo:nil
                                                repeats:YES];
    [audioPlayer play];
    [plauPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
  }
}

@end
