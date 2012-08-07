//
//  ViewController.h
//  PlayMp3
//
//  Created by Dave Albert on 07/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileSelectViewController.h"

@interface ViewController : UIViewController <FileSelectReturnDelegate>{
  FileSelectViewController *fileSelectController;
}

@property (strong, nonatomic) IBOutlet UILabel *fileName;

- (IBAction)selectFile:(id)sender;
- (IBAction)playPause:(id)sender;

@end
