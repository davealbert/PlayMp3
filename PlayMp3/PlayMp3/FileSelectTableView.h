//
//  FileSelectTableView.h
//  PlayMp3
//
//  Created by Dave Albert on 07/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FileSelectControllerDelegate;

@interface FileSelectTableView : UITableView <UITableViewDataSource, UITableViewDelegate> {
  NSMutableArray *listOfFiles;
}

@property (assign, nonatomic) id <FileSelectControllerDelegate> controllerDelegate;

- (void)refreshData;

@end


@protocol FileSelectControllerDelegate
- (void)fileSelectTableViewSelectionMade:(FileSelectTableView *)fstv withShortName:(NSString *)shortName withLongName:(NSString *)longName;
@end