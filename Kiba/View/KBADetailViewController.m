//
//  KBDetailViewController.m
//  Kiba
//
//  Created by Konstantin Möllers on 16.11.13.
//  Copyright (c) 2013 Projekt Kiba. All rights reserved.
//

#import "KBADetailViewController.h"
#import "Dashboard/KBADashboardController.h"

@interface KBADetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation KBADetailViewController

#pragma mark - Managing the detail item

- (void)setDetailControllerName:(NSString *)detailControllerName {
    if (_detailControllerName != detailControllerName) {
        _detailControllerName = detailControllerName;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        id detailController = [storyboard instantiateViewControllerWithIdentifier:detailControllerName];
        
        self.detailController = detailController;
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}


/**
 *  Configures the view. Update the user interface for the detail item.
 */
- (void)configureView
{
    if (self.detailController) {
        [self.navigationController pushViewController:self.detailController animated:YES];
        
    }
}

/**
 *  Will be executed when the view loads.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   [self configureView];
    
    
    //[self setDetailController:detail];
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
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController
    willShowViewController:(UIViewController *)viewController
    invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
