//
//  KBAAppointmentView.m
//  Kiba
//
//  Created by 1fasselt on 07.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAAppointmentContr.h"
#import "KBAMessageService.h"

extern NSNotificationCenter *dismissNotifCenter;
const extern NSString *dismissPopover;



@interface KBAAppointmentContr ()
@property (nonatomic, weak) IBOutlet UIDatePicker *pickedDate;
@end

@implementation KBAAppointmentContr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.preferredContentSize = self.view.frame.size;
    }
    return self;
}


- (IBAction)requestButtonClicked:(id)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy 'um' HH:mm"];
    
    NSDate *choosenDate = self.pickedDate.date;
    
    NSString *formattedDateString = [dateFormatter stringFromDate:choosenDate];
    
    NSLog(@"%@", formattedDateString);
    
    NSString *contenString = [NSString stringWithFormat:@"Sehr geehrter Herr König, \ngerne bestätigen wir Ihre Terminamfrage am %@ \n\nherzliche Grüße, \n\nIhre KiBa-Filiale" , formattedDateString];
    
    [KBAMessageService sendMessageToIdentityWithDescription:@"Terminbestätigung"
                                                 andContent:contenString
                                                    andSender:@"KiBa-Filiale Informatikum"];
    
    [dismissNotifCenter postNotificationName:(NSString *) dismissPopover
                                      object:Nil];
    
}



@end
