//
//  XMLSchemaParser.m
//  DBVisualizer
//
//  Created by Firas Kassem on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SchemaLoader.h"

@implementation SchemaLoader
-(NSArray*) load{
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"Schema" ofType:@"xml"];
	NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    
    [xmlParser setDelegate:self];
	[xmlParser parse];
    return tables;
}

- (id) init{
	if(self=[super init]){
        //pass
    }
	return self;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
	
	if([elementName isEqualToString:@"Tables"]) {
		tables = [NSMutableArray array];
	}
	else if([elementName isEqualToString:@"Table"]) {
        name = [attributeDict objectForKey:@"name"];
        size = [(NSString*)[attributeDict objectForKey:@"size"] integerValue];
        columns = [NSMutableArray array];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	if(!currentElementValue)
		currentElementValue = [[NSMutableString alloc] initWithString:string];
	else
		[currentElementValue appendString:string];
    
	[columns addObject:currentElementValue];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString:@"Tables"])
		return;
	
	if([elementName isEqualToString:@"Table"]) {
		//[tables addObject:aTable];
		NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        [dict setObject:name forKey:@"name"];
        NSString *sizeStr = [[NSString alloc] initWithFormat:@"%i", size];
        [dict setObject:sizeStr forKey:@"size"];
        [dict setObject:columns forKey:@"columns"];
        
        [tables addObject:dict];
        name = nil;
        size=0;
        columns=nil;
	}
	currentElementValue = nil;
}

- (void) dealloc {
    [columns release];
	[currentElementValue release];
    [tables release];
	[super dealloc];
}

@end
