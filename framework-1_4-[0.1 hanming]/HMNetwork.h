//
//  HMNetwork.h
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/20.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"

#ifndef HMNetwork_h
#define HMNetwork_h
@interface HMNetwork : NSObject{
}
//@property(retain,nonatomic) NSNumber* ID;
@property(retain, nonatomic) MKNetworkHost* engine;
-(id) init;
-(void) sendData: (NSMutableDictionary *)param;
- (void)sendPlanHistory;
- (void)sendPlanItemByID;
@end

#endif /* HMNetwork_h */
