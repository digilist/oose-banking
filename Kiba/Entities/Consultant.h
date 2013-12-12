//
//  Consultant.h
//  Kiba
//
//  Created by 1kmoelle on 12.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "User.h"

@interface Consultant : User

@property NSString *phoneNumber;
@property UIImage *image;
@property NSString *businessPosition;

- (id)initWithId:(int)userId
        forename:(NSString *)forename
         surname:(NSString *)surname
            pass:(NSString *)password
     phoneNumber:(NSString *)phoneNumber
           image:(UIImage *)image
businessPosition:(NSString *)businessPosition;


@end
