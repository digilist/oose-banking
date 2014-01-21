//
//  KBAAuth.m
//  Kiba
//
//  Created by Schaarschmidt, Michael on 10.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAAuth.h"
#import "KBACustomerDao.h"
#import "KBADependencyInjector.h"

@interface KBAAuth ()

@property (weak, nonatomic) Customer* identity;

@end


@implementation KBAAuth

/**
 *  Logs the user out.
 */
-(void) logout {
    self.identity = NULL;
}

/**
 *  Tries to login with a description and password
 *
 *  @param description
 *  @param password
 *
 *  @return
 */
-(BOOL) login:(NSString *)name withPassword:(NSString *)password {
    
    id<KBACustomerDao> customerDao = [KBADependencyInjector getByKey:@"customerDao"];
    self.identity = [customerDao customerWithName:@"mustermann" andPassword: @"test"];
    return YES;
}

/**
 *  Returns whether the user is logged in.
 *
 *  @return 
 */
-(BOOL) isLoggedIn {
    return self.identity != NULL;
}

@end
