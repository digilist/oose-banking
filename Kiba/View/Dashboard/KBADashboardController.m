//
//  KBADashboardControllerViewController.m
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 19.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBADashboardController.h"
#import "KBADependencyInjector.h"
#import "KBAAccountDao.h"
#import "KBATransactionDao.h"
#import "KBAAuth.h"

@interface KBADashboardController ()

@property id<KBATransactionDao> transactionDao;
@property id<KBAAccountDao> accountDao;
@property KBAAuth *auth;

@end

@implementation KBADashboardController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    self.transactionDao = [KBADependencyInjector getByKey:@"transDao"];
    self.accountDao = [KBADependencyInjector getByKey:@"accountDao"];
    self.auth = [KBADependencyInjector getByKey:@"auth"];
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

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self passIdentityToWebView];
    [self passTurnoverToWebView];
}

/**
 *  Passes the current logged in identity to the web view.
 */
- (void)passIdentityToWebView
{
    Customer *identity = self.auth.identity;
    NSDictionary *identityDic = @{@"id": [NSNumber numberWithInt:identity.userId],
                                  @"forename": identity.forename,
                                  @"surname": identity.surname,
                                  @"fullName": identity.fullName};
    [self passDataToWebView:@"setIdentity" withParameter:identityDic];
}

/**
 *  Passes the turn over to web view.
 */
- (void)passTurnoverToWebView
{
    NSArray *accounts = [self.accountDao getAccounts:self.auth.identity];
    
    NSMutableArray *data = [NSMutableArray new];
    for (Account *account in accounts) {
        NSArray *accountData = [self.accountDao turnoverForAccount:account];
        [data addObject:@{@"label": account.name, @"data": accountData}];
    }
    
    [self passDataToWebView:@"lineChartIt" withParameter:data];
}

/**
 *  Passes some data to the web view.
 *
 *  @param method The java script method.
 *  @param data   The data to pass.
 *
 *  @return whther passing succeeded.
 */
- (BOOL)passDataToWebView:(NSString *)method withParameter:(id)data
{
    NSError *error;
    NSData *json = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!error) {
        NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
        NSLog(@"%@", jsonString);
        NSString *jsCall = [NSString stringWithFormat:@"%@(%@)", method, jsonString];
        [self.webView stringByEvaluatingJavaScriptFromString:jsCall];
        
        return YES;
    }
    
    return NO;
}

@end
