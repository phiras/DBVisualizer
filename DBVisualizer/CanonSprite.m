//
//  CanonSprite.m
//  DBVisualizer
//
//  Created by Firas Kassem on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CanonSprite.h"

@implementation CanonSprite
@synthesize sprite;


-(id) init{
    if((self=[super init])){
        //do something
        [self initSprite];
    }
    return self;
}

-(void) initSprite{
    sprite = [CCSprite spriteWithFile:@"Bazooka.png"];
    CGSize size = [[CCDirector sharedDirector] winSize];
    sprite.position =  ccp( size.width-80 , size.height/2-10 );
}

@end
