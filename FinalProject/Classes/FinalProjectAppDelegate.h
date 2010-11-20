//
//  FinalProjectAppDelegate.h
//  FinalProject
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

