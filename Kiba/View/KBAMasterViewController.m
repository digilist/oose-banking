//
//  KBMasterViewController.m
//  Kiba
//
//  Created by Konstantin Möllers on 16.11.13.
//  Copyright (c) 2013 Projekt Kiba. All rights reserved.
//

#import "KBAMasterViewController.h"
#import "KBADetailViewController.h"

static NSArray * KBAMasterViewEntryNames;

@implementation KBAMasterViewController

/**
 *  Initializes object values.
 */
+ (void)initialize {
    KBAMasterViewEntryNames = @[@"Dashboard", @"Girokonto", @"Filialfinder", @"KiBa-Center",
                               @"Finanzierung", @"Immobilien", @"Mein Bereich", @"Über die App"];

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
    return KBAMasterViewEntryNames.count;
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

    cell.textLabel.text = KBAMasterViewEntryNames[indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDate *object = _objects[indexPath.row];
//    self.detailViewController.detailItem = object;
}

@end
