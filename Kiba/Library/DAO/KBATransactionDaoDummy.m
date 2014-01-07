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

    // Transactiondummy
    NSNumber *amountA = [NSNumber numberWithInt:2];
    NSDate *dateA = [NSDate dateWithTimeIntervalSinceNow:23489284];
    
    // Get Accounts by a customer
    Account *acc1 = [customer.accounts firstObject];
    Account *acc2 = [customer.accounts objectAtIndex:1];
    
    // Create fake recipients
    Customer *custo2 = [[Customer alloc] initWithId:2 forename:@"Susanne" surname:@"Strebsam" password:nil];
    
    Customer *custo3 = [[Customer alloc] initWithId:3 forename:@"Yolander" surname:@"Batzteki" password:nil];
    
    Customer *custo4 = [[Customer alloc] initWithId:3 forename:@"Michael" surname:@"Schmidt" password:nil];
    
    Customer *custo5 = [[Customer alloc] initWithId:3 forename:@"Ralf" surname:@"Reichelt" password:nil];
    
    
    
    // Interaktion Accounts
    NSNumber *balanceA = [NSNumber numberWithInt:5000];
    NSNumber *accountNrA = [NSNumber numberWithLongLong: 1004006661111];
    
    Account *accountA = [[Account alloc] initWithBalance: balanceA
                                               overDraft: 0
                                               accountNr: accountNrA
                                                    name: @"mein Sparkonto"
                                                   owner: custo2];
    
    NSNumber *balanceB = [NSNumber numberWithInt:453];
    NSNumber *accountNrB = [NSNumber numberWithLongLong:10040066611145];
    
    Account *accountB = [[Account alloc] initWithBalance: balanceB
                                               overDraft: 0
                                               accountNr: accountNrB
                                                    name: @"mein Girokonto"
                                                   owner: custo3];
    
    Account *accountC = [[Account alloc] initWithBalance: balanceB
                                               overDraft: 0
                                               accountNr: accountNrB
                                                    name: @"mein Girokonto"
                                                   owner: custo4];
    
    Account *accountD = [[Account alloc] initWithBalance: balanceB
                                               overDraft: 0
                                               accountNr: accountNrB
                                                    name: @"mein Girokonto"
                                                   owner: custo5];
    
    
    // Die eigentlichen Transaktionen
    Transaction *trans1 = [[Transaction alloc] initWithType:nil
                                                  recipient:accountB
                                                     sender:acc1
                                                     amount:amountA
                                                       date:dateA];
    
    
    NSDate *dateB = [NSDate dateWithTimeIntervalSinceNow:-1212];
    
    Transaction *trans2 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc1
                                                     sender:accountA
                                                     amount:[self generateRandomAmount]
                                                       date:dateB];
    
    Transaction *trans3 = [[Transaction alloc] initWithType:nil
                                                  recipient:accountB
                                                     sender:acc1
                                                     amount:[self generateRandomAmount]
                                                       date:dateB];
    
    Transaction *trans4 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc1
                                                     sender:accountC
                                                     amount:[self generateRandomAmount]
                                                       date:dateB];
    
    Transaction *trans5 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc1
                                                     sender:accountD
                                                     amount:[self generateRandomAmount]
                                                       date:dateB];
    
    Transaction *trans6 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc1
                                                     sender:accountD
                                                     amount:[self generateRandomAmount]
                                                       date:dateB];
    
    Transaction *trans7 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc1
                                                     sender:acc2
                                                     amount:[self generateRandomAmount]
                                                       date:dateB];
    
    Transaction *trans8 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc2
                                                     sender:acc1
                                                     amount:[self generateRandomAmount]
                                                       date:dateB];
    
    Transaction *trans9 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc1
                                                     sender:acc2
                                                     amount:[self generateRandomAmount]
                                                       date:dateB];
    
    Transaction *trans10 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc1
                                                     sender:acc2
                                                     amount:[self generateRandomAmount]
                                                       date:dateB];
    
    Transaction *trans11 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc2
                                                     sender:acc1
                                                     amount:[self generateRandomAmount]
                                                       date:dateB];
    
    Transaction *trans12 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc2
                                                     sender:acc1
                                                     amount:[self generateRandomAmount]
                                                       date:dateB];
    

    
    NSArray *transactions = @[trans1, trans2, trans3, trans4, trans5, trans6, trans7, trans8, trans9, trans10, trans11, trans12];
    return transactions;
    

                           
}

/**
 *  Generates a random amount for a transaction.
 *
 *  @return a random number
 */
- (NSNumber *)generateRandomAmount {
    srand48(time(0));
    int multi = arc4random_uniform(100000)+10;
    double r = drand48();

    double sum = (multi * r);
    return [NSNumber numberWithDouble: sum];
}

@end
