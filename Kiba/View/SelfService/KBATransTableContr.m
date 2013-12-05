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

@implementation KBATransTableContr


//TODO: support cell division per row
- (id)initWithStyle:(UITableViewStyle)style
{
    

    
    self = [super initWithStyle:style];
    if (self) {
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
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    

    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    //transfer object
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.text = [self.moneyTransfers objectAtIndex:indexPath.row];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
   
    // Configure the cell...
//    cell.latitude.text = [[[self.tableData objectAtIndex:indexPath.section objectAtIndex:indexPath.row] objectForKey: @"lat"];
//    cell.longitude.text = [[[self.tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"long"];
//.
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    return @"Ihre gespeicherten Umbuchungen";
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
