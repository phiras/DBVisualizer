//
//  XMLSchemaParser.h
//  DBVisualizer
//
//  Created by Firas Kassem on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchemaLoader : NSObject  <NSXMLParserDelegate>{
    NSMutableString *currentElementValue;
    NSString* name;
	NSString* index;
    int size;
    NSMutableArray *columns;
    NSMutableArray *tables;
}
-(NSArray*) load;
@end
