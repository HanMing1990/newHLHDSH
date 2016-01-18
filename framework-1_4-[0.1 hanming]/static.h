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

#endif /* static_h */
