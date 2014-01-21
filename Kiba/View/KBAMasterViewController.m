//
//  KBMasterViewController.m
//  Kiba
//
//  Created by Konstantin Möllers on 16.11.13.
//  Copyright (c) 2013 Projekt Kiba. All rights reserved.
//

#import <UIKit/UIImageView.h>

#import "KBAMasterViewController.h"
#import "Dashboard/KBADashboardController.h"
#import "KBADependencyInjector.h"
#import "KBAColorHelper.h"
#import "KBAAuth.h"

static NSArray * KBAMasterViewEntryNames;
static NSMutableDictionary * navigationEntries;
static NSArray * navigationEntryKeys;

static UIImage *lockedIcon;

@implementation KBAMasterViewController

/**
 *  Initializes object values.
 */
+ (void)initialize {
    navigationEntries = [NSMutableDictionary new];
    [navigationEntries setValue:@"Dashboard" forKey:@"dashboard"];
    [navigationEntries setValue:@"Authentifizierung" forKey:@"auth"];
    [navigationEntries setValue:@"Überweisung" forKey:@"account"];
    [navigationEntries setValue:@"Self Service" forKey:@"selfservice"];
    [navigationEntries setValue:@"Filialfinder" forKey:@"finder"];
    [navigationEntries setValue:@"Finanzierung" forKey:@"finance"];
    [navigationEntries setValue:@"Mein Bereich" forKey:@"private"];
    [navigationEntries setValue:@"Über die App" forKey:@"about"];
    
    navigationEntryKeys = @[@"dashboard", @"finder", @"auth", @"account", @"selfservice",
                            @"finance", @"private", @"about"];
    
    
    lockedIcon = [UIImage imageNamed:@"locked"];
}


- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.barTintColor = KBABarTintColor;
    self.tintColor = [UIColor whiteColor];
   //  self.navigationController.navigationBar.barTintColor = self.barTintColor;
    self.tableView.backgroundColor = self.tintColor;

    self.title = @"KiBa App";
    
    // hack to show the first detail view with the right settings!
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView: self.tableView didSelectRowAtIndexPath:path];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 *  Returns the number of entries in the view.
 *
 *  @param tableView
 *  @param section
 *
 *  @return The count.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return navigationEntryKeys.count;
}

/**
 *  Returns the cell for a given index path.
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return The corresponding cell.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = self.tintColor;
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = KBATintColor;
    cell.selectedBackgroundView = v;
    NSString *key = navigationEntryKeys[indexPath.row];
    cell.textLabel.text = [navigationEntries valueForKey:key];
    
    cell.accessoryView = nil;
    if ([key isEqualToString:@"account"] || [key isEqualToString:@"selfservice"] || [key isEqualToString:@"finance"])
    {
        KBAAuth *auth = [KBADependencyInjector getByKey:@"auth"];
        Customer *customer = [auth identity];
        
        if(!customer.authenticated)
        {
            cell.accessoryView = [[UIImageView alloc] initWithImage:lockedIcon highlightedImage:lockedIcon];
        }
    }
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/**
 *  Contains the logic to open the right detail controller when a table cell was selected.
 *
 *  @param tableView The involved table view.
 *  @param indexPath The selected index path.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // Resolve the controller for the cell
    NSString *selectedKey = [navigationEntryKeys objectAtIndex:indexPath.row];
    UIViewController *selectedController = (UIViewController*) [storyboard instantiateViewControllerWithIdentifier:selectedKey];
    UINavigationController *selectedNavigationController = [[UINavigationController alloc] initWithRootViewController:selectedController];

    // Adjust navigation title
    selectedNavigationController.navigationBar.topItem.title = [navigationEntries valueForKey:selectedKey];
    selectedNavigationController.navigationBar.tintColor = KBATintColor;
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
          // Tint color of top bar icons
          KBATintColor,
          NSForegroundColorAttributeName,
          // Top bar font
          [UIFont systemFontOfSize:0.0],
          NSFontAttributeName,
          nil]];
    
    // Set new Splitcontroller configuration
    NSArray* splitViewControllers = @[self.navigationController,     // Master View Navigation
                                      selectedNavigationController]; // Detail View Navigation
    self.splitViewController.delegate = (UIViewController <UISplitViewControllerDelegate> *) selectedController;
    self.splitViewController.viewControllers = splitViewControllers;
}

@end
