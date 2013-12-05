//
//  KBADocumentController.m
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBADocumentController.h"

@interface KBADocumentController ()

@end

@implementation KBADocumentController

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


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_scrollView2 setScrollEnabled:YES];
    [_scrollView2 setContentSize:CGSizeMake(2048, 782)];

}

- (void)viewDidLayoutSubviews {
    [_scrollView2 setContentSize:CGSizeMake(2048, 782)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
