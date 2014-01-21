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
    NSString *sender = @"KiBa Filiale Informatikum";
    NSString *content1= @"Sehr geehrter Herr Mustermann, \n\nSie können die von Ihnen gewünschten Sorten nun jederzeit in der Kiba Filiale am Informatikum abholen. \n\nHerzliche Grüße, \n\nReiner Müller";
    NSString *content2= @"Sehr geehrter Herr Mustermann, gerne trifft sich Ihr Berater Herr Müller am 30.1. um 14:15 in der KiBa-Filiale Binderstraße mit Ihnen.";
    NSString *content3= @"Sehr geehrter Herr Mustermann, im Zuge der Anpassung des europäischen Leitzins können wir Ihnen nun verbesserte Konditionen anbieten. Im Finanzierungsrechner können Sie jetzt mit den entsprechend angepassten Zinsen eigene Finanzerungen planen.";
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekday:2]; // Monday
    [components setWeekdayOrdinal:1]; // The first Monday in the month
    [components setMonth:5]; // May
    [components setYear:2008];
    
    msg1 = [[Message alloc] initWithDescription:@"Ihre Sortenanfrage" content:content1 sender:sender date:[NSDate new] msgId:@1];
    msg2 = [[Message alloc] initWithDescription:@"Ihre Terminanfrage" content:content2 sender:sender date:[NSDate new] msgId:@2];
    msg3 = [[Message alloc] initWithDescription:@"Ihr verbesserter Zins" content:content3 sender:sender date:[gregorian dateFromComponents:components] msgId:@3];
    
    return [NSMutableArray arrayWithArray:@[msg1, msg2, msg3]];
}

@end
