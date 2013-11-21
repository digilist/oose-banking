//
//  Transaction.h
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Customer.h"

@interface Transaction : NSObject

@property id type;

// TODO: Recipient von andere bank? what what? :D
@property Customer* recipient;

@property Customer* sender;
@property NSNumber* amount;
@property NSDate* date;


@end
