//
//  MainScene.m
//  DBVisualizer
//
//  Created by Firas Kassem on 2/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainScene.h"
#import "TableSprite.h"
#import "CanonSprite.h"
#import "BulletSprite.h"
#import "StatisticsSprite.h"
#import "SimpleAudioEngine.h"
#import "SchemaLoader.h"
#import "CSVEventsLoader.h"

int const MAX_TABLES_NUM = 5;
int const MIN_TABLE_SIZE = 24;


@implementation MainScene

NSMutableDictionary * tables;
CCSprite *shootBTNSprite;
CanonSprite * cannon;
StatisticsSprite *statistics;
int minRowNumbers = 800;
int maxRowNumbers = 2000;
int max_table_siz_px;
int min_table_siz_px;
NSTimer *timer;
NSMutableArray * events;
int eventIndex;
int lastTime;
NSMutableDictionary* event;

CCScene *s; 

+(CCScene *) scene{
    if(s == nil){
        s = [CCScene node];
        CCLayer *l = [MainScene node];
        [s addChild:l];
    }
    return s;
}

-(id) init{
    if(self=[super init]){
        self.isTouchEnabled = YES;
        
        
        events = [CSVEventsLoader load];
        [events retain];
        [event retain];
        eventIndex=0;
        lastTime=0;
        event = [self nextEvent];
        
        // load tables
        tables = [NSMutableDictionary dictionary];
        [tables retain];
        SchemaLoader* loader = [[SchemaLoader alloc] init];
        NSArray * dummyTables = [loader load];
        
        // init canon
        cannon = [[CanonSprite alloc] init];
        [cannon retain];
        [self addChild:cannon.sprite z:3];
        
        // draw tables
        [self initTables:dummyTables];
        [self drawTables];
        
        // Play music theme
		//[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];
        
        // add info area
        CGSize size = [[CCDirector sharedDirector] winSize];
		//Operations Info
		CCSprite * infoSprite = [CCSprite spriteWithFile:@"OperationsInfo.png"];
		infoSprite.position   =  ccp((size.width/4)*3-15,15);
        [self addChild:infoSprite z:0 tag:4];
		
		// add statistics info
		statistics = [[StatisticsSprite alloc] init];
        [statistics retain];
        [self addChild:statistics.selectSprite z:0];
		[self addChild:statistics.insertSprite z:0];
		[self addChild:statistics.updateSprite z:0];
		[self addChild:statistics.deleteSprite z:0];
        
        // setup timer
        timer = [NSTimer scheduledTimerWithTimeInterval: 0.5
                                                 target: self
                                               selector: @selector(handleTimer:)
                                               userInfo: nil
                                                repeats: YES];
        
    }
    return self;
}

-(void) initTables:(NSArray*) tablesArray{
    int numberOfTables = [tablesArray count];
    if(numberOfTables > MAX_TABLES_NUM) 
        numberOfTables = MAX_TABLES_NUM;
    
    NSLog(@"number of tables %i", numberOfTables);
    
    for(int i = 0 ; i < numberOfTables ; i++){
        TableSprite* table = [tablesArray objectAtIndex:i];
        NSLog(@"importing table #%i, %@", i,table.name );
        [tables setObject:table forKey:table.name]; 
    }
    min_table_siz_px = MIN_TABLE_SIZE;
    max_table_siz_px = (750 - (4*numberOfTables))/numberOfTables;
}

-(void) drawTables{
    float generalScaleRate = (100*max_table_siz_px/512)*0.01;
    int i = 0;
    for (NSString * tblName in tables) {
        TableSprite * tbSprite = [tables objectForKey:tblName];
        NSLog(@"Working on table %@, %i", tblName, tables.count);
        [self addChild:tbSprite.sprite z:1 tag:++i];
        tbSprite.sprite.position = CGPointMake((max_table_siz_px/2)+100,10+i*(max_table_siz_px/2)+(i-1)*max_table_siz_px/2);
        float scaleRate = (((float)tbSprite.size)*1/maxRowNumbers);
        CCScaleBy *scale = [CCScaleBy actionWithDuration:0.4 scale:generalScaleRate*scaleRate];
        [tbSprite.sprite runAction:scale];
		// view the table name
		CCLabelTTF *label = [CCLabelTTF labelWithString:tblName fontName:@"Verdana" fontSize:20];
		label.position =  ccp( 50 , 10+i*(max_table_siz_px/2)+(i-1)*max_table_siz_px/2);
		[self addChild:label];
    }
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Clicked");
    TableSprite * tblSprite = [tables objectForKey:@"sms"];
    NSLog(@"shooting on %@ table", tblSprite.name);
    [cannon shoot:0:tblSprite];
    
    /*CGSize size = [[CCDirector sharedDirector] winSize];
    float width = [shootBTNSprite texture].contentSize.width;
    float height = [shootBTNSprite texture].contentSize.height;
    CGRect shootBounds = CGRectMake(shootBTNSprite.position.x - width/2 , size.height - shootBTNSprite.position.y - height/2, width, height);
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:[touch view]];
    CCLOG(@"point x : %f, y : %f", p.x, p.y);
    if(CGRectContainsPoint(shootBounds, p))
    {
        BulletSprite * bullet = [[BulletSprite alloc] init:0];
        [self addChild:bullet.sprite];
       NSLog(@"looking up table %i", tables.count);
        TableSprite * tblSprite = [tables objectForKey:@"orders"];
        
        NSLog(@"Table name ::: %@", tblSprite.name);
        float opp = tblSprite.sprite.position.y - (size.height/2);
        float adj = cannon.sprite.position.x - tblSprite.sprite.position.x;
        
        float angleRadians = atanf(opp/adj);
        float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
        
        //bullet.rotation = angleDegrees;
        
        CCRotateTo *rotateCannon = [CCRotateTo actionWithDuration:0.05 angle:angleDegrees];
        [cannon.sprite runAction:rotateCannon];
        
        CGPoint  point = CGPointMake(tblSprite.sprite.position.x ,tblSprite.sprite.position.y);
        
        CCMoveTo * move = [CCMoveTo actionWithDuration:0.5 position:point];
        [bullet.sprite runAction:move];
    }*/
    
}


-(void) dealloc{
    [super dealloc];
}


-(NSMutableDictionary*) nextEvent{
    NSLog(@"events count = %i, index = %i", events.count, eventIndex);
    if(++eventIndex >= events.count){
        return nil;
    }
    return [events objectAtIndex:eventIndex];
}

-(void) handleTimer:(NSTimer *) timer
{
    if(event == nil){
        NSLog(@"nil event");
        return;
    }
    NSLog(@" new event : %@", event);
    NSLog(@"time diff : %@", [event objectForKey:@"timeDiff"]);
    int bulletType=0;
    if([[event objectForKey:@"operation"] isEqualToString:@"INSERT"]) bulletType = 0;
    if([[event objectForKey:@"operation"] isEqualToString:@"update"]) bulletType = 1;
    if([[event objectForKey:@"operation"] isEqualToString:@"delete"]) bulletType = 2;
    if([[event objectForKey:@"operation"] isEqualToString:@"SELECT"]) bulletType = 0; // TODO : fix
    


    
    TableSprite * tblSprite = [tables objectForKey:[event objectForKey:@"meta"]];

    [cannon shoot:bulletType:tblSprite];

    
   /* NSTimer * tableTimer = [NSTimer scheduledTimerWithTimeInterval: 0.30
                                             target: self
                                            selector: @selector(shakeTable:)
                                           userInfo: tblSprite
                                            repeats: NO];
    */

    
    event = [self nextEvent];
    int timeDiff = [[event objectForKey:@"timeDiff"] intValue];
    
    [timer invalidate];
    timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval: 0.30+(20*timeDiff)/10
                                             target: self
                                           selector: @selector(handleTimer:)
                                           userInfo: nil
                                            repeats: YES];
}

-(void) shakeTable:(NSTimer *) timer{
    int moveAmount = 4;	
    TableSprite* table = (TableSprite*)[timer userInfo];
    id actionShakeMove = [CCSequence actions:
                          [CCMoveBy actionWithDuration:0.02 position:ccp(moveAmount,0)],
                          [CCMoveBy actionWithDuration:0.02 position:ccp(-moveAmount,0)],
                          [CCMoveBy actionWithDuration:0.02 position:ccp(moveAmount,0)],
                          [CCMoveBy actionWithDuration:0.02 position:ccp(-moveAmount,0)],
                          nil];
    [table.sprite runAction:actionShakeMove];

}


@end
