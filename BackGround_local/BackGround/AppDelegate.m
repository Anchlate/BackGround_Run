//
//  AppDelegate.m
//  BackGround
//
//  Created by Anchlate Lee on 16/7/10.
//  Copyright © 2016年 Anchlate. All rights reserved.
//

#import "AppDelegate.h"

#import "ANLocationUpdateManager.h"

#define WEAKSELF(weakSelf) __weak __typeof(&*self)weakSelf = self

@interface AppDelegate ()<CLLocationManagerDelegate>
/*
{
    CLLocationManager *locationManager;
}
@property (assign, nonatomic) UIBackgroundTaskIdentifier bgTask;

@property (strong, nonatomic) dispatch_block_t expirationHandler;
@property (assign, nonatomic) BOOL jobExpired;
@property (assign, nonatomic) BOOL background;
*/

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
    UIApplication* app = [UIApplication sharedApplication];
    
    WEAKSELF(weakSelf);
    
    self.expirationHandler = ^{  //创建后台自唤醒，当180s时间结束的时候系统会调用这里面的方法
        [app endBackgroundTask:weakSelf.bgTask];
        weakSelf.bgTask = UIBackgroundTaskInvalid;
        weakSelf.bgTask = [app beginBackgroundTaskWithExpirationHandler:weakSelf.expirationHandler];
        NSLog(@"Expired");
        weakSelf.jobExpired = YES;
        while(weakSelf.jobExpired)
        {
            // spin while we wait for the task to actually end.
            NSLog(@"等待180s循环进程的结束");
            [NSThread sleepForTimeInterval:1];
        }
        // Restart the background task so we can run forever.
        [weakSelf startBackgroundTask];
    };
    
    // Assume that we're in background at first since we get no notification from device that we're in background when
    // app launches immediately into background (i.e. when powering on the device or when the app is killed and restarted)
    [self monitorBatteryStateInBackground];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    */
    
    
    
    
    ANLocationUpdateManager *manager = [ANLocationUpdateManager sharedStandardManager1];
    [manager startStandardUpdatingLocation];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    /*
    UIApplication *app = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
            
        });
    }];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
            
        });
        
    });
    */
    
    /*
    if(YES)//当登陆状态才启动后台操作
    {
        self.bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:self.expirationHandler];
        NSLog(@"Entered background");
        [self monitorBatteryStateInBackground];
    }
     */
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    
}


#pragma mark -LocationDelegate
/*
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error//当定位服务不可用出错时，系统会自动调用该函数
{
    NSLog(@"定位服务出错");
    if([error code]==kCLErrorDenied)//通过error的code来判断错误类型
    {
        //Access denied by user
        NSLog(@"定位服务未打开");
//        [InterfaceFuncation ShowAlertWithMessage:@"错误" AlertMessage:@"未开启定位服务\n客户端保持后台功能需要调用系统的位置服务\n请到设置中打开位置服务" ButtonTitle:@"好"];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"错误" message:@"未开启定位服务\n客户端保持后台功能需要调用系统的位置服务\n请到设置中打开位置服务" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        
        [alertView show];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations//当用户位置改变时，系统会自动调用，这里必须写一点儿代码，否则后台时间刷新不管用
{
    NSLog(@"位置改变，必须做点儿事情才能刷新后台时间");
    CLLocation *loc = [locations lastObject];
    //NSTimeInterval backgroundTimeRemaining = [[UIApplication sharedApplication] backgroundTimeRemaining];
    //NSLog(@"Background Time Remaining = %.02f Seconds",backgroundTimeRemaining);
    // Lat/Lon
    float latitudeMe = loc.coordinate.latitude;
    float longitudeMe = loc.coordinate.longitude;
}

- (void)startBackgroundTask
{
    NSLog(@"Restarting task");
    if(YES)//当登陆状态才进入后台循环
    {
        // Start the long-running task.
        NSLog(@"登录状态后台进程开启");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // When the job expires it still keeps running since we never exited it. Thus have the expiration handler
            // set a flag that the job expired and use that to exit the while loop and end the task.
            NSInteger count=0;
            BOOL NoticeNoBackground=false;//只通知一次标志位
            BOOL FlushBackgroundTime=false;//只通知一次标志位
            locationManager.distanceFilter = kCLDistanceFilterNone;//任何运动均接受，任何运动将会触发定位更新
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;//定位精度
            while(self.background && !self.jobExpired)
            {
                NSLog(@"进入后台进程循环");
                [NSThread sleepForTimeInterval:1];
                count++;
                if(count>60)//每60s进行一次开启定位，刷新后台时间
                {
                    count=0;
                    [locationManager startUpdatingLocation];
                    NSLog(@"开始位置服务");
                    [NSThread sleepForTimeInterval:1];
                    [locationManager stopUpdatingLocation];
                    NSLog(@"停止位置服务");
                    FlushBackgroundTime=false;
                }
                if(!YES)//未登录或者掉线状态下关闭后台
                {
                    NSLog(@"保持在线进程失效，退出后台进程");
//                    [InterfaceFuncation ShowLocalNotification:@"保持在线失效，登录已被注销，请重新登录"];
                    [[UIApplication sharedApplication] endBackgroundTask:self.bgTask];
                    return;//退出循环
                }
                NSTimeInterval backgroundTimeRemaining = [[UIApplication sharedApplication] backgroundTimeRemaining];
                NSLog(@"Background Time Remaining = %.02f Seconds",backgroundTimeRemaining);
                if(backgroundTimeRemaining<30&&NoticeNoBackground==false)
                {
//                    [InterfaceFuncation ShowLocalNotification:@"向系统申请长时间保持后台失败，请结束客户端重新登录"];
                    NoticeNoBackground=true;
                }
                //测试后台时间刷新
                if(backgroundTimeRemaining>200&&FlushBackgroundTime==false)
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"MessageUpdate" object:@"刷新后台时间成功\n"];
                    FlushBackgroundTime=true;
                    //[InterfaceFuncation ShowLocalNotification:@"刷新后台时间成功"];
                }
            }
            self.jobExpired = NO;
        });
    }
}
*/

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
- (void)monitorBatteryStateInBackground
{
    self.background = YES;
    [self startBackgroundTask];
}
*/






@end
