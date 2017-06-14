//
//  locationUpdateManager.m
//  BackGround
//
//  Created by Anchlate Lee on 16/7/10.
//  Copyright © 2016年 Anchlate. All rights reserved.
//

#import "ANLocationUpdateManager.h"

@interface ANLocationUpdateManager() <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *standardlocationManager;
@property (strong, nonatomic) NSDate *lastTimestamp;
@end

@implementation ANLocationUpdateManager

+ (instancetype)sharedStandardManager1
{
    static ANLocationUpdateManager* sharedStandardInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStandardInstance = [[self alloc]initStandard];
    });
    return sharedStandardInstance;
}

- (id)initStandard
{
    if (self = [super init])
    {
        // 初始化工作
        self.standardlocationManager = [[CLLocationManager alloc]init];
        self.standardlocationManager.desiredAccuracy = kCLLocationAccuracyBest; //kCLLocationAccuracyHundredMeters better battery life
        self.standardlocationManager.delegate = self;
        self.standardlocationManager.pausesLocationUpdatesAutomatically = NO; // this is important
        //self.standardlocationManager.distanceFilter = 10;//距离过滤
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
            [self.standardlocationManager requestAlwaysAuthorization];//在后台也可定位
        }
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
            self.standardlocationManager.allowsBackgroundLocationUpdates = YES;
        }
    }
    return self;
}

- (void)startStandardUpdatingLocation
{
    NSLog(@"startStandardUpdatingLocation");
    [self.standardlocationManager startUpdatingLocation];
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

- (void)stopStandardUpdatingLocation
{
    NSLog(@"stopStandardUpdatingLocation");
    [self.standardlocationManager stopUpdatingLocation];
}

#pragma mark - 定位代理函数
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *mostRecentLocation = locations.lastObject;
}

- (void)timeChange {
    
    NSLog(@",,,,,,,,,,");
    
}
@end
