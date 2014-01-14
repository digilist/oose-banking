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
#import "KBAAuthFailPopupController.h"
#import "KBAAuthSuccessPopController.h"


@interface KBAViewController ()
@property UIPopoverController *popController;
@property (nonatomic, strong) KBAAuthFailPopupController *failPopupController;
@property (nonatomic, strong) KBAAuthSuccessPopController *succesPopupController;


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
    self.failPopupController = [KBAAuthFailPopupController new];
    self.succesPopupController = [KBAAuthSuccessPopController new];
    
    
    KBAAuth *auth = [KBADependencyInjector getByKey:@"auth"];
    [self setBackBarButton];
    
    if (self.needsAuthentification && !auth.identity.authenticated) {
        [self disableViewHierachy:self.view];
        [self showPopover];
    }

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
    UIButton * button = [UIButton new];

    [button addTarget:self
               action:@selector(clickedBarButtonItem)
     forControlEvents:UIControlEventTouchUpInside];

    if (customer.authenticated) {

        UIImage *image = [UIImage imageNamed:@"security_checked"];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
        item = [[UIBarButtonItem alloc] initWithCustomView: button];
        
        //
    }
    else {
        UIImage *image = [UIImage imageNamed:@"security_warning"];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
        item = [[UIBarButtonItem alloc] initWithCustomView: button];
        //
    }
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)clickedBarButtonItem
{
    [self showPopover];
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

/**
 *  Show a Popover
 */
- (void)showPopover
{
    KBAAuth *auth = [KBADependencyInjector getByKey:@"auth"];
    Customer *customer = [auth identity];
    
    if (customer.authenticated) {
          self.popController = [[UIPopoverController alloc] initWithContentViewController: self.succesPopupController];
    } else {
           self.popController = [[UIPopoverController alloc] initWithContentViewController: self.failPopupController];
    }
    
    UIBarButtonItem *view = self.navigationItem.rightBarButtonItem;
    
    [self.popController presentPopoverFromBarButtonItem:view
                               permittedArrowDirections:UIPopoverArrowDirectionAny
                                               animated:YES];
}

@end
