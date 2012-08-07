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

@interface ViewController : UIViewController <FileSelectReturnDelegate>{
  FileSelectViewController *fileSelectController;
  AVAudioPlayer *audioPlayer;
}

@property (strong, nonatomic) IBOutlet UILabel *fileName;
@property (strong, nonatomic) IBOutlet UIButton *plauPauseButton;

- (IBAction)selectFile:(id)sender;
- (IBAction)playPause:(id)sender;

@end
