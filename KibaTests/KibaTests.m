//
//  KibaTests.m
//  KibaTests
//
//  Created by Konstantin Möllers.
//  Copyright (c) 2014 Projekt Kiba. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KBABootstrap.h"
#import "KBADependencyInjector.h"
#import "KBAAuth.h"

@interface KibaTests : XCTestCase

@end

@implementation KibaTests

/**
 *  Diese Methode wird vor jedem Test ausgeführt.
 */
- (void)setUp
{
    [super setUp];
    // Bootstrap der App
    [KBABootstrap bootstrap];
}

/**
 *  Diese Methode wird nach jedem Test ausgeführt.
 */
- (void)tearDown
{
    [super tearDown];
}

/**
 *  Testet, ob die Abhängigkeit für die
 *  Authentifizierung korrekt eingebunden wurde.
 */
- (void)testAuthDependency
{
    XCTAssert([KBADependencyInjector hasDependency:@"auth"],
              @"Auth dependency is missing!");
    XCTAssert([[KBADependencyInjector getByKey:@"auth"] isKindOfClass:[KBAAuth class]],
              @"Auth depdency is not a valid Auth object!");
}

@end
