//
//  CanonSprite.m
//  DBVisualizer
//
//  Created by Firas Kassem on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CanonSprite.h"
#import "CCSpriteBatchNode.h"
#import "MainScene.h"

@implementation CanonSprite
@synthesize sprite, selectBullets,insertBullets,updateBullets,deleteBullets;
@synthesize insertBulletIndex, updateBulletIndex, deleteBulletIndex;


-(id) init{
    if((self=[super init])){
        //do something
        [self initSprite];
        //selectBullets = [CCSpriteBatchNode batchNodeWithFile:@"BulletSprite16White.png"];
        insertBullets = [CCSpriteBatchNode batchNodeWithFile:@"BulletSprite16Red.png"];
        [insertBullets retain];
        updateBullets = [CCSpriteBatchNode batchNodeWithFile:@"BulletSprite16Green.png"];
        [updateBullets retain];
        deleteBullets = [CCSpriteBatchNode batchNodeWithFile:@"BulletSprite16Blue.png"];
        [deleteBullets retain];
        for (int i = 0; i < 100; i++) {
            CCSprite* insertbullet = [CCSprite spriteWithFile:@"BulletSprite16Red.png"];
            CCSprite* updatebullet = [CCSprite spriteWithFile:@"BulletSprite16Green.png"];
            CCSprite* deletebullet = [CCSprite spriteWithFile:@"BulletSprite16Blue.png"];
            
            insertbullet.visible = NO;
            updatebullet.visible = NO;
            deletebullet.visible = NO;

            [insertBullets addChild:insertbullet]; 
            [updateBullets addChild:updatebullet]; 
            [deleteBullets addChild:deletebullet];
        }
        
        insertBulletIndex=0;
        updateBulletIndex=0;
        deleteBulletIndex=0;
        
        [[MainScene scene] addChild:insertBullets];
        [[MainScene scene] addChild:updateBullets];
        [[MainScene scene] addChild:deleteBullets];
    }
    return self;
}

-(void) initSprite{
    sprite = [CCSprite spriteWithFile:@"Bazooka.png"];
    CGSize size = [[CCDirector sharedDirector] winSize];
    sprite.position =  ccp( size.width-80 , size.height/2-10 );
}

-(CCSprite*) shoot: (int) _type:(TableSprite*) _table{
    CCArray* bullets;
    CCSprite* bullet;
    switch (_type) {
        case 0:{
                bullets = [insertBullets children];
                bullet = (CCSprite*)[bullets objectAtIndex:insertBulletIndex];
                insertBulletIndex++;
                if(insertBulletIndex >= bullets.count){
                    insertBulletIndex=0;
                }
            
                break;
            }
        case 1:
        {
            bullets = [updateBullets children];
            bullet = (CCSprite*)[bullets objectAtIndex:updateBulletIndex];
            updateBulletIndex++;
            if(updateBulletIndex >= bullets.count){
                updateBulletIndex=0;
            }
            
            break;
        }
        case 2:
        {
            bullets = [deleteBullets children];
            bullet = (CCSprite*)[bullets objectAtIndex:deleteBulletIndex];
            deleteBulletIndex++;
            if(deleteBulletIndex >= bullets.count){
                deleteBulletIndex=0;
            }
            break;
        }
        default:
            NSLog(@"Unknown bullet type %i", _type);
            return nil;
    }

    
    CGSize size = [[CCDirector sharedDirector] winSize];
    bullet.position =  ccp( size.width-20 , size.height/2 );
    bullet.visible = YES;
    
    float opp = _table.sprite.position.y - (size.height/2);
    float adj = self.sprite.position.x - _table.sprite.position.x;
    
    float angleRadians = atanf(opp/adj);
    float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
    
    CCRotateTo *rotateCannon = [CCRotateTo actionWithDuration:0.01 angle:angleDegrees];
    [self.sprite runAction:rotateCannon];
    
    CGPoint  point = CGPointMake(_table.sprite.position.x ,_table.sprite.position.y);
    
    CCMoveTo * move = [CCMoveTo actionWithDuration:0.3 position:point];
    CCHide * hide = [CCHide action];
    CCSequence *seq = [CCSequence actions:move, hide, nil];
    
    [bullet runAction:seq];

    return bullet;
}
@end
