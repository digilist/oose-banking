//
//  KBAFinanceController.m
//  Kiba
//
//  Created by 1jendryc on 07.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAFinanceController.h"

@interface KBAFinanceController ()

@property (nonatomic, weak) IBOutlet UISlider *sumSlider;
@property (nonatomic, weak) IBOutlet UISlider *lengthSlider;
@property (nonatomic, weak) IBOutlet UISlider *interestSlider;
@property (nonatomic, weak) IBOutlet UISlider *rateSlider;

@property (nonatomic, weak) IBOutlet UILabel *sumLabel;
@property (nonatomic, weak) IBOutlet UILabel *lengthLabel;
@property (nonatomic, weak) IBOutlet UILabel *interestLabel;
@property (nonatomic, weak) IBOutlet UILabel *rateLabel;
@property (nonatomic, weak) IBOutlet UILabel *creditSum;

@property double interest;
@property int length;
@property int sum;
@property float rate;
@property float credit;


@property NSDictionary *sliderLabel;
@property NSDictionary *sliderLabel2;
@property NSDictionary *creditInterest;


@end

@implementation KBAFinanceController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateValue:self.sumSlider];
    [self updateValue:self.lengthSlider];
    [self updateValue:self.interestSlider];
    [self updateValue:self.rateSlider];
    [self updateAllValues];
    [self calculateCreditSum];
    [self calculateRate];
    

    
    NSLog(@"%f, %d, %d, %f" , self.interest, self. length, self.sum, self.rate);

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  initiates the dictionary
 */
-(void)initDic {
    self.sliderLabel = [NSDictionary dictionaryWithObjectsAndKeys:
                        self.sumLabel, @"sum", self.lengthLabel, @"length", self.interestLabel, @"interest", self.rateLabel, @"rate", nil];

    // initiliaze interests
    NSNumber *a = [[NSNumber alloc]initWithDouble:65];
    NSNumber *b = [[NSNumber alloc]initWithDouble:66];
    NSNumber *d = [[NSNumber alloc]initWithDouble:67];
    NSNumber *e = [[NSNumber alloc]initWithDouble:68];
    NSNumber *f = [[NSNumber alloc]initWithDouble:69];
    NSNumber *g = [[NSNumber alloc]initWithDouble:70];
    NSNumber *h = [[NSNumber alloc]initWithDouble:71];
    NSNumber *i = [[NSNumber alloc]initWithDouble:72];
    NSNumber *j = [[NSNumber alloc]initWithDouble:73];
    NSNumber *k = [[NSNumber alloc]initWithDouble:74];
    NSNumber *l = [[NSNumber alloc]initWithDouble:75];
    NSNumber *m = [[NSNumber alloc]initWithDouble:76];
    NSNumber *n = [[NSNumber alloc]initWithDouble:77];
    NSNumber *o = [[NSNumber alloc]initWithDouble:78];
    NSNumber *p = [[NSNumber alloc]initWithDouble:79];
    NSNumber *q = [[NSNumber alloc]initWithDouble:80];
    NSNumber *s = [[NSNumber alloc]initWithDouble:81];
    NSNumber *t = [[NSNumber alloc]initWithDouble:82];
    NSNumber *u = [[NSNumber alloc]initWithDouble:83];
    NSNumber *w = [[NSNumber alloc]initWithDouble:84];
    NSNumber *x = [[NSNumber alloc]initWithDouble:85];
    NSNumber *y = [[NSNumber alloc]initWithDouble:86];
    NSNumber *z = [[NSNumber alloc]initWithDouble:87];
    NSNumber *aa = [[NSNumber alloc]initWithDouble:88];
    NSNumber *ab = [[NSNumber alloc]initWithDouble:89];
    NSNumber *ba = [[NSNumber alloc]initWithDouble:90];
    NSNumber *bb = [[NSNumber alloc]initWithDouble:91];
    NSNumber *ca = [[NSNumber alloc]initWithDouble:92];

    
    self.creditInterest = [NSDictionary dictionaryWithObjectsAndKeys:
                           a, [NSNumber numberWithInt:3] , b, [NSNumber numberWithInt:4], d, [NSNumber numberWithInt:5], e, [NSNumber numberWithInt:6], f, [NSNumber numberWithInt:7], g, [NSNumber numberWithInt:8], h, [NSNumber numberWithInt:9], i, [NSNumber numberWithInt:10], j, [NSNumber numberWithInt:11], k, [NSNumber numberWithInt:12], l, [NSNumber numberWithInt:13], m, [NSNumber numberWithInt:14], n, [NSNumber numberWithInt:15], o, [NSNumber numberWithInt:16], p, [NSNumber numberWithInt:17], q, [NSNumber numberWithInt:18], s, [NSNumber numberWithInt:19], t, [NSNumber numberWithInt:20], u, [NSNumber numberWithInt:21], w, [NSNumber numberWithInt:22], x, [NSNumber numberWithInt:23], y, [NSNumber numberWithInt:24], z, [NSNumber numberWithInt:25], aa, [NSNumber numberWithInt:26], ab, [NSNumber numberWithInt:27], ba, [NSNumber numberWithInt:28], bb, [NSNumber numberWithInt:29], ca, [NSNumber numberWithInt:30], nil];
}
/**
 *  updates the label values of given slider.
 *
 *  @param slider the currently used slider
 */
- (void)updateValue: (UISlider *) slider {
    [self initDic];
    UILabel *label = ((UILabel*) [self.sliderLabel objectForKey:slider.restorationIdentifier]);
    NSString *value = [NSString stringWithFormat: @"%d %@", (int)slider.value, label.restorationIdentifier];
    if ([slider isEqual:self.interestSlider]) {
        label.text = [NSString stringWithFormat: @"%0.1f %%", (double)slider.value/10];
    }
    else if ([slider isEqual:self.rateSlider]) {
        label.text = [NSString stringWithFormat: @"%0.2f €", (double)slider.value];
    }
    else {
        label.text = value;
    }
  int lab2 = [[self.sliderLabel allValues]count];
   NSLog(@"%@ , %d", value, lab2);
    
  
    
}



-(void)updateAllValues{
    self.interest = (double)(round(self.interestSlider.value)/1000);
    self.length = self.lengthSlider.value;
    self.sum = (int)self.sumSlider.value;
    self.rate = self.rateSlider.value;
    
    
}
/**
 *  Calculates the other values when the rate slider is moved
 */
-(void)calculateYears{
 //   float b = (self.sum/((1/self.interest)*(1-(1/(pow((1+self.interest),self.length))))));
    int length = - (log(1-((self.interest*self.sum)/self.rate))/(log(1+self.interest)));
    self.lengthSlider.value = length;
    [self updateValue:self.lengthSlider];
    
    
        
    
}

-(void)calculateCreditSum{
    self.credit = self.sum * (self.interest*pow((1+self.interest),self.length) )/(pow((1+self.interest),self.length) -1) * self.length;
    self.creditSum.text = [NSString stringWithFormat:@"%0.f €", self.credit];
 

    
}

-(void)calculateRate{
    
    self.rate = (float) self.credit / self.length;
    self.rateSlider.value = self.rate;
    [self updateValue:self.rateSlider];
    
    
}

-(void)calculateInterest{
//Kalkulation
   self.interestSlider.value = [[self.creditInterest objectForKey: [NSNumber numberWithInt:self.length ]] doubleValue];
    [self updateValue:self.interestSlider];
    
      NSLog(@"%f@" , self.interest);

    
    
}

-(IBAction)scheduleYears{
    [self updateAllValues];
    [self calculateRate];
    [self calculateInterest];
    [self calculateCreditSum];
    [self updateValue:self.lengthSlider];
}

-(IBAction)scheduleInterest{
    [self updateAllValues];
    [self calculateRate];
    [self calculateYears];
    [self calculateCreditSum];
    [self updateValue:self.interestSlider];
}

-(IBAction)scheduleCreditSum{
    [self updateAllValues];
    [self calculateRate];
    [self calculateInterest];
  //  [self calculateYears];
    [self calculateCreditSum];
    self.creditSum.text = [NSString stringWithFormat:@"%0.f €", self.credit];
    [self updateValue:self.sumSlider];
}

-(IBAction)scheduleRate{
    [self updateAllValues];
    [self calculateYears];
    [self calculateInterest];
    [self calculateCreditSum];
    [self updateValue:self.rateSlider];
}


@end
