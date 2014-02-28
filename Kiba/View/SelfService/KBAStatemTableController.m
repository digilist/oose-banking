//
//  KBAStatemTableController.m
//  Kiba
//
//  Created by Marco F. Jendryczko on 24.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAStatemTableController.h"
#import "KBADependencyInjector.h"
#import "KBATransactionDao.h"
#import "KBAAuth.h"

#import "Account.h"
#import "Transaction.h"
#import "Customer.h"
#import "User.h"

@interface KBAStatemTableController ()
@property NSMutableArray *statem;

@end

@implementation KBAStatemTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        id<KBATransactionDao> transDao = [KBADependencyInjector getByKey:@"transDao"];
        
        KBAAuth *auth = [KBADependencyInjector getByKey:@"auth"];
        Customer *customer = [auth identity];
        self.statem = [NSMutableArray new];
        NSArray *trans = [transDao transactionsForCustomer: customer];
        
        for (int i = 0; i < ([trans count]); i++)
        {
            NSMutableString *indicator = [[NSMutableString alloc]initWithString:@""];
            NSString *string = @"";
            Account *user = [[trans objectAtIndex:i]sender];
            Account *recipient = [[trans objectAtIndex:i]recipient];
            if ((user.owner.userId == customer.userId) && (recipient.owner.userId != customer.userId) ) {
                [indicator setString:@"-"];
                string = [[trans objectAtIndex:i]printTransactionTiny:indicator];
                
                [self.statem addObject: string];
                
            }
            else if ((recipient.owner.userId == customer.userId) && (user.owner.userId != customer.userId))
            {
                [indicator setString:@"+"];
                string = [[trans objectAtIndex:i]printTransactionTiny:indicator];
                
                [self.statem addObject: string];
                
            }
            else if ((user.owner.userId == customer.userId) && (recipient.owner.userId == customer.userId ))
            {
                string = [[trans objectAtIndex:i]printTransactionTinyOwn2];
                [self.statem addObject: string];
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
    return [self.statem count];
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
    
    cell.textLabel.text = [self.statem objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Transaktionen";
}



@end
