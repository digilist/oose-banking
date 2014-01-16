//
//  Message.m
//  Kiba
//
//  Created by Schaarschmidt, Michael on 16.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "Message.h"

@implementation Message

- (id) initWithDescription:(NSString *) description
                   content:(NSString *) content
                      date:(NSDate *) date
                     msgId:(NSNumber *) msgId {
    
    self = [super init];
    
    if (self) {
        self.description = description;
        self.content = content;
        self.date = date;
        self.msgId = msgId;
    }
    
    return self;
}

@end
