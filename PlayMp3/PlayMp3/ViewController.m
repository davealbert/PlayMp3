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
@synthesize scroll;
@synthesize fileName;
@synthesize plauPauseButton;
@synthesize scrubber;
@synthesize time;
@synthesize hour;
@synthesize minute;
@synthesize second;

- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  playList = [[PlayList alloc] init];
  [scroll setContentSize:CGSizeMake(0.0f, scroll.frame.size.height * 1.5f)];
}

- (void)viewDidUnload {
  [self setFileName:nil];
  [self setPlauPauseButton:nil];
  [self setScrubber:nil];
  [self setTime:nil];
  [self setScroll:nil];
  [self setHour:nil];
  [self setMinute:nil];
  [self setSecond:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - User Interaction Methods

- (IBAction)selectFile:(id)sender {
  [self hideKb];
  if (!fileSelectController) {
    fileSelectController = [[FileSelectViewController alloc] initWithNibName:@"FileSelectViewController" bundle:nil];
    [fileSelectController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [fileSelectController setReturnDelegate:self];
  }
  [self presentModalViewController:fileSelectController animated:YES];
}

- (IBAction)playPause:(id)sender {
  [self hideKb];
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
  [self hideKb];
  [audioPlayer setCurrentTime:([audioPlayer duration] * sender.value)];
}

- (IBAction)seek:(id)sender {
  [self hideKb];
  if ([hour.text intValue] + [minute.text intValue] + [second.text intValue] +0 > 0) {
    [audioPlayer setCurrentTime:([hour.text intValue] * 3600) + ([minute.text intValue] * 60) + ([second.text intValue])];
  }
}

- (IBAction)selectPlayList:(id)sender {
  [playList setUsingThisPlaylist:YES];
  [self playAudio:[playList currentSongInPLaylist]];
}

- (IBAction)previousSong:(id)sender {
  if ([playList usingThisPlaylist]) {
    [self playAudio:[playList previousSongInPLaylist]];
  }
}

- (IBAction)nextSong:(id)sender {
  if ([playList usingThisPlaylist]) {
    [self playAudio:[playList nextSongInPLaylist]];
  }
}

#pragma mark - Supporting Methods

- (void)hideKb {
  [second becomeFirstResponder];
  [second resignFirstResponder];
}

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

-(void)playAudio:(NSURL *)url {
  NSError *error;
  audioPlayer  = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
  [audioPlayer setDelegate:self];
  if (audioPlayer == nil)
    [[[UIAlertView alloc]initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
  else {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    if (error) {
      [[[UIAlertView alloc]initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }

    if ([playList usingThisPlaylist]) {
      [audioPlayer setNumberOfLoops:0];
    } else {
      [audioPlayer setNumberOfLoops:-1];
    }


    playTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(playTimerFire)
                                               userInfo:nil
                                                repeats:YES];
    [audioPlayer play];
    if ([playList usingThisPlaylist]) {
      [fileName setText:[playList nameOfSongPlaying]];
    }
    [plauPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
  }
}

#pragma mark - Delegate Methods

- (void)fileSelectDidFinish:(FileSelectViewController *)fsvc withShortName:(NSString *)shortName withLongName:(NSString *)longName {
  [playList setUsingThisPlaylist:NO];
  audioPlayer = nil;
  [playTimer invalidate];
  playTimer = nil;
  [fileName setText:shortName];
  NSURL *url = [NSURL fileURLWithPath:longName];
  [self playAudio:url];
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
  if ([playList usingThisPlaylist]) {
    [self playAudio:[playList nextSongInPLaylist]];
  }
}

@end
