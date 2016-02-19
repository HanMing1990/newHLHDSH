//
//  InitSqlite3.h
//  store
//
//  Created by yangjun on 16/1/9.
//  Copyright © 2016年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "static.h"

@interface InitSqlite3 : NSObject{
    
}
- (void) createDataBase;
- (void) outputTable;
- (void) createPlanItemTable;
- (void) createPlanHistoryTable;
- (void) createJokeItemTable;
- (void) createPictureItemTable;
- (void) createLevelItemTable;
- (void) insertPlanItem;
- (void) insertJokeItem;
- (void) insertPictureItem;
@end