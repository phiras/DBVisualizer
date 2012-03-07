//
//  CSVEventsLoader.m
//  DBVisualizer
//
//  Created by Firas Kassem on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CSVEventsLoader.h"

@implementation CSVEventsLoader


+(NSMutableArray*) load{
    NSMutableArray * events;

    events =[[NSMutableArray alloc] init];
    NSError  **outError = nil;
	NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"dummy_events2" ofType:@"csv"]; 
	NSString *text = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:outError];
	if (!text) {
		NSLog(@"Error reading file.");
	}
    
    NSScanner *scanner = [NSScanner scannerWithString:text];
	[scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"\n|; "]];
    NSString *user = nil, *databaseServer = nil, *timeStamp = nil, *operation = nil, *queryTime = nil, *lockTime = nil, *rowsSent = nil, *rowsExamined = nil, *query = nil, *timeDiff = nil, *queryMeta = nil;
    while ([scanner scanUpToString:@"|" intoString:&user] && 
		   [scanner scanUpToString:@"|" intoString:&databaseServer] && 
		   [scanner scanUpToString:@"|" intoString:&timeStamp] && 
		   [scanner scanUpToString:@"|" intoString:&operation] && 
		   [scanner scanUpToString:@"|" intoString:&queryTime] &&
		   [scanner scanUpToString:@"|" intoString:&lockTime] &&
		   [scanner scanUpToString:@"|" intoString:&rowsSent] &&
		   [scanner scanUpToString:@"|" intoString:&rowsExamined] &&
		   [scanner scanUpToString:@"|" intoString:&query] &&
		   [scanner scanUpToString:@"|" intoString:&timeDiff] &&
		   [scanner scanUpToString:@";" intoString:&queryMeta]){
        
        
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        [dict setObject:user forKey:@"user"];
        [dict setObject:databaseServer forKey:@"server"];
        [dict setObject:timeStamp forKey:@"timeStamp"];
        [dict setObject:operation forKey:@"operation"];
        [dict setObject:queryTime forKey:@"queryTime"];
        [dict setObject:lockTime forKey:@"lockTime"];
        [dict setObject:rowsSent forKey:@"rowsSent"];
        [dict setObject:rowsExamined forKey:@"rowsExamined"];
        [dict setObject:query forKey:@"query"];
        [dict setObject:queryMeta forKey:@"meta"];
        [dict setObject:timeDiff forKey:@"timeDiff"];
        
		[events addObject:dict];
    }
    return events;
}

@end
