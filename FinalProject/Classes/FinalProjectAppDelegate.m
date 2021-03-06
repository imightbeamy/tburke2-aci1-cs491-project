//
//  FinalProjectAppDelegate.m
//  FinalProject
//
//  Amy Ciavolino and Tim Burke
//  CMSC491 - Fall 2010
//
// First, solve the problem. Then, write the code.
//
// - John Johnson
//

#import "FinalProjectAppDelegate.h"
#import "RootViewController.h"


@implementation FinalProjectAppDelegate

@synthesize conferenceObjs;
@synthesize window;
@synthesize navigationController;

// Utility method to figure out where to save the data
- (NSString *)getFilePath {
	NSArray *segments = [NSArray arrayWithObjects:NSHomeDirectory(),@"FinalProject.app", @"conferenceData.plist", nil];
	return [NSString pathWithComponents:segments];
}

#pragma mark -
#pragma mark Application lifecycle

- (void)awakeFromNib {    
    
    //RootViewController *rootViewController = (RootViewController *)[navigationController topViewController];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	self.conferenceObjs = [NSMutableArray arrayWithContentsOfFile:[self getFilePath]];
	NSLog(@"%@",[self getFilePath]);
	if (self.conferenceObjs == nil) 
	{
		self.conferenceObjs = [NSMutableArray array];
	}
    // Add the navigation controller's view to the window and display.
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {

}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    
    [navigationController release];
    [window release];
    [super dealloc];
}


@end

