//
//  DbManager.m
//  DataAccess
//
//  Created by Kenshin Cui on 14-3-29.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "KCDbManager.h"
#import <sqlite3.h>

@interface KCDbManager()
@end

@implementation KCDbManager

-(void)openDb:(NSString *)dbname{
    //取得数据库保存路径，通常保存沙盒Documents目录
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    //NSlog(@"%@",directory);
    NSString *filePath=[directory stringByAppendingPathComponent:dbname];
    //如果有数据库则直接打开，否则创建并打开（注意filePath是ObjC中的字符串，需要转化为C语言字符串类型）
    if (SQLITE_OK ==sqlite3_open(filePath.UTF8String, &_database)) {
        //NSlog(@"数据库打开成功!");
    }else{
        //NSlog(@"数据库打开失败!");
    }
}

-(void)executeNonQuery:(NSString *)sql{
    char *error;
    //单步执行sql语句，用于插入、修改、删除
    if (SQLITE_OK!=sqlite3_exec(_database, sql.UTF8String, NULL, NULL,&error)) {
        //NSlog(@"执行SQL语句过程中发生错误！错误信息：%s",error);
    }else{
        //NSlog(@"执行SQL语句过程成功");
    }
}

-(NSArray *)executeQuery:(NSString *)sql{
    NSMutableArray *rows=[NSMutableArray array];//数据行
    //评估语法正确性
    sqlite3_stmt *stmt;
    //检查语法正确性
    if (SQLITE_OK==sqlite3_prepare_v2(_database, sql.UTF8String, -1, &stmt, NULL)) {
        //单步执行sql语句
        while (SQLITE_ROW==sqlite3_step(stmt)) {
            int columnCount= sqlite3_column_count(stmt);
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            for (int i=0; i<columnCount; i++) {
                const char *name= sqlite3_column_name(stmt, i);//取得列名
                const unsigned char *value= sqlite3_column_text(stmt, i);//取得某列的值
                dic[[NSString stringWithUTF8String:name]]=[NSString stringWithUTF8String:(const char *)value];
            }
            [rows addObject:dic];
        }
    }else{
        //NSlog(@"sql sentence is not right, reason: %s",sqlite3_errmsg(_database));
    }
    //释放句柄
    sqlite3_finalize(stmt);
    return rows;
}
-(void) close{
    sqlite3_close(_database);
}
@end