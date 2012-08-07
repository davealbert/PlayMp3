//
//  AddFileViewController.h
//  PlayMp3
//
//  Created by Dave Albert on 07/08/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFileViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate>{
  NSURLConnection *connection;
  NSNumber *filesize;
  NSMutableData *data;
  UIAlertView *alert;
}

@property (strong, nonatomic) IBOutlet UITextField *url;

- (IBAction)cancel:(id)sender;
- (IBAction)saveAndAdd:(id)sender;

@end
