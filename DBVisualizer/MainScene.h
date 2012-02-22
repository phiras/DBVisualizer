//
//  MainScene.h
//  DBVisualizer
//
//  Created by Firas Kassem on 2/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TableSprite.h"

extern int const MAX_TABLES_NUM;

@interface MainScene : CCLayer {
}
+(CCScene *) scene;
-(void) initTables:(NSMutableArray*) tablesArray;
-(void) drawTables;
-(void) handleTimer:(NSTimer *) timer;
@end
