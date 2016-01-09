//
//  DbManager.h
//  DataAccess
//
//  Created by Kenshin Cui on 14-3-29.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface KCDbManager : NSObject

@property (nonatomic) sqlite3 *database;

-(void)openDb:(NSString *)dbname;
-(void)executeNonQuery:(NSString *)sql;
-(NSArray *)executeQuery:(NSString *)sql;
-(void) close;
@end