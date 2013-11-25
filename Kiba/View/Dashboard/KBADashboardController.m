//
//  KBADashboardControllerViewController.m
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 19.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBADashboardController.h"

@interface KBADashboardController ()

@end

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
}

/**
 *  When the view was loaded.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadHTMLContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
