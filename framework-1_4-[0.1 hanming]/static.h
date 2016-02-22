//
//  static.h
//  framework-1_4-[0.1 hanming]
//
//  Created by yangjun on 16/1/17.
//  Copyright © 2016年 韩明. All rights reserved.
//

#ifndef static_h
#define static_h

#define planFileName    @"plan.plist"    //CurrentPlan对应的存储文件，只存当前的计划,具体定义参考CurrentPlan.h
#define levelFileName   @"level.plist"   //CurrentLevel对应的存储文件，存储当前最新的压力值、睡眠值、步数值、卡路里值,具体定义参考CurrentLevel.h
#define sqlFileName     @"plan.sqlite3"  //数据库名称，这个数据库里面有很多表，具体定义参考initSqlite3.h

#define SUM_OF_ITEM     100   //数据库planList里面的item的总数为SUM_OF_ITEM，如果要增加或者删减item需要更改这个值
#define SUM_OF_JOKE     66     //数据库jokeList里面的joke的总数为SUM_OF_JOKE，如果要增加或者删减joke需要更改这个值
#define SUM_OF_PICTURE  65    //数据库pictureList里面的joke的总数为SUM_OF_PICTURE，如果要增加或者删减picture需要更改这个值
#define EFFECT_BIAS     1.0   //用来计算effect，计算公式暂时定位  （ effe + EFFECT_BIAS ）／ EFFECT_BIAS
#define PREFERENCE_BIAS 0.6   //这个数是一个0～10的浮点数，这个是用来更新这个pref 滴，如果他做啦就除以这个值（变大啦），如果没做，就乘上这个值（变小啦）
//为了通过sour值显示图片，各种图片对应的意义为item.h中的sour字段意义
#define PLANSOURCE0 @"plansource0"
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
//设置userdefault，传参数，从planViewController到exeViewController或者在“换一个”时exeViewController到exeViewController需要设置
#define PLANDATE   @"currentPlanDate"
#define PLANINFO   @"currentPlanInfo"        //对应item.h中的info
#define PLANTEXT   @"currentPlanText"        //对应item.h中的content1
#define PLANID     @"currentPlanId"          //对应item.h中的id
#define PLANSOUR   @"currentPlanSour"        //对应item.h中的sour
#define PLANTYPE   @"currentPlanType"        //对应item.h中的inte－》交互类型inte作为判断跳到哪一个exeviewcontroller的方式
#define PLANSTATE  @"currentPlanState"       //0:一天以前，不可以做，显示完成情况 1:一天之内 2:一天以后啦  这个的定义在planviewcontroller中的planBtnClicked里面
#define PLANFINTIME @"currentPlanFinTime"    //对应currentPlan.h中的fintime
#define PLANOUTPUT @"currentPlanOutput"      //对应currentPlan.h中的output
#define PLANFIN    @"currentPlanFin"         //对应currentPlan.h中的fin

#define HISTORYID  @"currentHistoryID"       //作为historyviewcontroller到analysisviewcontroller的参数

#define IP         @"166.111.69.137"
#define PORT       @"5000"


#define HISTORY_NUM 4     //显示history的页面显示的数量
#define PLAN_NUM 3   //显示一个plan有多少个item，并在currentplan.h初始化时初始化currentplan.number,后来的每个plan的数量都要在createplan中进行设置
#endif /* static_h */
