//
//  ViewController.h
//  PlayMp3
//
//  Created by Dave Albert on 07/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "FileSelectViewController.h"

@interface ViewController : UIViewController <FileSelectReturnDelegate,UITextFieldDelegate>{
  FileSelectViewController *fileSelectController;
  AVAudioPlayer *audioPlayer;
  NSTimer *playTimer;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UILabel *fileName;
@property (strong, nonatomic) IBOutlet UIButton *plauPauseButton;

@property (strong, nonatomic) IBOutlet UISlider *scrubber;
@property (strong, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) IBOutlet UITextField *hour;
@property (strong, nonatomic) IBOutlet UITextField *minute;
@property (strong, nonatomic) IBOutlet UITextField *second;

- (IBAction)selectFile:(id)sender;
- (IBAction)playPause:(id)sender;
- (IBAction)scrubbing:(UISlider *)sender;
- (IBAction)seek:(id)sender;

@end
