//
//  KBADashboardControllerViewController.m
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 19.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBADashboardController.h"
#import "KBADependencyInjector.h"
#import "KBAAccountDao.h"
#import "KBATransactionDao.h"
#import "KBAAuth.h"
#import "Transaction.h"

@interface KBADashboardController ()

@property id<KBATransactionDao> transactionDao;
@property id<KBAAccountDao> accountDao;
@property KBAAuth *auth;

@end

@implementation KBADashboardController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

/**
 *  Loads all necessary files to display the dashboard 
 *  html view.
 */
- (void)loadHTMLContent
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Assets/html/dashboard" withExtension:@"html"];
    NSString *html = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [self.webView loadHTMLString:html baseURL:baseURL];
    
    self.webView.scalesPageToFit = NO;
    self.webView.multipleTouchEnabled = NO;
    self.webView.delegate = self;
}

/**
 *  When the view was loaded.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.splitViewController.delegate = self;
    [self loadHTMLContent];
    self.transactionDao = [KBADependencyInjector getByKey:@"transDao"];
    self.accountDao = [KBADependencyInjector getByKey:@"accountDao"];
    self.auth = [KBADependencyInjector getByKey:@"auth"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
    navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *action = request.mainDocumentURL.lastPathComponent;
    return [self onWebViewLinkClickedWithAction:action];
}
    
/**
 *  Will be executed when the User performs an action in the web view.
 *
 *  @param action The action called by the user.
 *
 *  @return If YES, the request will be performed.
 */
- (BOOL)onWebViewLinkClickedWithAction:(NSString *)action
{
    // Check the detail buttons here …
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSArray *transactions = [self.transactionDao transactionsForCustomer:self.auth.identity];

    [self passIdentityToWebView];
    [self passTurnoverToWebViewWithTransactions:transactions];
    [self passTransactionsToWebView:transactions];
    [self passBalanceToWebView];
}

- (void)passBalanceToWebView {
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.decimalSeparator = @",";
    formatter.minimumFractionDigits = 2;
    formatter.maximumFractionDigits = 2;
    [self passDataToWebView:@"setBalance"
              withParameter:@{@"balance":[NSString stringWithFormat:@"%@ €",
                              [formatter stringFromNumber:self.auth.identity.balance]]}];
}

/**
 *  Passes the current logged in identity to the web view.
 */
- (void)passIdentityToWebView
{
    Customer *identity = self.auth.identity;
    NSDictionary *identityDic = @{@"id": [NSNumber numberWithInt:identity.userId],
                                  @"forename": identity.forename,
                                  @"surname": identity.surname,
                                  @"fullName": identity.fullName};
    [self passDataToWebView:@"setIdentity" withParameter:identityDic];
}

/**
 *  Finds an date amount array by transactions.
 *
 *  @param identity     <#identity description#>
 *  @param transactions <#transactions description#>
 *  @param accounts     <#accounts description#>
 *
 *  @return <#return value description#>
 */
- (NSMutableDictionary *)dateAmountArrayByIdentity:(Customer *)identity
                                   andTransactions:(NSArray *)transactions
                                    havingAccounts:(NSMutableArray *)accounts
{
    NSMutableDictionary *jsonableTransactions = [NSMutableDictionary new];
    
    for (Transaction *transaction in transactions) {
        if (identity == transaction.sender.owner) {
            [self addToAccounts:accounts
           jsonableTransactions:jsonableTransactions
                    transaction:transaction
                         amount:transaction.amount
                        account:transaction.sender];
        }
        if (identity == transaction.recipient.owner) {
            [self addToAccounts:accounts
           jsonableTransactions:jsonableTransactions
                    transaction:transaction
                         amount:[NSNumber numberWithDouble:-transaction.amount.doubleValue]
                        account:transaction.recipient];
        }
    }
    
    // Sort transactions
    NSMutableDictionary *result = [NSMutableDictionary new];
    for (NSString *key in jsonableTransactions) {
        NSMutableArray *values = [jsonableTransactions valueForKey:key];
        NSArray *sortedValues = [values sortedArrayUsingComparator:^NSComparisonResult(NSArray *a, NSArray *b) {
            NSNumber *first, *second;
            first = [a firstObject];
            second = [b firstObject];
            
            return [second compare:first];
        }];
        [result setValue:[NSMutableArray arrayWithArray:sortedValues] forKey:key];
    }
    
    return result;
}

/**
 *
 */
- (void)addToAccounts:(NSMutableArray *)accounts
 jsonableTransactions:(NSMutableDictionary *)jsonableTransactions
          transaction:(Transaction *)transaction
               amount:(NSNumber *)amount
              account:(Account *)account
{
    NSString *key = account.description;
    NSMutableArray *values = [jsonableTransactions valueForKey:key];
    if (!values) {
        values = [NSMutableArray new];
        [accounts addObject:account];
        [jsonableTransactions setValue:values forKey:key];
    }

    [values addObject:@[@(transaction.date.timeIntervalSince1970 * 1000), amount]];
}

/**
 *  Passes the turn over to web view.
 *
 *  @param transactions
 */
- (void)passTurnoverToWebViewWithTransactions:(NSArray *)transactions
{
    NSMutableArray *accounts    = [NSMutableArray new];
    NSMutableArray *results     = [NSMutableArray new];
    
    Customer *identity = self.auth.identity;
    
    // Finds transactions by an identity for transactions.
    NSMutableDictionary *jsonableTransactions = [self dateAmountArrayByIdentity:identity andTransactions:transactions havingAccounts:accounts];
    
    double currentDate = floor([[NSDate new] timeIntervalSince1970] / 86400) * 86400000;
    double lastDate = currentDate - 2592000000;
    
    // Inits the result dictionary with the account balance
    for (Account *account in accounts) {
        [results addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"label": account.description,
                             @"data": [NSMutableArray new],
                             @"lastValue": account.balance}]];
    }
    
    // Iterate over all dates
    while (currentDate >= lastDate) {

        // Iterate over all accounts
        for (NSDictionary *accountDic in results) {
            NSString *accountName = [accountDic valueForKey:@"label"];
            NSNumber *lastValue = [accountDic valueForKey:@"lastValue"];
            NSMutableArray *array = [jsonableTransactions valueForKey:accountName];
            BOOL shallContinue;
            
            // Find all transactions of an account for currentDate
            do {
                NSArray *firstData = [array firstObject];
                NSNumber *foundDate = [firstData firstObject];
                shallContinue = NO;
                
                if (foundDate.doubleValue >= currentDate + 86400000) {
                    NSNumber *firstDataAmount = [firstData lastObject];
                    lastValue = [NSNumber numberWithDouble:lastValue.doubleValue + firstDataAmount.doubleValue];
                    
                    [array removeObject:firstData];
                    
                    shallContinue = YES;
                }
            } while (shallContinue);
            
            // Add data entry for currentDate
            NSMutableArray *data = [accountDic valueForKey:@"data"];
            [data addObject:@[@(currentDate), lastValue]];
            
            [accountDic setValue:lastValue forKey:@"lastValue"];
        }

        currentDate -= 86400000;
    }
    
    [self passDataToWebView:@"lineChartIt" withParameter:results];
}

/**
 *  Passes Transactions to web view.
 */
- (void)passTransactionsToWebView:(NSArray *)transactions
{
    NSArray *sortedArray;
    NSMutableArray *jsonableTransactions = [NSMutableArray arrayWithCapacity:transactions.count];
    Customer *identity = self.auth.identity;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    [numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"]];
    
    for (Transaction *transaction in transactions) {
        NSString *name, *account;
        NSNumber *debit, *credit;
        
        if (identity == transaction.recipient.owner) {
            if (identity == transaction.sender.owner) {
                name = identity.fullName;
                account = [NSString stringWithFormat:@"Umbuchung auf %@", transaction.recipient];
                credit = transaction.amount;
                debit = transaction.amount;
            }
            else {
                name = transaction.sender.owner.fullName;
                account = transaction.recipient.description;
                credit = transaction.amount;
                debit = @0.0;
            }
        }
        else {
            name = transaction.recipient.owner.fullName;
            account = transaction.sender.description;
            debit = transaction.amount;
            credit = @0.0;
        }
            
        [jsonableTransactions addObject:@{
            @"date": [dateFormatter stringFromDate:transaction.date],
            @"account": account,
            @"debit": [numberFormatter stringFromNumber:debit],
            @"credit": [numberFormatter stringFromNumber:credit],
            @"name": name
        }];
    }
    
    sortedArray = [jsonableTransactions sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *a, NSDictionary *b) {
        NSString *first, *second;
        first = [a valueForKey:@"date"];
        second = [b valueForKey:@"date"];
        
        return [[dateFormatter dateFromString:second] compare:[dateFormatter dateFromString:first]];
    }];
    
    [self passDataToWebView:@"setTransactions" withParameter:sortedArray];
}

/**
 *  Passes some data to the web view.
 *
 *  @param method The java script method.
 *  @param data   The data to pass.
 *
 *  @return whether passing succeeded.
 */
- (BOOL)passDataToWebView:(NSString *)method withParameter:(id)data
{
    NSError *error;
    NSData *json = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!error) {
        NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
        NSString *jsCall = [NSString stringWithFormat:@"%@(%@)", method, jsonString];
        [self.webView stringByEvaluatingJavaScriptFromString:jsCall];
        
        return YES;
    }
    
    return NO;
}

@end
