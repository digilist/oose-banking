//
//  KBABootstrap.m
//  Kiba
//
//  Created by 1fasselt on 19.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBABootstrap.h"
#import "KBADependencyInjector.h"

#import "KBABranchDao.h"
#import "KBABranchDaoDummy.h"
#import "KBABranchDaoRest.h"
#import "KBACustomerDao.h"
#import "KBACustomerDaoDummy.h"
#import "KBACustomerDaoRest.h"
#import "KBAAccountDao.h"
#import "KBAAccountDaoDummy.h"
#import "KBAAccountDaoRest.h"
#import "KBAAuth.h"
#import "KBAExchangeRateDao.h"
#import "KBAExchangeRateDaoRest.h"
#import "KBATransactionDao.h"
#import "KBATransactionDaoDummy.h"
#import "KBATransactionDaoRest.h"

@implementation KBABootstrap

/**
 * bootstrap our app :)
 *
 */
+ (void) bootstrap {
    [KBABootstrap initDependencyInjector];
}

/**
 * Initialize the dependency injector with all neccessary dependencies.
 *
 */
+ (void) initDependencyInjector {

    id<KBABranchDao> branchDao;
    id<KBAExchangeRateDao> exchangeRateDao;
    id<KBACustomerDao> customerDao;
    id<KBAAccountDao> accountDAo;
    id<KBATransactionDao> transDao;
    KBAAuth *auth = [KBAAuth new];
    
    exchangeRateDao = [KBAExchangeRateDaoRest new];
    
    if (true) { // if development / click dummy
        branchDao = [KBABranchDaoDummy new];
        customerDao = [KBACustomerDaoDummy new];
        accountDAo = [KBAAccountDaoDummy new];
        transDao = [KBATransactionDaoDummy new];
    }
    else {
        branchDao = [KBABranchDaoRest new];
        customerDao = [KBACustomerDaoRest new];
        accountDAo = [KBAAccountDaoRest new];
        transDao = [KBATransactionDaoRest new];
    }
    
    id<KBAColorHelper> colorHelper = [KBAKiBaColorHelper new];
    
    [KBADependencyInjector setObject:branchDao withKey:@"branchDao"];
    [KBADependencyInjector setObject:exchangeRateDao withKey:@"exchangeRateDao"];
    [KBADependencyInjector setObject:customerDao withKey:@"customerDao"];
    [KBADependencyInjector setObject:accountDAo withKey:@"accountDao"];
    [KBADependencyInjector setObject:auth withKey:@"auth"];
    [KBADependencyInjector setObject:transDao withKey:@"transDao"];
    [auth login: @"max" withPassword:@"test"];
    
}

@end
