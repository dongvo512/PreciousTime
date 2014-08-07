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
#import "Utilities.h"
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
     activity1.name = @"WatchTV";
     activity1.unitTypeValue = 1;
     activity1.strAvatar = @"WatchTV.png";
    int idActivity1 = (int)[Utilities idWithDate] +1;
    activity1.idActivity = [NSString stringWithFormat:@"%d",idActivity1];
     activity1.point = 1;
    [arrActivity addObject:activity1];
    
    // Item 2 : BedTime
    Activity *activity2 = [[Activity alloc] init];
    activity2.name = @"Tours";
    int idActivity2 = (int)[Utilities idWithDate] +2;
    activity2.idActivity = [NSString stringWithFormat:@"%d",idActivity2];
    activity2.unitTypeValue = 1;
    activity2.strAvatar = @"Tours.png";
    activity2.point = 1;
    [arrActivity addObject:activity2];
    
    // Item 3 : WathTV
    Activity *activity3 = [[Activity alloc] init];
    activity3.name = @"Swim";
    int idActivity3 = (int)[Utilities idWithDate] +3;
    activity3.idActivity = [NSString stringWithFormat:@"%d",idActivity3];
    activity3.point = 1;
    activity3.unitTypeValue = 1;
    activity3.strAvatar = @"Swim.png";
    activity3.point = 1;
    [arrActivity addObject:activity3];
    
    // Item 4 : Tours
    Activity *activity4 = [[Activity alloc] init];
    activity4.name = @"Sports & Ballgames";
    int idActivity4 = (int)[Utilities idWithDate] +4;
    activity4.idActivity = [NSString stringWithFormat:@"%d",idActivity4];
    activity4.unitTypeValue = 1;
    activity4.strAvatar = @"Sports&Ballgames.png";
    activity4.point = 1;
    [arrActivity addObject:activity4];
    
    // Item 5 : Art&Craft
    Activity *activity5 = [[Activity alloc] init];
    activity5.name = @"Reading";
    int idActivity5 = (int)[Utilities idWithDate] +5;
    activity5.idActivity = [NSString stringWithFormat:@"%d",idActivity5];
    activity5.unitTypeValue = 1;
    activity5.strAvatar = @"Reading.png";
    activity5.point = 1;
    [arrActivity addObject:activity5];
    
    // Item 6 : DIY
    Activity *activity6 = [[Activity alloc] init];
    activity6.name = @"Playground";
    int idActivity6 = (int)[Utilities idWithDate] +6;
    activity6.idActivity = [NSString stringWithFormat:@"%d",idActivity6];
    activity6.unitTypeValue = 1;
    activity6.strAvatar = @"Playground.png";
    activity6.point = 1;
    [arrActivity addObject:activity6];
    
    // Item 7 : Phone
    Activity *activity7 = [[Activity alloc] init];
    activity7.name = @"Phone";
    int idActivity7 = (int)[Utilities idWithDate] +7;
    activity7.idActivity = [NSString stringWithFormat:@"%d",idActivity7];
    activity7.unitTypeValue = 1;
    activity7.strAvatar = @"Phone.png";
    activity7.point = 1;
    [arrActivity addObject:activity7];
    
    // Item 8 : Circuits&Trains
    Activity *activity8 = [[Activity alloc] init];
    activity8.name = @"Outdoor Activities";
    int idActivity8 = (int)[Utilities idWithDate] +8;
    activity8.idActivity = [NSString stringWithFormat:@"%d",idActivity8];
    activity8.unitTypeValue = 1;
    activity8.strAvatar = @"OutdoorActivities.png";
    activity8.point = 1;
    [arrActivity addObject:activity8];
    
    // Item 9 : Games
    Activity *activity9 = [[Activity alloc] init];
    activity9.name = @"Music & Singing";
    int idActivity9 = (int)[Utilities idWithDate] +9;
    activity9.idActivity = [NSString stringWithFormat:@"%d",idActivity9];
    activity9.unitTypeValue = 1;
    activity9.strAvatar = @"Music&Singing.png";
    activity9.point = 1;
    [arrActivity addObject:activity9];

    // Item 10 : Eating
    Activity *activity10 = [[Activity alloc] init];
    activity10.name = @"Movies";
    int idActivity10 = (int)[Utilities idWithDate] +10;
    activity10.idActivity = [NSString stringWithFormat:@"%d",idActivity10];
    activity10.unitTypeValue = 1;
    activity10.strAvatar = @"Movies.png";
    activity10.point = 1;
    [arrActivity addObject:activity10];
    
    // Item 11 : Reading
    Activity *activity11 = [[Activity alloc] init];
    activity11.name = @"Hugs";
    int idActivity11 = (int)[Utilities idWithDate] +11;
    activity11.idActivity = [NSString stringWithFormat:@"%d",idActivity11];
    activity11.unitTypeValue = 1;
    activity11.strAvatar = @"Hugs.png";
    activity11.point = 1;
    [arrActivity addObject:activity11];
    
    // Item 12 : Music&Singing
    Activity *activity12 = [[Activity alloc] init];
    activity12.name = @"Hairstyling & Makeup";
    int idActivity12 = (int)[Utilities idWithDate] +12;
    activity12.idActivity = [NSString stringWithFormat:@"%d",idActivity12];
    activity12.unitTypeValue = 1;
    activity12.strAvatar = @"Hairstyling&Makeup.png";
    activity12.point = 1;
    [arrActivity addObject:activity12];
    
    // Item 13 : Movies
    Activity *activity13 = [[Activity alloc] init];
    activity13.name = @"Gardening";
    int idActivity13 = (int)[Utilities idWithDate] +13;
    activity13.idActivity = [NSString stringWithFormat:@"%d",idActivity13];
    activity13.unitTypeValue = 1;
    activity13.strAvatar = @"Gardening.png";
    activity13.point = 1;
    [arrActivity addObject:activity13];
    
    // Item 14 : Hugs
    Activity *activity14 = [[Activity alloc] init];
    activity14.name = @"Games";
    int idActivity14 = (int)[Utilities idWithDate] +14;
    activity14.idActivity = [NSString stringWithFormat:@"%d",idActivity14];
    activity14.unitTypeValue = 1;
    activity14.strAvatar = @"Games.png";
    activity14.point = 1;
    [arrActivity addObject:activity14];
    
    // Item 15 : Playground
    Activity *activity15 = [[Activity alloc] init];
    activity15.name = @"Eating";
    int idActivity15 = (int)[Utilities idWithDate] +15;
    activity15.idActivity = [NSString stringWithFormat:@"%d",idActivity15];
    activity15.unitTypeValue = 1;
    activity15.strAvatar = @"Eating.png";
    activity15.point = 1;
    [arrActivity addObject:activity15];
    
    // Item 16 : OutdoorActivities
    Activity *activity16 = [[Activity alloc] init];
    activity16.name = @"DIY";
    int idActivity16 = (int)[Utilities idWithDate] +16;
    activity16.idActivity = [NSString stringWithFormat:@"%d",idActivity16];
    activity16.unitTypeValue = 1;
    activity16.strAvatar = @"DIY.png";
    activity16.point = 1;
    [arrActivity addObject:activity16];
    
    // Item 17 : Bicycle
    Activity *activity17 = [[Activity alloc] init];
    activity17.name = @"Coking & Baking";
    int idActivity17 = (int)[Utilities idWithDate] +17;
    activity17.idActivity = [NSString stringWithFormat:@"%d",idActivity17];
    activity17.unitTypeValue = 1;
    activity17.strAvatar = @"Coking&Baking.png";
    activity17.point = 1;
    [arrActivity addObject:activity17];
    
    // Item 18 : Swim
    Activity *activity18 = [[Activity alloc] init];
    activity18.name = @"Circuits & Trains";
    int idActivity18 = (int)[Utilities idWithDate] +18;
    activity18.idActivity = [NSString stringWithFormat:@"%d",idActivity18];
    activity18.unitTypeValue = 1;
    activity18.strAvatar = @"Circuits&Trains.png";
    activity18.point = 1;
    [arrActivity addObject:activity18];
    
    // Item 19 : Hairstyling&Makeup
    Activity *activity19 = [[Activity alloc] init];
    activity19.name = @"Bicycle";
    int idActivity19 = (int)[Utilities idWithDate] +19;
    activity19.idActivity = [NSString stringWithFormat:@"%d",idActivity19];
    activity19.unitTypeValue = 1;
    activity19.strAvatar = @"Bicycle.png";
    activity19.point = 1;
    [arrActivity addObject:activity19];
    
    // Item 20 : Gardening
    Activity *activity20 = [[Activity alloc] init];
    activity20.name = @"Art & Craft";
    int idActivity20 = (int)[Utilities idWithDate] +20;
    activity20.idActivity = [NSString stringWithFormat:@"%d",idActivity20];
    activity20.unitTypeValue = 1;
    activity20.strAvatar = @"Art&Craft.png";
    activity20.point = 1;
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
