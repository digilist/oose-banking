//
//  KBAStatementController.m
//  Kiba
//
//  Created by Michael Schaarschmidt on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAStatemContr.h"
#import "KBAFlatDatePicker.h"

#import "KBADependencyInjector.h"
#import "KBATransactionDao.h"
#import "KBAAuth.h"

#import "Account.h"
#import "Transaction.h"
#import "Customer.h"
#import "User.h"

#import "KBAStatemTableController.h"

@interface KBAStatemContr ()
@property (nonatomic, weak) IBOutlet KBAFlatDatePicker *datePickerBegin;
@property (nonatomic, weak) IBOutlet KBAFlatDatePicker *datePickerEnd;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet KBAStatemTableController *subStatemContr;
@end

@implementation KBAStatemContr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.title = @"Kontoauszüge drucken";
        

        
         }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
