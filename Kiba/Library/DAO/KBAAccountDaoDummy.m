//
//  KBAAccountDaoDummy.m
//  Kiba
//
//  Created by Schaarschmidt, Michael on 12.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAAccountDaoDummy.h"
#import "Account.h"

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

@end
