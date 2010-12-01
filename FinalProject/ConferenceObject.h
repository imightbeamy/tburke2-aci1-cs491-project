//
//  ConferenceObject.h
//  FinalProject
//
//  Created by Burke, Timothy E. on 11/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

typedef enum {
	EventType,
	SponsorType,
	SpeakerType,
	UnknownType
} ConferenceObjectType;

@interface ConferenceObject:  NSObject  
{
	
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) UIImage * image;
@property (nonatomic, retain) NSString * description;
@property bool favorite;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSDate * endTime;
@property ConferenceObjectType type;
@property int IDnum;

@property (readonly) NSString * typeString;
@property (readonly) NSString * searchableText;

+ (id)ConferenceObjectFromDictionary: (NSDictionary *) dictionary;
+ (ConferenceObjectType) typeFromString: (NSString *) dicType;
+ (NSComparator) getEventTimeComparator;
+ (NSComparator) getTitleComparator;

@end



