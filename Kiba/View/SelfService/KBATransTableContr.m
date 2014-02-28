//
//  KBAMoneyTransferController.m
//  Kiba
//
//  Created by Alexander Droste on 04.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBATransTableContr.h"
#import "KBADependencyInjector.h"
#import "KBATransactionDao.h"
#import "KBAAuth.h"

#import "Account.h"
#import "Transaction.h"
#import "Customer.h"

@interface KBATransTableContr ()
@property NSMutableArray* moneyTransfers;
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
        id<KBATransactionDao> transDao = [KBADependencyInjector getByKey:@"transDao"];
        
        KBAAuth *auth = [KBADependencyInjector getByKey:@"auth"];
        Customer *customer = [auth identity];
        self.moneyTransfers = [NSMutableArray new];
        NSArray *trans = [transDao transactionsForCustomer: customer];
        
        for (int i = 0; i < ([trans count]); i++)
        {
            NSString *string = @"";
            Account *sender = [[trans objectAtIndex:i]sender];
            Account *recipient = [[trans objectAtIndex:i]recipient];
            
            if ((sender.owner.userId == customer.userId) && (recipient.owner.userId == customer.userId )) {
                
                string = [[trans objectAtIndex:i]printTransactionTinyOwn];
                [self.moneyTransfers addObject: string];
            }
        }
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
    
    //0 means an arbitrary number of lines [1 - ~)
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [self.moneyTransfers objectAtIndex:indexPath.row];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
   
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Umbuchungen";
}

@end
