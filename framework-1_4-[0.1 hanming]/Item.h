//
//  Item.h
//  store
//
//  Created by yangjun on 16/1/9.
//  Copyright © 2016年 yangjun. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Item : NSObject{
    NSString* content1;
    NSString* content2;
    NSString* content3;
    
    NSString* info;
    
    NSString* pref;
    NSString* effe;
    NSString* diff;
    
    NSNumber* inte;
    NSNumber* chan;
    NSNumber* sour;
    NSNumber* numb;
    NSNumber* clus;
}
@property(retain,nonatomic)    NSString* content1;
@property(retain,nonatomic)    NSString* content2;
@property(retain,nonatomic)    NSString* content3;
@property(retain,nonatomic)    NSString* info;
@property(retain,nonatomic)    NSString* pref;
@property(retain,nonatomic)    NSString* effe;
@property(retain,nonatomic)    NSString* diff;
@property(retain,nonatomic)    NSNumber* inte;
@property(retain,nonatomic)    NSNumber* chan;
@property(retain,nonatomic)    NSNumber* sour;
@property(retain,nonatomic)    NSNumber* numb;
@property(retain,nonatomic)    NSNumber* clus;
- initWithcontent1:(NSString* ) newContent1
         content2:(NSString* ) newContent2
         content3:(NSString* ) newContent3
             info:(NSString* ) newInfo
             pref:(NSString* )newPref
             effe:(NSString* )newEffe
             diff:(NSString* )newDiff
             inte:(NSNumber* )newInte
             chan:(NSNumber* )newChan
             sour:(NSNumber* )newSour
             numb:(NSNumber* )newNumb
             clus:(NSNumber* )newClus;
@end