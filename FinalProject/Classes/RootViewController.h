//
//  RootViewController.h
//  FinalProject
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate, UISearchBarDelegate> {

}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;


@property(nonatomic,retain) NSArray * conferenceObjs;

@end
