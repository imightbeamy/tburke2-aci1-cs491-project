//
//  Event.h
//  FinalProject
//
//  Created by Amy Ciavolino on 11/19/10.
//  Copyright 2010 UMBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConferenceObject.h"

@interface Event : ConferenceObject {

}

@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSDate * endTime;

@end
