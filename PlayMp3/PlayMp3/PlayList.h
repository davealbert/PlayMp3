//
//  PlayList.h
//  PlayMp3
//
//  Created by Dave Albert on 16/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayList : NSObject {
  NSMutableArray *playList;
  NSInteger playlistPosition;
}

@property (nonatomic, assign) BOOL usingThisPlaylist;

- (NSURL *)currentSongInPLaylist;
- (NSURL *)nextSongInPLaylist;
- (NSURL *)previousSongInPLaylist;
- (NSString *)nameOfSongPlaying;
@end
