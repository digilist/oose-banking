//
//  KBATransferController.m
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBATransferController.h"

@interface KBAChooseTermAccountController: UIViewController @end
@interface KBAChooseDailyAccountController: UIViewController @end

@interface KBATransferController ()
@property KBAChooseTermAccountController* chooseTermAccountController;
@property KBAChooseDailyAccountController* chooseDailyAccountController;
@property UIPopoverController* popController;
@end

@implementation KBATransferController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.chooseTermAccountController = [KBAChooseTermAccountController new];
        self.chooseDailyAccountController = [KBAChooseDailyAccountController new];
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

-(IBAction)chooseDailyAccount:(id)sender
{
    UIButton* pressedButton = (UIButton*)sender;
    CGPoint buttonPosition = pressedButton.frame.origin;
    
    self.popController = [[UIPopoverController alloc]
                            initWithContentViewController:self.chooseDailyAccountController];
    
    [self.popController presentPopoverFromRect: CGRectMake(buttonPosition.x, buttonPosition.y, 100, 100)
                                        inView:self.view
                      permittedArrowDirections:UIPopoverArrowDirectionDown
                                      animated:YES];
}
-(IBAction)chooseTermAccount:(id)sender
{
    UIButton* pressedButton = (UIButton*)sender;
    CGPoint buttonPosition = pressedButton.frame.origin;
    self.popController = [[UIPopoverController alloc]
                            initWithContentViewController:self.chooseTermAccountController];
    
    [self.popController presentPopoverFromRect: CGRectMake(buttonPosition.x, buttonPosition.y, 100, 100)
                                        inView:self.view
                      permittedArrowDirections:UIPopoverArrowDirectionDown
                                      animated:YES];
}
@end

//–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

@implementation KBAChooseDailyAccountController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:NSStringFromClass([self class])
                           bundle: nil];
    
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

@end


//–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

@implementation KBAChooseTermAccountController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:NSStringFromClass([self class])
                           bundle:nil] ;

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

@end

