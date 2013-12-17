//
//  OpenHour.h
//  Kiba
//
//  Created by 1kmoelle on 05.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KBAWeekDay) {
    KBASunday,
    KBAMonday,
    KBATuesday,
    KBAWednesday,
    KBAThursday,
    KBAFriday,
    KBASaturday
};

@interface OpenHour : NSObject

@property int openingTime;
@property int closingTime;
@property enum KBAWeekDay weekDay;
@property (readonly) NSString *formatted;

-(id) initWithWeekDay:(enum KBAWeekDay) weekDay
          openingTime:(int) openingTimeInMinutes
          closingTime:(int) closingTimeInMinutes;

+(NSString *) nameForWeekDay:(enum KBAWeekDay)weekDay;

//+(enum KBAWeekday) currentWeekDay;

-(NSString *) formatted;

@end
