//
//  KBACreditRatingDaoDummy.m
//  Kiba
//
//  Created by Marco F. Jendryczko on 16.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBACreditRatingDaoDummy.h"

@implementation KBACreditRatingDaoDummy

-(CreditRating*) getCreditRating{
    
    CreditRating *newRating = [CreditRating new];
    
    // initiliaze interests
    NSNumber *a = [[NSNumber alloc]initWithDouble:65];
    NSNumber *b = [[NSNumber alloc]initWithDouble:64];
    NSNumber *d = [[NSNumber alloc]initWithDouble:63];
    NSNumber *e = [[NSNumber alloc]initWithDouble:62];
    NSNumber *f = [[NSNumber alloc]initWithDouble:61];
    NSNumber *g = [[NSNumber alloc]initWithDouble:60];
    NSNumber *h = [[NSNumber alloc]initWithDouble:59];
    NSNumber *i = [[NSNumber alloc]initWithDouble:58];
    NSNumber *j = [[NSNumber alloc]initWithDouble:57];
    NSNumber *k = [[NSNumber alloc]initWithDouble:56];
    NSNumber *l = [[NSNumber alloc]initWithDouble:55];
    NSNumber *m = [[NSNumber alloc]initWithDouble:54];
    NSNumber *n = [[NSNumber alloc]initWithDouble:53];
    NSNumber *o = [[NSNumber alloc]initWithDouble:52];
    NSNumber *p = [[NSNumber alloc]initWithDouble:51];
    NSNumber *q = [[NSNumber alloc]initWithDouble:50];
    NSNumber *s = [[NSNumber alloc]initWithDouble:49];
    NSNumber *t = [[NSNumber alloc]initWithDouble:48];
    NSNumber *u = [[NSNumber alloc]initWithDouble:47];
    NSNumber *w = [[NSNumber alloc]initWithDouble:46];
    NSNumber *x = [[NSNumber alloc]initWithDouble:45];
    NSNumber *y = [[NSNumber alloc]initWithDouble:44];
    NSNumber *z = [[NSNumber alloc]initWithDouble:43];
    NSNumber *aa = [[NSNumber alloc]initWithDouble:42];
    NSNumber *ab = [[NSNumber alloc]initWithDouble:41];
    NSNumber *ba = [[NSNumber alloc]initWithDouble:40];
    NSNumber *bb = [[NSNumber alloc]initWithDouble:39];
    NSNumber *ca = [[NSNumber alloc]initWithDouble:38];
    
    
    newRating.financingMatrix = [NSDictionary dictionaryWithObjectsAndKeys:
                                 a, [NSNumber numberWithInt:3] , b, [NSNumber numberWithInt:4], d, [NSNumber numberWithInt:5], e, [NSNumber numberWithInt:6], f, [NSNumber numberWithInt:7], g, [NSNumber numberWithInt:8], h, [NSNumber numberWithInt:9], i, [NSNumber numberWithInt:10], j, [NSNumber numberWithInt:11], k, [NSNumber numberWithInt:12], l, [NSNumber numberWithInt:13], m, [NSNumber numberWithInt:14], n, [NSNumber numberWithInt:15], o, [NSNumber numberWithInt:16], p, [NSNumber numberWithInt:17], q, [NSNumber numberWithInt:18], s, [NSNumber numberWithInt:19], t, [NSNumber numberWithInt:20], u, [NSNumber numberWithInt:21], w, [NSNumber numberWithInt:22], x, [NSNumber numberWithInt:23], y, [NSNumber numberWithInt:24], z, [NSNumber numberWithInt:25], aa, [NSNumber numberWithInt:26], ab, [NSNumber numberWithInt:27], ba, [NSNumber numberWithInt:28], bb, [NSNumber numberWithInt:29], ca, [NSNumber numberWithInt:30], nil];
    
    return newRating;
}

@end
