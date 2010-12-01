// 
//  ConferenceObject.m
//  FinalProject
//
//  Created by Burke, Timothy E. on 11/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ConferenceObject.h"


@implementation ConferenceObject 

@synthesize title;
@synthesize favorite;
@synthesize image;
@synthesize description;
@synthesize startTime, endTime;
@synthesize type;
@synthesize IDnum;

- (id) initWithTitle: (NSString *) t image: (UIImage *) i description: (NSString *) d
{
	if(self = [super init])
	{
		self.title = t;
		self.image = i;
		self.description = d;
	}
	return self;
}

+ (id)ConferenceObjectFromDictionary: (NSDictionary *) dictionary
{	
	ConferenceObject * co = [[ConferenceObject alloc] init];
	
	co.type = [ConferenceObject typeFromString: [dictionary objectForKey:@"type"]];
	co.title = [dictionary objectForKey:@"title"];
	co.description = [dictionary objectForKey:@"description"];
	co.image = [UIImage imageNamed: [dictionary objectForKey:@"image"]];
	co.IDnum = [[dictionary objectForKey:@"id"] intValue];
	
	if(co.type == EventType)
	{		
		NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
		co.startTime  = [dateFormat dateFromString: [dictionary objectForKey:@"start"]]; 
		co.endTime  = [dateFormat dateFromString: [dictionary objectForKey:@"end"]]; 
	}
	
	co.favorite = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%d", co.IDnum]];
	
	return [co autorelease];
}

- (NSString *) typeString
{
	if(type == EventType)
		return [NSString stringWithString: @"Event"];
	else if(type == SponsorType)
		return [NSString stringWithString: @"Sponsor"];
	else if(type == SpeakerType)
		return [NSString stringWithString: @"Speaker"];
	else
		return [NSString stringWithString: @"Unknown Type"];
}

- (NSString *) searchableText
{
	return [NSString stringWithFormat: @"%@ %@ %@", self.title, self.description, self.typeString];
}

+ (ConferenceObjectType) typeFromString: (NSString *) dicType
{
	if([dicType isEqualToString: @"Event"])
		return EventType;
	else if([dicType isEqualToString: @"Sponsor"])
		return SponsorType;
	else if([dicType isEqualToString: @"Speaker"])
		return SpeakerType;
	else
		return UnknownType;
}


+ (NSComparator) getEventTimeComparator
{
	return ^(id obj1, id obj2) {
	
		if([obj1 startTime] == nil || [obj2 startTime] == nil)
			return (NSComparisonResult)NSOrderedSame;
		
		if ([[obj1 startTime] earlierDate:  [obj2 startTime]]){
			return (NSComparisonResult)NSOrderedDescending;
		}
		
		if ([[obj1 startTime] laterDate:  [obj2 startTime]]) {
			return (NSComparisonResult)NSOrderedAscending;
		}
		return (NSComparisonResult)NSOrderedSame;
	};	
}

+ (NSComparator) getTitleComparator
{
	return ^(id obj1, id obj2) {
		if ([obj1 title] == nil || [obj2 title] == nil) {
			return (NSComparisonResult)NSOrderedSame;
		}
		return [[obj1 title] compare: [obj2 title]];
	};	
}

- (void)dealloc {
	self.title = nil;
	self.description = nil;
	self.image = nil;
	[super dealloc];
}

@end
