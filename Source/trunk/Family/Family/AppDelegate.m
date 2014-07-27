//
//  AppDelegate.m
//  Family
//
//  Created by Admin on 7/1/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "InitialLandingViewController.h"
#import "SplashScreentViewController.h"
#import "DataHandler.h"
#import "Activity.h"
#import <GooglePlus/GooglePlus.h>
@implementation AppDelegate
static NSString * const kClientID =
@"516933277800-8kk3rgm85uqccdonh5ataka68o7sihfe.apps.googleusercontent.com";
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    // Customize BackButton
   
  /*  LoginViewController *vcLogin = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
      self.window.rootViewController = vcLogin;*/
    // create Data for Activity
    [GPPSignIn sharedInstance].clientID = kClientID;
    
    NSError *error = nil;
    [[DataHandler sharedManager] copyDatabaseToDocumentWithError:&error];
    if (error) {
        DLog("%@",error.description);
    }
    
    //[self createDataActivity];
    SplashScreentViewController *vcSplashScreen = [[SplashScreentViewController alloc] initWithNibName:@"SplashScreentViewController" bundle:nil];
    self.window.rootViewController = vcSplashScreen;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
- (BOOL)application: (UIApplication *)application
            openURL: (NSURL *)url
  sourceApplication: (NSString *)sourceApplication
         annotation: (id)annotation {
    return [GPPURLHandler handleURL:url
                  sourceApplication:sourceApplication
                         annotation:annotation];
}
#pragma mark - GPPDeepLinkDelegate

- (void)didReceiveDeepLink:(GPPDeepLink *)deepLink {
    // An example to handle the deep link data.
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Deep-link Data"
                          message:[deepLink deepLinkID]
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}
-(void)createDataActivity
{
   // Note :
    // With unitTypeValue 0 = Second, 1 = Minute, 2 = Hour;
    
    // Create Activity
    NSMutableArray *arrActivity = [NSMutableArray array];
    // Item 1 : Cooking&Baking
    Activity *activity1 = [[Activity alloc] init];
     activity1.name = @"Cooking&Baking";
     activity1.unitTypeValue = 1;
     activity1.strAvatar = @"icon_bake.png";
     activity1.point = 10;
    [arrActivity addObject:activity1];
    
    // Item 2 : BedTime
    Activity *activity2 = [[Activity alloc] init];
    activity2.name = @"BedTime";
    activity2.unitTypeValue = 1;
    activity2.strAvatar = @"icon_bedtime.png";
    activity2.point = 10;
    [arrActivity addObject:activity2];
    
    // Item 3 : WathTV
    Activity *activity3 = [[Activity alloc] init];
    activity3.name = @"WathTV";
    activity3.unitTypeValue = 1;
    activity3.strAvatar = @"icon_WatchTV.png";
    activity3.point = 10;
    [arrActivity addObject:activity3];
    
    // Item 4 : Tours
    Activity *activity4 = [[Activity alloc] init];
    activity4.name = @"Tours";
    activity4.unitTypeValue = 1;
    activity4.strAvatar = @"Tours.png";
    activity4.point = 10;
    [arrActivity addObject:activity4];
    
    // Item 5 : Art&Craft
    Activity *activity5 = [[Activity alloc] init];
    activity5.name = @"Art&Craft";
    activity5.unitTypeValue = 1;
    activity5.strAvatar = @"icon_Art&Craft.png";
    activity5.point = 10;
    [arrActivity addObject:activity5];
    
    // Item 6 : DIY
    Activity *activity6 = [[Activity alloc] init];
    activity6.name = @"DIY";
    activity6.unitTypeValue = 1;
    activity6.strAvatar = @"icon_DIY.png";
    activity6.point = 10;
    [arrActivity addObject:activity6];
    
    // Item 7 : Phone
    Activity *activity7 = [[Activity alloc] init];
    activity7.name = @"Phone";
    activity7.unitTypeValue = 1;
    activity7.strAvatar = @"icon_Phone.png";
    activity7.point = 10;
    [arrActivity addObject:activity7];
    
    // Item 8 : Circuits&Trains
    Activity *activity8 = [[Activity alloc] init];
    activity8.name = @"Circuits&Trains";
    activity8.unitTypeValue = 1;
    activity8.strAvatar = @"icon_Circuits&Trains.png";
    activity8.point = 10;
    [arrActivity addObject:activity8];
    
    // Item 9 : Games
    Activity *activity9 = [[Activity alloc] init];
    activity9.name = @"Games";
    activity9.unitTypeValue = 1;
    activity9.strAvatar = @"icon_Games.png";
    activity9.point = 10;
    [arrActivity addObject:activity9];

    // Item 10 : Eating
    Activity *activity10 = [[Activity alloc] init];
    activity10.name = @"Eating";
    activity10.unitTypeValue = 1;
    activity10.strAvatar = @"icon_Eating.png";
    activity10.point = 10;
    [arrActivity addObject:activity10];
    
    // Item 11 : Reading
    Activity *activity11 = [[Activity alloc] init];
    activity11.name = @"Reading";
    activity11.unitTypeValue = 1;
    activity11.strAvatar = @"icon_Reading.png";
    activity11.point = 10;
    [arrActivity addObject:activity11];
    
    // Item 12 : Music&Singing
    Activity *activity12 = [[Activity alloc] init];
    activity12.name = @"Music&Singing";
    activity12.unitTypeValue = 1;
    activity12.strAvatar = @"icon_Music&Singing.png";
    activity12.point = 10;
    [arrActivity addObject:activity12];
    
    // Item 13 : Movies
    Activity *activity13 = [[Activity alloc] init];
    activity13.name = @"Movies";
    activity13.unitTypeValue = 1;
    activity13.strAvatar = @"icon_Movies.png";
    activity13.point = 10;
    [arrActivity addObject:activity13];
    
    // Item 14 : Hugs
    Activity *activity14 = [[Activity alloc] init];
    activity14.name = @"Hugs";
    activity14.unitTypeValue = 1;
    activity14.strAvatar = @"icon_Hugs.png";
    activity14.point = 10;
    [arrActivity addObject:activity14];
    
    // Item 15 : Playground
    Activity *activity15 = [[Activity alloc] init];
    activity15.name = @"Playground";
    activity15.unitTypeValue = 1;
    activity15.strAvatar = @"icon_Playground.png";
    activity15.point = 10;
    [arrActivity addObject:activity15];
    
    // Item 16 : OutdoorActivities
    Activity *activity16 = [[Activity alloc] init];
    activity16.name = @"OutdoorActivities";
    activity16.unitTypeValue = 1;
    activity16.strAvatar = @"icon_OutdoorActivities.png";
    activity16.point = 10;
    [arrActivity addObject:activity16];
    
    // Item 17 : Bicycle
    Activity *activity17 = [[Activity alloc] init];
    activity17.name = @"Bicycle";
    activity17.unitTypeValue = 1;
    activity17.strAvatar = @"icon_Bicycle.png";
    activity17.point = 10;
    [arrActivity addObject:activity17];
    
    // Item 18 : Swim
    Activity *activity18 = [[Activity alloc] init];
    activity18.name = @"Swim";
    activity18.unitTypeValue = 1;
    activity18.strAvatar = @"icon_Swim.png";
    activity18.point = 10;
    [arrActivity addObject:activity18];
    
    // Item 19 : Hairstyling&Makeup
    Activity *activity19 = [[Activity alloc] init];
    activity19.name = @"Hairstyling&Makeup";
    activity19.unitTypeValue = 1;
    activity19.strAvatar = @"icon_Hairstyling&Makeup.png";
    activity19.point = 10;
    [arrActivity addObject:activity19];
    
    // Item 20 : Gardening
    Activity *activity20 = [[Activity alloc] init];
    activity20.name = @"Gardening";
    activity20.unitTypeValue = 1;
    activity20.strAvatar = @"icon_Gardening.png";
    activity20.point = 10;
    [arrActivity addObject:activity20];

    for(Activity *aActivityCurr in arrActivity)
    {
        NSError *error = nil;
        NSString *idActivity = nil;
        BOOL isSuccess = [[DataHandler sharedManager] insertActivity:aActivityCurr isSync:false idActivity:&idActivity error:&error];
        DLog(@"%@",idActivity);
        NSAssert(isSuccess, error.description);
    }
     /*
       NSError *error = nil;
      NSString *idActivity = nil;
     BOOL isSuccess = [[DataHandler sharedManager] insertActivity:activity isSync:false idActivity:&idActivity error:&error];
     DLog(@"%@",idActivity);
     NSAssert(isSuccess, error.description);*/

}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
