//
//  CanonSprite.h
//  DBVisualizer
//
//  Created by Firas Kassem on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCSprite.h"
#import "TableSprite.h"

@interface CanonSprite : NSObject{
    CCSprite * sprite;
    CCSpriteBatchNode* selectBullets;
    CCSpriteBatchNode* insertBullets;
    CCSpriteBatchNode* updateBullets;
    CCSpriteBatchNode* deleteBullets;
    
    int insertBulletIndex;
    int updateBulletIndex;
    int deleteBulletIndex;
    
    
}
@property (readonly) CCSprite * sprite;
@property (readonly, retain) CCSpriteBatchNode * selectBullets;
@property (readonly, retain) CCSpriteBatchNode * insertBullets;
@property (readonly, retain) CCSpriteBatchNode * updateBullets;
@property (readonly, retain) CCSpriteBatchNode * deleteBullets;
@property (readonly) int insertBulletIndex;
@property (readonly) int updateBulletIndex;
@property (readonly) int deleteBulletIndex;
-(void) initSprite;
-(CCSprite*) shoot: (int) _type:(TableSprite*) _table; 
@end
