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

- (NSArray *) getTransaction:(Customer *)customer {

    
    
    // Transactiondummy
    NSNumber *amountA = [NSNumber numberWithInt:2];
    NSDate *dateA = [NSDate dateWithTimeIntervalSinceNow:23489284];
    
    Account *acc1 = [customer.accounts firstObject];
    
    //Erzeugung von FakeCustomer
    Customer *custo2 = [[Customer alloc] initWithId:1 forename:@"Susanne" surname:@"Strebsam" password:nil];
    
    Customer *custo3 = [[Customer alloc] initWithId:2 forename:@"Yolander" surname:@"Batzteki" password:nil];
    
    
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
    
    
    // Die eigentlichen Transaktionen
    Transaction *trans1 = [[Transaction alloc] initWithType:nil
                                                  recipient:accountB
                                                     sender:acc1
                                                     amount:amountA
                                                       date:dateA];
    
    NSNumber *amountB = [NSNumber numberWithDouble:42.23];
    NSDate *dateB = [NSDate dateWithTimeIntervalSinceNow:-1212];
    
    Transaction *trans2 = [[Transaction alloc] initWithType:nil
                                                  recipient:acc1
                                                     sender:accountA
                                                     amount:amountB
                                                       date:dateB];
    
    NSArray *transactions = @[trans1, trans2];
    return transactions;
    

                           
}

@end
