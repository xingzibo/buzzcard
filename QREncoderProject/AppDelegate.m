//
//  AppDelegate.m
//  QREncoderProject
//
//  Created by Daniel Beard on 5/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "CreatedQRViewController.h"
#import "AboutUsViewController.h"

#import "Reachability.h"

#import <Parse/Parse.h>


@implementation AppDelegate

@synthesize window = _window,alert;
@synthesize viewController = _viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[CreatedQRViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
     */
    
    [Parse setApplicationId:@"wBZWVtNJeu2MhhNlJuW4eEhyy9uV9M62h8wxRnay"
                  clientKey:@"oiaZSC0VG9MTqMcr9iQjcT7ivDi6eInkyTSfVGZ2"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    
    
    {
        bool success = false;
        
        const char *hostName = [@"8.8.8.8"
                                cStringUsingEncoding:NSASCIIStringEncoding];
        SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL,
                                                                                    hostName);
        SCNetworkReachabilityFlags flags;
        success = SCNetworkReachabilityGetFlags(reachability,&flags);
        bool isAvailable = success && (flags & kSCNetworkFlagsReachable) &&
        !(flags & kSCNetworkFlagsConnectionRequired);
        
        if(isAvailable)
        {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
            //NSLog(@"registerForRemoteNotificationTypes");
     
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
     
     UIStoryboard *mainstoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     UIViewController *mainViewController = [mainstoryBoard instantiateInitialViewController];
     self.window.rootViewController = mainViewController;
     [self.window makeKeyAndVisible];
            
            //n/w status check
            
            NSUserDefaults *nwStat = [NSUserDefaults standardUserDefaults];
            
            [nwStat setBool:YES forKey:@"NetworkStatus"];

            
            //
     
     
     return YES;

        
        }
        else
        {
     
                self.alert=[[UIAlertView alloc]
                                    initWithTitle:@"Alert" message:@"Not network available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                self.alert.tag=101;
                [self.alert show];
                //[self.alert release];
                
     
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
     
     UIStoryboard *mainstoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     UIViewController *mainViewController = [mainstoryBoard instantiateInitialViewController];
     self.window.rootViewController = mainViewController;
     [self.window makeKeyAndVisible];
     
     
     return YES;

     
        }
    }
    
}
                  
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
                      
                      if (buttonIndex == 0)
                          
                      {
                          
                          
                          
                      }
                      
                  }
                  

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
