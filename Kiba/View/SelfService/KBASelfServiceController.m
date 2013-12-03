//
//  KBASelfServiceController.m
//  Kiba
//
//  Created by Schaarschmidt, Michael on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBASelfServiceController.h"
#import "KBATransferController.h"
#import "KBAStatementController.h"
#import "KBADocumentController.h"

@interface KBASelfServiceController ()

@end

@implementation KBASelfServiceController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Connects to a KiBa-station.
 *
 *  @param sender
 */
- (IBAction)connect:(id)sender
{
    self.circle.hidden = NO;
    [self.circle startAnimating];


    dispatch_queue_t work = dispatch_queue_create("work", NULL);
    dispatch_async(work, ^{
        [NSThread sleepForTimeInterval:2];

        dispatch_async(dispatch_get_main_queue(), ^{
    
            [self.circle stopAnimating];
            self.circle.hidden = YES;
        });
    
    });
    
}

/**
 *  Changes view to transfer view.
 *
 *  @param sender
 */
- (IBAction)changeToTransferView:(id)sender
{
    [self.navigationController pushViewController:[KBATransferController new] animated:YES];
}

/**
 *  Changes view to statement view.
 *
 *  @param sender
 */
- (IBAction)changeToStatementView:(id)sender
{
    [self.navigationController pushViewController:[KBAStatementController new] animated:YES];
}

/**
 *  Changes view to statement view.
 *
 *  @param sender
 */
- (IBAction)changeToDocumentView:(id)sender
{
    [self.navigationController pushViewController:[KBADocumentController new] animated:YES];
}

@end
