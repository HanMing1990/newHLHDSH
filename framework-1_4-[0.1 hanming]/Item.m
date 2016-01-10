//
//  Item.m
//  store
//
//  Created by yangjun on 16/1/9.
//  Copyright © 2016年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@implementation Item
@synthesize content1;
@synthesize content2;
@synthesize content3;
@synthesize info;
@synthesize pref;
@synthesize effe;
@synthesize diff;
@synthesize inte;
@synthesize chan;
@synthesize sour;
@synthesize numb;
@synthesize clus;
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
              clus:(NSNumber* )newClus{
    if(self = [super init]){
        self.content1 = newContent1;
        self.content2 = newContent2;
        self.content3 = newContent3;
        self.info = newInfo;
        self.pref = newPref;
        self.effe = newEffe;
        self.diff = newDiff;
        self.inte = newInte;
        self.chan = newChan;
        self.sour = newSour;
        self.numb = newNumb;
        self.clus = newClus;
    }
    return self;
}

@end
