//
//  ViewController.h
//  PlayMp3
//
//  Created by Dave Albert on 07/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileSelectViewController.h"

@interface ViewController : UIViewController {
  FileSelectViewController *fileSelectController;
}

- (IBAction)selectFile:(id)sender;
- (IBAction)playPause:(id)sender;

@end
