//
//  FinalProjectAppDelegate.h
//  FinalProject
//
//  Amy Ciavolino and Tim Burke
//  CMSC491 - Fall 2010
//
// It's not at all important to get it right the first time. It's 
// vitally important to get it right the last time.
//
// - Andrew Hunt and David Thomas
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FinalProjectAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;

}


@property(nonatomic,retain) NSArray * conferenceObjs;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (NSString *)applicationDocumentsDirectory;
- (NSString *)getFilePath;

@end

