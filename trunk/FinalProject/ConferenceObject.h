//
//  ConferenceObject.h
//  FinalProject
//
//  Created by Burke, Timothy E. on 11/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

/**
 An enumeration representing the types of items included in a conference
 program. 
 */
typedef enum {
	kEventType,			/*Represents conference events*/
	kSponsorType,		/*Represents Sponsors of the conference*/
	kSpeakerType,		/*Represents Speakers at the conference*/
	kUnknownConfType	/*Represents conference items that are invalid/unkown*/
} ConferenceObjectType;


/**
 A class that models an item of information in a conference program.
 */
@interface ConferenceObject:  NSObject  
{
	
}

/**
 The type of this conference info item. (e.g. Event, Speaker, Sponsor)
 */
@property ConferenceObjectType type;

/**
 The title of an event or name of speaker/sponsor.
 */
@property (nonatomic, retain) NSString * title;

/**
 The image to be displayed for the this conference info item. Shown in both the
 menu table views and the detailed view of the item.
 */
@property (nonatomic, retain) UIImage * image;

/**
 A description of the event/sponsor or bio for a speaker.
 */
@property (nonatomic, retain) NSString * description;

/**
 Whether this item has been added to the user's favorites.
 */
@property bool favorite;

/**
 A unique identification number for this conference info item. 
 Used for keeping track of persisted favorites 
 */
@property int IDnum;

/**
 The starting time of an event. Nil for speaker/sponsor.
 */
@property (nonatomic, retain) NSDate * startTime;

/**
 The ending time of an event. Nil for speaker/sponsor.
 */
@property (nonatomic, retain) NSDate * endTime;

/**
  The name of the location of an event. Nil for speaker/sponsor.
 */
@property (nonatomic, retain) NSString * location;

/**
  The location of of an event on the map in pixels. 0,0 for speaker/sponsor.
 */
@property int x;
@property int y;

/**
 Returns a string that represents the ConferenceObjectType of this item.
 */
@property (readonly) NSString * typeString;

/**
 Returns a string that has all the searchable text from the info.
 */
@property (readonly) NSString * searchableText;

/**
 Returns an autoreleased ConferenceObject with the information filled
 out with values from the given dictionary.
 */
+ (id)ConferenceObjectFromDictionary: (NSDictionary *) dictionary;

/**
 Returns a ConferenceObjectType that matches the string passed in. If the
 String matches no type, kUnknownConfType is returned. Used when reading 
 info in from the plist.
*/
+ (ConferenceObjectType) typeFromString: (NSString *) dicType;

/**
 Convenience method that returns an NSComparator for sorting Events by time.
 */
+ (NSComparator) getEventTimeComparator;

/**
 Convenience method that returns an NSComparator for sorting any conference 
 info item alphibeticly by title.
 */
+ (NSComparator) getTitleComparator;

@end



