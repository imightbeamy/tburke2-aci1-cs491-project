//
//  SearchViewController.h
//  FinalProject
//
//  Created by Amy Ciavolino on 11/22/10.
//  Copyright 2010 UMBC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchViewController : UITableViewController <UISearchBarDelegate> {

}

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property(nonatomic,retain) NSArray * conferenceObjs;
@property(nonatomic,retain) NSArray * filtered;
@property (nonatomic, retain) UISearchDisplayController *searchDisplayController;

@end
