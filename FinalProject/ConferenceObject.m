// 
//  ConferenceObject.m
//  FinalProject
//
//  Amy Ciavolino and Tim Burke
//  CMSC491 - Fall 2010
//
// The cheapest, fastest, and most reliable components are those 
// that aren't there.
//
// — Gordon Bell
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
@synthesize location, x, y;


+ (id)ConferenceObjectFromDictionary: (NSDictionary *) dictionary
{	
	ConferenceObject * co = [[ConferenceObject alloc] init];
	
	co.type = [ConferenceObject typeFromString: [dictionary objectForKey:@"type"]];
	co.title = [dictionary objectForKey:@"title"];
	co.description = [dictionary objectForKey:@"description"];
	co.image = [UIImage imageNamed: [dictionary objectForKey:@"image"]];
	co.IDnum = [[dictionary objectForKey:@"id"] intValue];
	
	if(co.type == kEventType)
	{		
		NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormat setDateFormat:@"MM/dd/yyyy hh:mm a"];
		co.startTime  = [dateFormat dateFromString: [dictionary objectForKey:@"start"]]; 
		co.endTime  = [dateFormat dateFromString: [dictionary objectForKey:@"end"]];
		
		co.x = [[dictionary objectForKey:@"x"] intValue];
		co.y = [[dictionary objectForKey:@"y"] intValue];
		co.location = [dictionary objectForKey:@"location"];
	}
	
	//Get favorite value stored in defaults
	co.favorite = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%d", co.IDnum]];
	
	return [co autorelease];
}

- (NSString *) typeString
{
	if(type == kEventType)
		return [NSString stringWithString: @"Event"];
	else if(type == kSponsorType)
		return [NSString stringWithString: @"Sponsor"];
	else if(type == kSpeakerType)
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
	NSString * dicTypeU = [dicType uppercaseString];	
	if([dicTypeU isEqualToString: @"EVENT"])
		return kEventType;
	else if([dicTypeU isEqualToString: @"SPONSOR"])
		return kSponsorType;
	else if([dicTypeU isEqualToString: @"SPEAKER"])
		return kSpeakerType;
	else
		return kUnknownConfType;
}


+ (NSComparator) getEventTimeComparator
{
	return ^(id obj1, id obj2) {
	
		if([obj1 startTime] == nil || [obj2 startTime] == nil)
			return (NSComparisonResult)NSOrderedSame;
		
		if ([[obj1 startTime] earlierDate:  [obj2 startTime]] == [obj2 startTime]){
			return (NSComparisonResult)NSOrderedDescending;
		}
		
		if ([[obj1 startTime] laterDate:  [obj2 startTime]] == [obj2 startTime]) {
			return (NSComparisonResult)NSOrderedAscending;
		}
		return (NSComparisonResult)NSOrderedSame;
	};	
}

+ (NSComparator) getTitleComparator
{
	return ^(id obj1, id obj2) {
		//Title should never be nil but just in case...
		if ([obj1 title] == nil || [obj2 title] == nil) {
			return (NSComparisonResult)NSOrderedSame;
		}
		return [[obj1 title] compare: [obj2 title]];
	};	
}

- (void)dealloc {
	self.title = nil;
	self.image = nil;
	self.description = nil;
	self.startTime = nil;
	self.endTime = nil;
	self.location = nil;
	[super dealloc];
}

@end
