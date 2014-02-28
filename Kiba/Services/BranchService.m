//
//  BranchService.m
//  Kiba
//
//  Created by Marco F. Jendryczko on 05.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "BranchService.h"

@implementation BranchService

/**
 *  Verarbeitet eine Transaktion
 *
 *  @param trans    Die Transaktion

 */
+(void)doTransaction: (Transaction*) trans{
    trans.sender.balance =  [trans.sender.balance initWithLong: [trans.sender.balance longValue] - [trans.amount longValue]];
    trans.recipient.balance =  [trans.recipient.balance initWithLong: [trans.recipient.balance longValue] - [trans.amount longValue]];
    
}

@end
