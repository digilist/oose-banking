//
//  Consultant.m
//  Kiba
//
//  Created by 1kmoelle on 12.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "Consultant.h"

@implementation Consultant

- (id)initWithId:(int)userId
        forename:(NSString *)forename
         surname:(NSString *)surname
            pass:(NSString *)password
     phoneNumber:(NSString *)phoneNumber
           image:(UIImage *)image
businessPosition:(NSString *)businessPosition {
    self = [super initWithId:userId forename:forename surname:surname password:password];
    
    if (self) {
        self.phoneNumber = phoneNumber;
        self.image = image;
        self.businessPosition = businessPosition;
    }
    
    return self;
}

@end
