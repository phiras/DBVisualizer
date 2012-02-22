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

@interface CanonSprite : NSObject{
    CCSprite * sprite;
}
@property (readonly) CCSprite * sprite;
-(void) initSprite;
@end
