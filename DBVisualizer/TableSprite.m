//
//  TableSprite.m
//  DBVisualizer
//
//  Created by Firas Kassem on 2/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TableSprite.h"


@implementation TableSprite
@synthesize sprite, size, name, tag, columns; 

-(id) init{
    if((self=[super init])){
        //do something
        [self initSprite];
        [self setName:@"na"];
        [self setSize:1000];
    }
    return self;
}

-(id) init:(NSString*) _name:(int) _size: (NSArray*) _columns{
    if((self=[super init])){
        //do something
        [self initSprite];
        self.name=_name;
        self.size=_size;
        self.columns = _columns;
    }
    return self;
}

-(void) initSprite{
    sprite = [CCSprite spriteWithFile:@"TableSprite.png"];
    CGSize wsize = [[CCDirector sharedDirector] winSize];
    sprite.position =  ccp( wsize.width /2 , wsize.height/2 );
}
@end
