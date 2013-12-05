//
//  BranchService.h
//  Kiba
//
//  Created by 1jendryc on 05.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "Transaction.h"

@interface BranchService : NSObject

+(void)doTransaction: (Transaction*) trans;




@end
