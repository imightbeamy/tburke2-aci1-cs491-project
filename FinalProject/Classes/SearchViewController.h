//
//  SearchViewController.h
//  FinalProject
//
//  Amy Ciavolino and Tim Burke
//  CMSC491 - Fall 2010
//
// Programming today is a race between software engineers striving to 
// build bigger and better idiot-proof programs, and the universe trying 
// to build bigger and better idiots. So far, the universe is winning.
//
// - Rick Cook
//

#import <UIKit/UIKit.h>

/**
 A view controller for the search submenu.  
 */
@interface SearchViewController : UITableViewController <UISearchBarDelegate> {

}

/**
 Outlet for the seachbar. 
 */
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

/**
 A list of conference objects to search through.
 */
@property (nonatomic, retain) NSArray * conferenceObjs;

/**
 The list of conference objects that match the current search string.
 */
@property (nonatomic, retain) NSArray * filtered;

@end
