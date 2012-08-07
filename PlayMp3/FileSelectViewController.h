//
//  FileSelectViewController.h
//  PlayMp3
//
//  Created by Dave Albert on 07/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileSelectTableView.h"

@interface FileSelectViewController : UIViewController

@property (strong, nonatomic) IBOutlet FileSelectTableView *fileSelector;

- (IBAction)cancelFileSelection:(id)sender;

@end
