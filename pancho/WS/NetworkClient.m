//
//  NetworkClient.m
//  pancho
//
//  Created by Ezequiel on 5/29/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import "NetworkClient.h"

@implementation NetworkClient

@synthesize delegate;
@synthesize callback;
@synthesize responseData;


- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (id)shared{
    static NetworkClient *sharedNetworkClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworkClient = [[self alloc] init];
    });
    return sharedNetworkClient;
}

#pragma mark
#pragma mark - NetworkClient Methods -


- (void)GET:(NSString *)url
atGetParameter:(NSDictionary *)parameters
    atBlock:(CallbackBlock)block
      atKey:(NSString *)keyString{
    
    self.callback = block;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [self.delegate receivedResult:responseObject];
        self.callback(responseObject, task, nil);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self.delegate failedResult];
        self.callback(nil, operation, error);
        NSLog(@"Error: %@", error);
    }];
    
    
}

- (void)POST:(NSString *)apiQuery
  atPostBody:(NSDictionary *)postBody
     atBlock:(CallbackBlock)block
       atKey:(NSString *)keyString{
    
    self.callback = block;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:apiQuery parameters:postBody progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        self.callback(responseObject, task, nil);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        self.callback(nil, operation, error);
    }];
}
@end
