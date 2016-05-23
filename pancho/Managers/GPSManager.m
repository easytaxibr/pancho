
#import "GPSManager.h"
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface GPSManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) GPSLocationBlockType handler;

@end

@implementation GPSManager

+ (instancetype)sharedManager {
    static GPSManager * sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    return self;
}

- (void)askForPermition {
    [self.locationManager requestWhenInUseAuthorization];
}

- (void)myLocation:(GPSLocationBlockType)completion {
    self.handler = [completion copy];
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations firstObject];
    
    NSTimeInterval diff = [[NSDate date] timeIntervalSinceDate:location.timestamp];
    if (diff <= 60) {
        if (self.handler) {
            GPSLocationBlockType block = [self.handler copy];
            block(location, nil);
            self.handler = nil;
        }
        [self.locationManager stopUpdatingLocation];
    }
}

@end
