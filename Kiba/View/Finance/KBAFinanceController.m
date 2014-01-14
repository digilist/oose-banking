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
@property int sliderValue;

@property NSDictionary *sliderLabel;
@property NSDictionary *sliderLabel2;
@property NSDictionary *creditInterest;
@property NSMutableArray *sliderSteps;



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
    //Datenstruktur
    self.sliderSteps = [[NSMutableArray alloc] init];
  
    
    [self updateValue:self.sumSlider];
    [self updateValue:self.lengthSlider];
    [self updateValue:self.interestSlider];
    
    [self initUpdate];
    
    [self calculateSliderSteps];
    
    [self updateAllValues];
    [self updateValue:self.rateSlider];
    
    
    [self calculateCreditSum];
    [self calculateRate];
    NSLog(@"%f" ,self.rate);
    [self calculateInterest];
    //[self calculateRateLimits];
    
    self.rateSlider.minimumValue = 0;
    self.rateSlider.maximumValue = self.lengthSlider.maximumValue - self.lengthSlider.minimumValue;
    NSLog(@"%f, %f",self.rateSlider.minimumValue, self.rateSlider.maximumValue );

    
    self.rate = [[self.sliderSteps objectAtIndex:self.length] floatValue] ;
    

    
        for (NSNumber *a in self.sliderSteps) {
            NSLog(@"%f %d",a.floatValue, self.sliderSteps.count);
    
    }
    

    
    NSLog(@"%f, %d, %d, %f" , self.rateSlider.value, self. length, self.sum, self.rate);

}

-(void)initUpdate {
    
    self.interest = (double)(round(self.interestSlider.value)/1000);
    self.length = self.lengthSlider.value;
    self.sum = (int)self.sumSlider.value;
    
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
        label.text = [NSString stringWithFormat: @"%0.2f €", [[self.sliderSteps objectAtIndex: ((int)slider.value)] floatValue] ];
    }
    else {
        label.text = value;
    }
 
 // NSLog(@"%@" , value);
    
  
    
}



-(void)updateAllValues{
    self.interest = (double)(round(self.interestSlider.value)/1000);
    self.length = self.lengthSlider.value;
    self.sum = (int)self.sumSlider.value;
    self.rate = [[self.sliderSteps objectAtIndex: ((int) self.rateSlider.value)]floatValue];
    
  //  NSLog(@"%f, %d, %d, %f" , self.interest, self. length, self.sum, self.rate);
    
}
/**
 *  Calculates the other values when the rate slider is moved
 */
-(void)calculateYears{
 
  
     // int length = - (log(1-((self.interest*self.sum)/self.rate))/(log(1+self.interest)));
    self.length = self.lengthSlider.maximumValue - (int) self.rateSlider.value;;
    self.lengthSlider.value = self.length;
    [self updateValue:self.lengthSlider];
     NSLog(@"%f, %d %f" , self.rate,self.length, self.rateSlider.value);
    
    
        
    
}

-(void)calculateCreditSum{
    self.credit = self.sum * (self.interest*pow((1+self.interest),self.length) )/(pow((1+self.interest),self.length) -1) * self.length;
    self.creditSum.text = [NSString stringWithFormat:@"%0.f €", self.credit];
 

    
}

-(void)calculateRate{
    
//    self.rate = (float) self.credit / self.length;
//    self.rateSlider.value = self.rate;
  //  NSLog(@"%f, %d %f" , self.rate,self.length, self.rateSlider.value);
    self.rate = [[self.sliderSteps objectAtIndex:(self.lengthSlider.maximumValue - (int)self.length)] floatValue] ;
    self.rateSlider.value = self.lengthSlider.maximumValue - (int)self.length;
    [self updateValue:self.rateSlider];
   // NSLog(@"%f, %d %f" , self.rate,self.length, self.rateSlider.value);
    
}

-(void)calculateInterest{
    self.interest = [[self.creditInterest objectForKey: [NSNumber numberWithInt:self.length ]] doubleValue]/1000;
    self.interestSlider.value = [[self.creditInterest objectForKey: [NSNumber numberWithInt:self.length ]] doubleValue];
    [self updateValue:self.interestSlider];
    
    
}

-(IBAction)scheduleYears{
    [self updateAllValues];
    [self calculateInterest];
    [self calculateRate];
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
    [self calculateSliderSteps];
    [self calculateRate];
    [self calculateInterest];
  //  [self calculateYears];
    [self calculateCreditSum];
    self.creditSum.text = [NSString stringWithFormat:@"%0.f €", self.credit];
   // [self calculateRateLimits];
    [self updateValue:self.sumSlider];
}

-(IBAction)scheduleRate{
    [self updateAllValues];
  // NSLog(@" 1 -> %d", self.length);
    [self calculateCreditSum];
    //  NSLog(@" 2 -> %d", self.length);
    [self calculateYears];
     //  NSLog(@" 3 -> %d", self.length);
    [self calculateInterest];
     //   NSLog(@" 4 -> %d", self.length);
    [self updateValue:self.rateSlider];
}

-(void)calculateRateLimits{
    
    double longInterest = [[self.creditInterest objectForKey: [NSNumber numberWithInt:self.lengthSlider.maximumValue ]] doubleValue]/1000;
    double shortInterest = [[self.creditInterest objectForKey: [NSNumber numberWithInt:self.lengthSlider.minimumValue ]] doubleValue]/1000;
    
    float longCredit = self.sum * (longInterest*pow((1+longInterest),30) )/(pow((1+longInterest),30) -1) * 30;
    float shortCredit = self.sum * (shortInterest*pow((1+shortInterest),3) )/(pow((1+shortInterest),3) -1) * 3;
    
    float minRate = (float) longCredit / 30;
    float maxRate = (float) shortCredit / 3;
    
    self.rateSlider.minimumValue = minRate;
    self.rateSlider.maximumValue = maxRate;
  //  NSLog(@"MinRate: %f ; MaxRate: %f", minRate, maxRate);
}

-(void)calculateSliderSteps{
    NSMutableArray *newSteps = [[NSMutableArray alloc]init];
    for (int a = self.lengthSlider.maximumValue; a>=0; a--) {
        if(a >= (self.lengthSlider.minimumValue))
        {
            double currenInterest = [[self.creditInterest objectForKey: [NSNumber numberWithInt:a ]] doubleValue]/1000;
            
        float c = self.sum * (currenInterest*pow((1+currenInterest),a) )/(pow((1+currenInterest),a) -1) * a / a;
            [newSteps insertObject:[NSNumber numberWithFloat:c] atIndex:30-a];
        }
        else
        {
            [newSteps insertObject:[NSNumber numberWithFloat:0] atIndex:30-a];
        }
        }
    self.sliderSteps = newSteps;
    
}



@end
