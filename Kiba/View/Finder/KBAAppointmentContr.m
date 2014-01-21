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
    
    [KBAMessageService sendMessageToIdentityWithDescription:@"Terminbestätigung" andContent:@"Sehr geehrter Herr Mustermann, gerne bestätigen wir Ihre Terminamfrage am 01.01.2015 9:00."];
    
    
    [dismissNotifCenter postNotificationName:(NSString *) dismissPopover
                                      object:Nil];
    
}



@end
