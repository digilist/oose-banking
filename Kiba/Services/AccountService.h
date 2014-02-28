//
//  AccountService.h
//  Kiba
//
//  Created by Marco F. Jendryczko on 05.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface AccountService : NSObject

+(void)calculateBalance:(Account *)account  AfterSend:(NSNumber *)amount;

+(void)calculateBalance:(Account *)account  AfterReceived:(NSNumber *)amount;





@end
