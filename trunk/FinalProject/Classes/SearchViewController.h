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


@interface SearchViewController : UITableViewController <UISearchBarDelegate> {

}

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property(nonatomic,retain) NSArray * conferenceObjs;
@property(nonatomic,retain) NSArray * filtered;
@property (nonatomic, retain) UISearchDisplayController *searchDisplayController;

@end
