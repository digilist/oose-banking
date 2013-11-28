//
//  KBADashboardControllerViewController.m
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 19.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBADashboardController.h"

@implementation KBADashboardController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/**
 *  Loads all necessary files to display the dashboard 
 *  html view.
 */
- (void)loadHTMLContent
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Assets/html/dashboard" withExtension:@"html"];
    NSString *html = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [self.webView loadHTMLString:html baseURL:baseURL];
    
    self.webView.scalesPageToFit = NO;
    self.webView.multipleTouchEnabled = NO;
    self.webView.delegate = self;
}

/**
 *  When the view was loaded.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.splitViewController.delegate = self;
    [self loadHTMLContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
    navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *action = request.mainDocumentURL.lastPathComponent;
    return [self onWebViewLinkClickedWithAction:action];
}
    
/**
 *  Will be executed when the User performs an action in the web view.
 *
 *  @param action The action called by the user.
 *
 *  @return If YES, the request will be performed.
 */
- (BOOL)onWebViewLinkClickedWithAction:(NSString *)action
{
    // Check the detail buttos here …
    
    return YES;
}

@end
