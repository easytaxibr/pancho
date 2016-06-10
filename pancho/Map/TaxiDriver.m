//
//  TaxiDriver.m
//  pancho
//
//  Created by Lidia Chou on 6/7/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import "TaxiDriver.h"

@implementation TaxiDriver

static id taxiId;

@synthesize lastCoordinate, newCoordinate, pinView;

+ (id)sharedManager {
    static TaxiDriver *sharedTaxi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTaxi = [[self alloc] init];
    });
    return sharedTaxi;
}

- (id)init {
    if (self = [super init]) {
        lastCoordinate = CLLocationCoordinate2DMake(0, 0);
        newCoordinate = CLLocationCoordinate2DMake(0, 0);
    }
    return self;
}

- (void)dealloc {
}

@end
