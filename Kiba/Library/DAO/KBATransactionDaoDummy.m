//
//  KBATransactionDaoDummy.m
//  Kiba
//
//  Created by 1jendryc on 17.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBATransactionDaoDummy.h"
#import "Transaction.h"
#import "Customer.h"
#import "KBAAuth.h"
#import "KBADependencyInjector.h"

@implementation KBATransactionDaoDummy

/**
 *  Returns the transactions associated with a customer.
 *
 *  @param customer The associated customer.
 *
 *  @return An array of Transactions.
 */
- (NSArray *)transactionsForCustomer:(Customer *)customer {
    // Get Accounts from a customer
    Account *acc1 = [customer.accounts firstObject];
    Account *acc2 = [customer.accounts objectAtIndex:1];
    
    // Create fake recipients
    Customer *custo2 = [[Customer alloc] initWithId:2 forename:@"Susanne" surname:@"Strebsam" password:nil];
    Customer *custo3 = [[Customer alloc] initWithId:3 forename:@"Yolander" surname:@"Batzteki" password:nil];
    Customer *custo4 = [[Customer alloc] initWithId:3 forename:@"Michael" surname:@"Schmidt" password:nil];
    Customer *custo5 = [[Customer alloc] initWithId:3 forename:@"Ralf" surname:@"Reichelt" password:nil];
    
    // Interaction Accounts
    NSNumber *balanceA = [self generateRandomAmount];
    NSNumber *accountNrA = [NSNumber numberWithLongLong: 1004006661111];
    
    Account *accountA = [[Account alloc] initWithBalance: balanceA
                                               overDraft: @0
                                               accountNr: accountNrA
                                                    name: @"Susannes Konto"
                                                   owner: custo2];
    
    NSNumber *balanceB = [self generateRandomAmount];
    NSNumber *accountNrB = [NSNumber numberWithLongLong:10040066611145];
    
    Account *accountB = [[Account alloc] initWithBalance: balanceB
                                               overDraft: @0
                                               accountNr: accountNrB
                                                    name: @"Yolanders Konto"
                                                   owner: custo3];
    
    Account *accountC = [[Account alloc] initWithBalance: balanceB
                                               overDraft: @0
                                               accountNr: accountNrB
                                                    name: @"Michaels Konto"
                                                   owner: custo4];
    
    Account *accountD = [[Account alloc] initWithBalance: balanceB
                                               overDraft: @0
                                               accountNr: accountNrB
                                                    name: @"Ralfs Konto"
                                                   owner: custo5];
    
    
    // Add transactions
    Transaction *trans1 = [[Transaction alloc] initWithType:nil
                                                  recipient:accountB
                                                     sender:acc1
                                                     amount:[self generateRandomAmount]
                                                       date:[self generateRandomDate]];
    
    Transaction *trans2 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc1
                                                     sender:accountA
                                                     amount:[self generateRandomAmount]
                                                       date:[self generateRandomDate]];
    
    Transaction *trans3 = [[Transaction alloc] initWithType:nil
                                                  recipient:accountB
                                                     sender:acc1
                                                     amount:[self generateRandomAmount]
                                                       date:[self generateRandomDate]];
    
    Transaction *trans4 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc1
                                                     sender:accountC
                                                     amount:[self generateRandomAmount]
                                                       date:[self generateRandomDate]];
    
    Transaction *trans5 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc1
                                                     sender:accountD
                                                     amount:[self generateRandomAmount]
                                                       date:[self generateRandomDate]];
    
    Transaction *trans6 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc1
                                                     sender:accountD
                                                     amount:[self generateRandomAmount]
                                                       date:[self generateRandomDate]];
    
    Transaction *trans7 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc1
                                                     sender:acc2
                                                     amount:[self generateRandomAmount]
                                                       date:[self generateRandomDate]];
    
    Transaction *trans8 = [[Transaction alloc] initWithType:nil
                                                  recipient:accountA
                                                     sender:acc1
                                                     amount:[self generateRandomAmount]
                                                       date:[self generateRandomDate]];
    
    Transaction *trans9 = [[Transaction alloc] initWithType:nil
                                                  recipient:accountA
                                                     sender:acc2
                                                     amount:[self generateRandomAmount]
                                                       date:[self generateRandomDate]];
    
    Transaction *trans10 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc1
                                                     sender:acc2
                                                     amount:[self generateRandomAmount]
                                                       date:[self generateRandomDate]];
    
    Transaction *trans11 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc2
                                                     sender:acc1
                                                     amount:[self generateRandomAmount]
                                                       date:[self generateRandomDate]];
    
    Transaction *trans12 = [[Transaction alloc] initWithType:nil
                                                  recipient:accountB
                                                     sender:acc2
                                                     amount:[self generateRandomAmount]
                                                       date:[self generateRandomDate]];
    
    NSArray *transactions = @[trans1, trans2, trans3, trans4, trans5, trans6, trans7, trans8, trans9, trans10, trans11, trans12];
    
    return transactions;
}

/**
 *  Generates a random amount for a transaction.
 *
 *  @return a random number
 */
- (NSNumber *)generateRandomAmount
{
    double randomAmount = (arc4random() % 50000) / 100.0;
    return [NSNumber numberWithDouble: randomAmount];
}

/**
 *  Generates a random date in the last 30 days.
 *
 *  @return a date representation
 */
- (NSDate *)generateRandomDate
{
    int randomShift = (int) -(arc4random() % 2592000);
    return [[NSDate alloc] initWithTimeIntervalSinceNow:randomShift];
}

@end
