//
//  KBAViewController.m
//  Kiba
//
//  Created by 1fasselt on 26.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAViewController.h"
#import "KBAAuth.h"
#import "Customer.h"
#import "KBADependencyInjector.h"
#import "KBAAuth.h"

@interface KBAViewController ()
@end

@implementation KBAViewController

- (id) init {
    NSString *className = NSStringFromClass([self class]);
    self = [self initWithNibName:className bundle:Nil];
    self.needsAuthentification = NO;
    if (self) {
        
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [self init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    KBAAuth *auth = [KBADependencyInjector getByKey:@"auth"];
    if (self.needsAuthentification && !auth.identity.authenticated) {
        [self disableViewHierachy:self.view];
    }
    
    [self setBackBarButton];
}

-(void)disableViewHierachy:(UIView *)view
{
    for (UIView * subview in [view subviews]) {
        [subview setUserInteractionEnabled: NO];
        [self disableViewHierachy:subview];
    }
}

-(void)setBackBarButton {
    KBAAuth *auth = [KBADependencyInjector getByKey:@"auth"];
    Customer *customer = [auth identity];
    UIBarButtonItem *item;
    
    
    if (customer.authenticated) {
        item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"security_checked"]]];
    } else {
        item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"security_warning"]]];
    }
    self.navigationItem.rightBarButtonItem = item;
    [item setAction:@selector(clickedBarButtonItem)];

}

- (void)clickedBarButtonItem
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

/**
 *  Will be executed by split view controller.
 *
 *  @param splitController   The SplitController that invokes the method.
 *  @param viewController    The ViewController that will be hidden.
 *  @param barButtonItem     The Bar Button.
 *  @param popoverController The PopoverControlelr that will be displayed.
 */
- (void)splitViewController:(UISplitViewController *)splitController
     willHideViewController:(UIViewController *)viewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = @"Navigation";
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
}

- (void)splitViewController:(UISplitViewController *)splitController
     willShowViewController:(UIViewController *)viewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
}

@end
