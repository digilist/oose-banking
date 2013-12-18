//
//  KBAChooseAccountContr.m
//  Kiba
//
//  Created by //// on 05.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAChooseAccountTableContr.h"
#import "KBADependencyInjector.h"
#import "KBAAccountDao.h"
#import "Account.h"
#import "KBAAuth.h"

/*
    Datasource is given through NSArray* accounts
 */

const extern NSString *accountEntryChosen;
extern NSNotificationCenter *transferChooseAccountNotifCenter;

@implementation KBAChooseAccountTableContr

/**
 *  Default/designated init method for table-view-contr.
 *  @param style init with specific appearance-style
 *  @return initialized table-view-contr
 */
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        id<KBAAccountDao> accountDao = [KBADependencyInjector getByKey:@"accountDao"];
        KBAAuth *auth = [KBADependencyInjector getByKey:@"auth"];
        self.customer = [auth getIdentity];
        self.accounts = [accountDao getAccounts:self.customer];
        
    }
    return self;
}


#pragma mark - Table view data source

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    Account *account = [self.accounts objectAtIndex: indexPath.row];
    [transferChooseAccountNotifCenter postNotificationName: (NSString*)accountEntryChosen
                                                    object: account.name];
}

/**
 *  Specifies the number of sections in table-view. (see iOS-Docs)
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
    
    cell.textLabel.text = [[self.accounts objectAtIndex:indexPath.row] name];
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
