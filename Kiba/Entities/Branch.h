//
//  Branch.h
//  Kiba
//
//  Created by Marco F. Jendryczko on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Address.h"
#import "Consultant.h"

@interface Branch : NSObject

@property NSString *name;
@property Address *address;
@property NSString *bic;
@property NSArray *openHours;
@property Consultant *consultant;
@property NSString *phoneNumber;

-(id)initWithName:(NSString *)name
          address:(Address *)address
              bic:(NSString *)bic
        openHours:(NSArray *)openHours
       consultant:(Consultant *)consultant
      phoneNumber:(NSString *)phoneNumber;

@end
