//
//  SubMenuViewController.h
//  FinalProject
//
//  Created by Amy Ciavolino on 11/20/10.
//  Copyright 2010 UMBC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 A view controller for most of the submenus including Events, Sponsors
 Speakers, Schedule and Favorites. 
 */
@interface SubMenuViewController : UITableViewController {

}

/**
 The items that should be displyed in this subview. Gets set by the root
 view when loading the sub view.
 */
@property(nonatomic,retain) NSArray * conferenceObjs;

/**
 Sets view as favorites view. This makes the data be reflitered whenever 
 the view loads.
 */
@property bool favsView;

/**
 Sets view as schedule view. This makes the date and time show up as the 
 detail text on each cell.
 */
@property bool scheduleView;

@end
