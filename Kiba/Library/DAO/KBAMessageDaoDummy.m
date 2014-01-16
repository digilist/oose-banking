//
//  KBAMessageDaoDummy.m
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 16.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAMessageDaoDummy.h"
#import "Message.h"

@implementation KBAMessageDaoDummy

-(NSMutableArray *) messagesForCustomer:(Customer *)customer
{
    Message *msg1, *msg2, *msg3;
    NSString *loremIpsum = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.";
    
    msg1 = [[Message alloc] initWithDescription:@"Ihre Sortenanfrage" content:loremIpsum date:[NSDate new] msgId:@1];
    msg2 = [[Message alloc] initWithDescription:@"Ihre Terminanfrage" content:loremIpsum date:[NSDate new] msgId:@2];
    msg3 = [[Message alloc] initWithDescription:@"Ihr verbesserter Zins" content:loremIpsum date:[NSDate new] msgId:@3];
    
    return [NSMutableArray arrayWithArray:@[msg1, msg2, msg3]];
}

@end
