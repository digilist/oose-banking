//
//  KBACustomerService.h
//  Kiba
//
//  Created by Michael Schaarschmidt on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"

@interface KBACustomerService : NSObject

- (NSMapTable*)getAccountsForCurrentUser;


@end
