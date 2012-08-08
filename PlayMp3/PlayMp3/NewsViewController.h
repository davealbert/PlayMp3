//
//  NewsViewController.h
//  moodocity
//
//  Created by Dave Albert on 30/05/2012.
//  Copyright (c) 2012 Publicis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *newsWebView;
@property (strong, nonatomic) NSData *webData;

@end
