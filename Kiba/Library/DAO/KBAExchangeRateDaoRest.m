//
//  KBAExchangeRateDaoRest.m
//  Kiba
//
//  Created by 1fasselt on 10.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAExchangeRateDaoRest.h"
#import "Currency.h"

@interface KBAExchangeRateDaoRest ()

@property Currency *currentCurrency;
@property NSMutableArray *currencies;

@end

@implementation KBAExchangeRateDaoRest

- (NSArray*) getExchangeRates {
    
    if(self.currencies == nil) {
        self.currencies = [[NSMutableArray alloc] init];
    
        NSURL *url = [[NSURL alloc] initWithString:@"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"];
        NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
        [parser setDelegate:self];
        BOOL success = [parser parse];
    
        if (!success) {
            NSLog(@"E∞rror Loading Exchange Rates!");
            return nil;
        }
    }
    
    // return NSArray (non mutable=
    return [[NSArray alloc] initWithArray:self.currencies];
};


- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if ([elementname isEqualToString:@"Cube"] && attributeDict.count == 2) // there are multiple cube elements, but select that one with two attributes (currency & rate)
    {
        NSString *code = [attributeDict valueForKey:@"currency"];
        float rate = [[attributeDict valueForKey:@"rate"] floatValue];
        
		self.currentCurrency = [[Currency alloc] initWithCode:code rate:rate];
	}
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if (self.currentCurrency != nil) {
        [self.currencies addObject:self.currentCurrency];
        self.currentCurrency = nil;
        
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
}

@end
