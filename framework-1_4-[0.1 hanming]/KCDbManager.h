//
//  DbManager.h
//  DataAccess
//
//  Created by Kenshin Cui on 14-3-29.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface KCDbManager : NSObject          //数据库访问函数

@property (nonatomic) sqlite3 *database;

-(void)openDb:(NSString *)dbname;          //实例化后打开一个数据库啦～
-(void)executeNonQuery:(NSString *)sql;    //执行没有返回的查询
-(NSArray *)executeQuery:(NSString *)sql;  //执行有返回的查询，这个查询的结果呢，存在一个NSArray中，数组中的每一项都是一个NSDictionary
-(void) close;                             //用完要记得把这个数据库关掉哦～～
@end