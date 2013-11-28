//
//  KBADashboardControllerViewController.h
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 19.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBAViewController.h"

@interface KBADashboardController : KBAViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
