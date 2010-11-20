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

- (void)dealloc {
	self.title = nil;
	self.description = nil;
	self.image = nil;
	[super dealloc];
}

@end
