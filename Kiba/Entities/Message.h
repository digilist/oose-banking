//
//  Message.h
//  Kiba
//
//  Created by Schaarschmidt, Michael on 16.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property NSString *description;
@property NSString *content;
@property NSDate *date;
@property NSNumber *msgId;

- (id) initWithDescription:(NSString *) description
                   content:(NSString *) content
                      date:(NSDate *) date
                     msgId:(NSNumber *) msgId;

@end
