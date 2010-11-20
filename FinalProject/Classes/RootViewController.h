//
//  RootViewController.h
//  FinalProject
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate, UISearchBarDelegate> {

}

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;


@property(nonatomic,retain) NSMutableArray * conferenceObjs;
@property(nonatomic,retain) NSMutableArray * menuOptions;

@end
