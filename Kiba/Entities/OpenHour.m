//
//  OpenHour.m
//  Kiba
//
//  Created by 1kmoelle on 05.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "OpenHour.h"

@implementation OpenHour

-(id) initWithWeekDay:(enum KBAWeekDay) weekDay
          openingTime:(int) openingTimeInMinutes
          closingTime:(int) closingTimeInMinutes
{
    if (self = [super init]) {
        self.weekDay = weekDay;
        self.openingTime = openingTimeInMinutes;
        self.closingTime = closingTimeInMinutes;
    }
    return self;
}

+(NSString *) nameForWeekDay:(enum KBAWeekDay)weekDay
{
    switch (weekDay) {
        case KBAMonday: return @"Montag";
        case KBATuesday: return @"Dienstag";
        case KBAWednesday: return @"Mittwoch";
        case KBAThursday: return @"Donnerstag";
        case KBAFriday: return @"Freitag";
        case KBASaturday: return @"Samstag";
        case KBASunday: return @"Sonntag";
    }
}

/*+(enum KBAWeekDay) currentWeekDay
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* comp = [cal components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    [KBAWeekday] comp.weekday
}*/

-(NSString *) formatted
{
    return [NSString stringWithFormat:@"%@ %d:%02d - %d:%02d",
            [OpenHour nameForWeekDay:self.weekDay],
            self.openingTime / 60,
            self.openingTime % 60,
            self.closingTime / 60,
            self.closingTime % 60];
}

@end
