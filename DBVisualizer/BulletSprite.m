//
//  BulletSprite.m
//  DBVisualizer
//
//  Created by Firas Kassem on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BulletSprite.h"

@implementation BulletSprite
@synthesize sprite;

-(id) init:(int) _type{
    if((self=[super init])){
        //do something
        type = _type;
        [self initSprite];
    }
    return self;
}

-(void) initSprite{
    NSString * assetName;
    switch (type) {
        case 0:
            assetName = @"BulletSprite16Red.png";
            break;
        case 1:
            assetName = @"BulletSprite16Green.png";
            break;
        case 2:
            assetName = @"BulletSprite16Blue.png";
            break;
        default:
            NSLog(@"Unknown bullet type %i", type);
            return;
    }
    
    sprite = [CCSprite spriteWithFile:assetName];
    CGSize size = [[CCDirector sharedDirector] winSize];
    sprite.position =  ccp( size.width-20 , size.height/2 );
}

@end
