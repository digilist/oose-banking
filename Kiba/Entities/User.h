//
//  User.h
//  Kiba
//
//  Created by 1kmoelle on 12.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property int userId;
@property NSString *forename;
@property NSString *surname;
@property (readonly) NSString *fullName;
@property NSString *pass;

- (id)initWithId:(int)userId
        forename:(NSString *)forename
         surname:(NSString *)surname
        password:(NSString *)password;
- (NSString *)fullName;

@end
