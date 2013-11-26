//
//  KBMasterViewController.m
//  Kiba
//
//  Created by Konstantin Möllers on 16.11.13.
//  Copyright (c) 2013 Projekt Kiba. All rights reserved.
//

#import "KBAMasterViewController.h"
#import "KBADetailViewController.h"

#import "Dashboard/KBADashboardController.h"

static NSArray * KBAMasterViewEntryNames;
static NSMutableDictionary * navigationEntries;
static NSArray * navigationEntryKeys;

@implementation KBAMasterViewController

/**
 *  Initializes object values.
 */
+ (void)initialize {
    navigationEntries = [NSMutableDictionary new];
    [navigationEntries setValue:@"Dashboard" forKey:@"dashboard"];
    [navigationEntries setValue:@"Authentifizierung" forKey:@"auth"];
    [navigationEntries setValue:@"Girokonto" forKey:@"account"];
    [navigationEntries setValue:@"Filialfinder" forKey:@"finder"];
    [navigationEntries setValue:@"KiBa-Center" forKey:@"center"];
    [navigationEntries setValue:@"Finanzierung" forKey:@"finance"];
    [navigationEntries setValue:@"Mein Bereich" forKey:@"private"];
    [navigationEntries setValue:@"Über die App" forKey:@"about"];
    
    navigationEntryKeys = @[@"dashboard", @"auth", @"account", @"finder", @"center",
                            @"finance", @"private", @"about"];
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
    self.title = @"KiBa App";
    
    self.detailViewController = (KBADetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
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
    
    NSString *key = navigationEntryKeys[indexPath.row];
    cell.textLabel.text = [navigationEntries valueForKey:key];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NSString *selectedKey = [navigationEntryKeys objectAtIndex:indexPath.row];
    UIViewController *selectedController = (UIViewController*) [storyboard instantiateViewControllerWithIdentifier:selectedKey];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:selectedController];
    navigationController.navigationBar.topItem.title = [navigationEntries valueForKey:selectedKey];
    
    NSArray* viewControllers = @[[self.splitViewController.viewControllers objectAtIndex:0], // left view / menu
                                 navigationController];
    
    self.splitViewController.viewControllers = viewControllers;
}

@end
