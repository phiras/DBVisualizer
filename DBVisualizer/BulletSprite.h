//
//  BulletSprite.h
//  DBVisualizer
//
//  Created by Firas Kassem on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BulletSprite : NSObject{
    CCSprite * sprite;
    int type;
}
@property (readonly) CCSprite * sprite;
-(void) initSprite;
-(id) init:(int) _type;
@end
