//
//  RootViewController.h
//  FinalProject
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

}

@property(nonatomic,retain) NSMutableArray * conferenceObjs;
@property(nonatomic,retain) NSMutableArray * menuOptions;

- (void) loadFilteredSubviewWithName:(NSString *) name andFilter: (NSString *) filter;

@end
