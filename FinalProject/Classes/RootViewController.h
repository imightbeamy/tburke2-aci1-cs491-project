//
//  RootViewController.h
//  FinalProject
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

}

/**
 Always contains all the info objects for the conference.
 */
@property(nonatomic,retain) NSMutableArray * conferenceObjs;

/**
 Array of Strings with the lables for each main menu choice. 
 */
@property(nonatomic,retain) NSMutableArray * menuOptions;

/**
 Loads a SubMenuViewController with the given name as the title and a table 
 view populated with the info items from conferenceObjs with filter applied 
 to them. 
 */
- (void) loadFilteredSubviewWithName:(NSString *) name andFilter: (NSString *) filter;

/** 
 A special case of loadFilteredSubviewWithName:andFilter: that sets the 
 SubMenuViewController as a Schedule type view. This view is nearly 
 identical to a regular SubMenuViewController except with times deplayed 
 as detailed text and the objects are sorted by start time.
 */
- (void) loadScheduleView;

/** 
 A special case of loadFilteredSubviewWithName:andFilter: that sets the 
 SubMenuViewController as a Favorites type view. This view is nearly 
 identical to a regular SubMenuViewController except that data is re-flitered 
 after returning from a detail view in case the use un-favorited an item.
 */
- (void) loadFavoritesView;

/**
 Loads a SearchViewController.
 */
- (void) loadSearchView;

/**
 Loads a MapViewController with no location mark.
 */
- (void) loadMapView;



@end
