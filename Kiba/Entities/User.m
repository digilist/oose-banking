//
//  User.m
//  Kiba
//
//  Created by 1kmoelle on 12.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithId:(int)userId
        forename:(NSString *)forename
         surname:(NSString *)surname
        password:(NSString *)password {
    self = [super init];
    
    if (self) {
        self.userId = userId;
        self.forename = forename;
        self.surname = surname;
        self.pass = password;
    }
    
    return self;
}

/**
 *  Returns the full name of the user.
 *
 *  @return A string containing fore- and surname.
 */
- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.forename, self.surname];
}

@end
