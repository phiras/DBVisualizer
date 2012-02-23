//
//  TableSprite.h
//  DBVisualizer
//
//  Created by Firas Kassem on 2/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCSprite.h"

@interface TableSprite : NSObject{
    CCSprite *sprite;
    int size;
    NSString *name;
    NSArray * columns;
    int tag;
}

@property (readonly) CCSprite* sprite;
@property (readwrite) int size;
@property (readwrite, assign) NSString *name;
@property (readwrite, assign) NSArray *columns;
@property (readonly) int tag;

-(void) initSprite;
-(id) init:(NSString*) name:(int) size: (NSArray*) columns;
@end
