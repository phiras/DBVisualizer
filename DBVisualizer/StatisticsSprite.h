//
//  StatisticsSprite.h
//  DBVisualizer
//
//  Created by Firas Kassem on 06.03.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCSprite.h"


@interface StatisticsSprite : NSObject {
	CCSprite * insertSprite;
	CCSprite * updateSprite;
	CCSprite * deleteSprite;
	CCSprite * selectSprite;
}
@property (readonly) CCSprite *insertSprite, *updateSprite, *deleteSprite, *selectSprite;
-(void) initSprites;
-(void) updateScales: (int) _selectCount: (int) _insertCount: (int) _updateCount: (int) _deleteCount;
@end
