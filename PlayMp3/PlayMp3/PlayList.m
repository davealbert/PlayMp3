//
//  PlayList.m
//  PlayMp3
//
//  Created by Dave Albert on 16/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import "PlayList.h"

@implementation PlayList

@synthesize usingThisPlaylist;

-(id)init {
  self = [super init];
  if (self) {
    playList = [self importableFiles];
    playlistPosition = 0;
  }
  return self;
}


- (NSURL *)currentSongInPLaylist {
  return [self songAtPosition:playlistPosition];  
}

- (NSURL *)nextSongInPLaylist{
  if (playlistPosition < [playList count] - 1) {
    playlistPosition++;
  } else {
    playlistPosition = 0;
  }
  return [self songAtPosition:playlistPosition];
}

- (NSURL *)previousSongInPLaylist{
  if (playlistPosition > 0) {
    playlistPosition--;
  } else {
    playlistPosition = [playList count] - 1;
  }
  return [self songAtPosition:playlistPosition];
}

- (NSURL *)songAtPosition:(NSInteger)pos {
  return [NSURL fileURLWithPath:[playList objectAtIndex:pos]];
}
- (NSString *)nameOfSongPlaying {
  return [self shortName:[playList objectAtIndex:playlistPosition]];
}

- (NSString *)shortName:(NSString *)longName{
  NSArray *split = [longName componentsSeparatedByString:@"/"];
  return [split objectAtIndex:([split count] - 1)];
}

- (NSMutableArray *)importableFiles {
  NSMutableArray *retval = [NSMutableArray array];
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *publicDocumentsDir = [paths objectAtIndex:0];
  
  NSError *error;
  NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:publicDocumentsDir error:&error];
  if (files == nil) {
    [[[UIAlertView alloc]initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    return retval;
  }
  
  for (NSString *file in files) {
    if ([file.pathExtension compare:@"mp3" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
      
      if ([file hasPrefix:@"lbCD"]) {  // TODO: Find a way to create prefix play lists?
        NSString *fullPath = [publicDocumentsDir stringByAppendingPathComponent:file];
        [retval addObject:fullPath];        
      }
    }
  }
  
  return retval;
}
@end
