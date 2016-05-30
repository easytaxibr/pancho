//
//  TaxiClient.m
//  pancho
//
//  Created by Ezequiel on 5/30/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import "TaxiClient.h"

@implementation TaxiClient

+ (id)shared{
    static TaxiClient *sharedTaxiClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTaxiClient = [[self alloc] init];
    });
    return sharedTaxiClient;
}

@end
