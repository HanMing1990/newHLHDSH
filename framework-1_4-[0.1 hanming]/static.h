//
//  static.h
//  framework-1_4-[0.1 hanming]
//
//  Created by yangjun on 16/1/17.
//  Copyright © 2016年 韩明. All rights reserved.
//

#ifndef static_h
#define static_h

#define planFileName    @"plan.plist"
#define levelFileName   @"level.plist"
#define sqlFileName     @"plan.sqlite3"

#define SUM_OF_ITEM     100
#define EFFECT_BIAS     1.0   //用来计算effect，计算公式暂时定位  （ effe + EFFECT_BIAS ）／ EFFECT_BIAS
#define PREFERENCE_BIAS 0.6   //这个是用来更新这个 pref 滴，如果他做啦就除以这个值（变大啦），如果没做，就乘上这个值（变小啦）

#define PLANSOURCE0 @"plansource0"  //为了显示图片
#define PLANSOURCE1 @"plansource1"
#define PLANSOURCE2 @"plansource2"
#define PLANSOURCE3 @"plansource3"
#define PLANSOURCE4 @"plansource4"
#define PLANSOURCE5 @"plansource5"
#define PLANSOURCE6 @"plansource6"
#define PLANSOURCE7 @"plansource7"
#define PLANSOURCE8 @"plansource8"
#define PLANSOURCE9 @"plansource9"
#define PLANSOURCE10 @"plansource10"

#define PLANDATE @"currentPlanDate" //设置userdefault
#define PLANINFO @"currentPlanInfo"
#define PLANTEXT @"currentPlanText"
#define PLANID   @"currentPlanId"
#define PLANSOUR @"currentPlanSour"
#define PLANTYPE @"currentPlanType"
#endif /* static_h */
