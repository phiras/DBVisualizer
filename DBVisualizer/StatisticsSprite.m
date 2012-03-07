//
//  StatisticsSprite.m
//  DBVisualizer
//
//  Created by Firas Kassem on 06.03.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "StatisticsSprite.h"


@implementation StatisticsSprite
@synthesize insertSprite, updateSprite, deleteSprite, selectSprite;


-(id) init{
    if((self=[super init])){
        //do something 
		[self initSprites];
	}
    return self;
}


-(void) initSprites{
	CGSize size = [[CCDirector sharedDirector] winSize];
	
    selectSprite = [CCSprite spriteWithFile:@"WhiteBar.png"];
    selectSprite.position =  ccp(((size.width/4)*3-15)-190,100);
	
	insertSprite = [CCSprite spriteWithFile:@"RedBar.png"];
    insertSprite.position =  ccp(((size.width/4)*3-15)-65,100);

	updateSprite = [CCSprite spriteWithFile:@"GreenBar.png"];
    updateSprite.position =  ccp((size.width)-200,100);
	
	deleteSprite = [CCSprite spriteWithFile:@"BlueBar.png"];
    deleteSprite.position =  ccp(size.width-70,100);
	
	CCScaleTo *selectScale = [CCScaleTo actionWithDuration:1 scaleX:1.5	scaleY:10];
	CCScaleTo *insertScale = [CCScaleTo actionWithDuration:1 scaleX:1.5	scaleY:10];
	CCScaleTo *updateScale = [CCScaleTo actionWithDuration:1 scaleX:1.5	scaleY:10];
	CCScaleTo *deleteScale = [CCScaleTo actionWithDuration:1 scaleX:1.5	scaleY:10];
	
	[selectSprite runAction:selectScale];
	[insertSprite runAction:insertScale];
	[updateSprite runAction:updateScale];
	[deleteSprite runAction:deleteScale];
}


-(void) updateScales: (int) _selectCount: (int) _insertCount: (int) _updateCount: (int) _deleteCount{
	int totalCount = _selectCount + _insertCount + _updateCount + _deleteCount;
	float selectScaleY = (20*_selectCount)/totalCount;
	float insertScaleY = (20*_insertCount)/totalCount;
	float updateScaleY = (20*_updateCount)/totalCount;
	float deleteScaleY = (20*_deleteCount)/totalCount;
	
	CCScaleTo *selectScale = [CCScaleTo actionWithDuration:0.5 scaleX:1.5	scaleY:selectScaleY];
	CCScaleTo *insertScale = [CCScaleTo actionWithDuration:0.5 scaleX:1.5	scaleY:insertScaleY];
	CCScaleTo *updateScale = [CCScaleTo actionWithDuration:0.5 scaleX:1.5	scaleY:updateScaleY];
	CCScaleTo *deleteScale = [CCScaleTo actionWithDuration:0.5 scaleX:1.5	scaleY:deleteScaleY];
	
	[selectSprite runAction:selectScale];
	[insertSprite runAction:insertScale];
	[updateSprite runAction:updateScale];
	[deleteSprite runAction:deleteScale];
		
}	
@end
