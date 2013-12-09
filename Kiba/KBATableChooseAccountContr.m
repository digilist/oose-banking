//
//  KBAChooseAccountContr.m
//  Kiba
//
//  Created by //// on 05.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBATableChooseAccountContr.h"

/* 
   Datasource and delegate superclass for account table-views.
   KBATableChooseTermAccContr & KBATableChooseDailyAccContr inherit from this controller.
   Datasource is given through NSArray* accounts 
 */

@implementation KBATableChooseAccountContr

/**
 *  Default/designated init method for table-view-contr.
 *  @param style init with specific appearance-style
 *  @return initialized table-view-contr
 */
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

/**
 *  Specifies the number of section per in table-view. (see iOS-Docs)
 *  Value is set to const 1. No variable section value needed. This is a framework method.
 *
 *  @param tableView given table-view
 *  @return number of sections
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 *  Returns the number of bank accounts.
 *
 *  @param tableView table-view to inspect
 *  @param section  sections are ignored
 *
 *  @return number of accounts
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.accounts count];
}

/**
 *  Returns cell for index from table-view.
 *  This is a framework method.
 *
 *  @param tableView given table-view
 *  @param indexPath index to get the cell for
 *
 *  @return cell obetained from view for index
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.accounts objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 1;
    
    return cell;
}

/**
 *  Sets title for table-view in popover.
 *
 *  @param tableView table-view to set title for
 *  @param section   sections are ignored
 *
 *  @return title to display in table-view
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Wählen sie ihr Konto";
}

@end
