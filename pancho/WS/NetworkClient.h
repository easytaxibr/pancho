//
//  NetworkClient.h
//  pancho
//
//  Created by Ezequiel on 5/29/16.
//  Copyright © 2016 Easy Taxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@protocol NetworkClientDelegate <NSObject>
- (void)receivedResult:(id)resultDictionary;
- (void)failedResult;
@end

@interface NetworkClient : NSObject <NSURLConnectionDelegate> {
    
    
}

typedef void (^CallbackBlock)(id responseObj, NSURLSessionTask *task, NSError *error);
@property (copy) CallbackBlock callback;
@property (nonatomic, assign) id <NetworkClientDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;


#pragma mark - Class Methods

+ (id)shared;

#pragma mark - NetworkCLient Methods

- (void)GET:(NSString *)url
atGetParameter:(NSDictionary *)parameters
    atBlock:(CallbackBlock)block
      atKey:(NSString *)keyString;

- (void)POST:(NSString *)apiQuery
  atPostBody:(NSDictionary *)postBody
     atBlock:(CallbackBlock)block
       atKey:(NSString *)keyString;

@end