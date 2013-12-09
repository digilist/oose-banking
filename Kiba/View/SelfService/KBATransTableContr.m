//
//  KBAMoneyTransferController.m
//  Kiba
//
//  Created by //// on 04.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBATransTableContr.h"

@interface KBATransTableContr ()
@property NSArray* moneyTransfers;
@end

/*
 Table-view-controller subclass to present transactions
 in self-service top-view.
*/


@implementation KBATransTableContr

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //table-view supports display of multiple lines, why \n is used here
        self.moneyTransfers = @[@"Betrag: 32234,34€\nvon Konto: 3453762572\nnach Konto: 78886553873",
                                @"Betrag: 654327,23€\nvon Konto: 3453762572\nnach Konto: 43572634",
                                @"Betrag: 10,34€\nvon Konto: 762346723\nnach Konto: 3674572",
                                @"Betrag: 364827,74€\nvon Konto: 67354327\nnach Konto: 465327347"];
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
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.moneyTransfers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    //transfer object
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.text = [self.moneyTransfers objectAtIndex:indexPath.row];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
   
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Ihre gespeicherten Umbuchungen";
}

@end
