//
//  KBAAccountDaoDummy.m
//  Kiba
//
//  Created by Schaarschmidt, Michael on 12.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAAccountDaoDummy.h"
#import "Account.h"
#include <stdlib.h>

@implementation KBAAccountDaoDummy

/**
 *  Returns dummy accounts.
 *
 *  @param customer
 *
 *  @return the accounts
 */
- (NSArray *) getAccounts:(Customer *)customer {
    NSNumber *balanceA = [NSNumber numberWithInt:5000];
    NSNumber *accountNrA = [NSNumber numberWithLongLong: 1004006661111];
    
    Account *accountA = [[Account alloc] initWithBalance: balanceA
                                               overDraft: 0
                                               accountNr: accountNrA
                                                    name: @"mein Sparkonto"
                                                   owner: customer];
    
    NSNumber *balanceB = [NSNumber numberWithInt:453];
    NSNumber *accountNrB = [NSNumber numberWithLongLong:10040066611145];
    
    Account *accountB = [[Account alloc] initWithBalance: balanceB
                                               overDraft: 0
                                               accountNr: accountNrB
                                                    name: @"mein Girokonto"
                                                   owner: customer];
    
    NSArray *accounts = @[accountA, accountB];
    return accounts;
}

/**
 *  Returns the turnover for an account.
 *
 *  @param account The account.
 *
 *  @return an array over 30 days.
 */
- (NSArray *)turnoverForAccount:(Account *)account {
    NSMutableArray *mutableData = [[NSMutableArray alloc] init];
    double balance = (arc4random() % 50000) / 100.0;
    
    for (int i = -30; i <= 0; i++) {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:i * 86400];
        NSNumber *time = [NSNumber numberWithDouble:date.timeIntervalSince1970 * 1000];
        balance += arc4random() % 3000 / 100.0 - 15;
        NSArray *entry = @[time, [NSNumber numberWithDouble:balance]];
        
        [mutableData addObject:entry];
    }
    
    return [NSArray arrayWithArray:mutableData];
}

@end
