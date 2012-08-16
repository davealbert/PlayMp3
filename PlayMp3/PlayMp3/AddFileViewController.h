//
//  AddFileViewController.h
//  PlayMp3
//
//  Created by Dave Albert on 07/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoodocityGetURL.h"

@interface AddFileViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate, MoodocityGetURLDelegate>{
  NSURLConnection *connection;
  NSNumber *filesize;
  NSMutableData *data;
  UIAlertView *alert;
  MoodocityGetURL *moodGetUrl;
}

@property (strong, nonatomic) IBOutlet UITextField *url;
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;

- (IBAction)cancel:(id)sender;
- (IBAction)saveAndAdd:(id)sender;
- (IBAction)showFavorites:(id)sender;


@end
