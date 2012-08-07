//
//  FileSelectViewController.h
//  PlayMp3
//
//  Created by Dave Albert on 07/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileSelectTableView.h"
#import "AddFileViewController.h"


@protocol FileSelectReturnDelegate;

@interface FileSelectViewController : UIViewController <FileSelectControllerDelegate> {
  AddFileViewController *addFileController;
}

@property (strong, nonatomic) IBOutlet FileSelectTableView *fileSelector;
@property (assign, nonatomic) id <FileSelectReturnDelegate> returnDelegate;

- (IBAction)cancelFileSelection:(id)sender;
- (IBAction)addFileFromUrl:(id)sender;

@end

@protocol FileSelectReturnDelegate
- (void)fileSelectDidFinish:(FileSelectViewController *)fsvc withShortName:(NSString *)shortName withLongName:(NSString *)longName ;
@end