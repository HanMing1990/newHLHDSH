//
//  Item.h
//  store
//
//  Created by yangjun on 16/1/9.
//  Copyright © 2016年 yangjun. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Item : NSObject{
    NSNumber* ID;          // id
    NSString* content1;    // 第一个字段
    NSString* content2;    // 第二个字段
    NSString* content3;    // 第三个字段
    
    NSString* info;        //缩略字段，用于显示缩略信息，在日程表上显示
    
    NSString* pref;        //偏好，float，用户对此item的喜爱程度，初始化为1，根据用户是否完成进行调整
    NSString* effe;        //效果，float，用户对此item的使用效果，初始化为1，根据用户完成后压力值的变化进行调整
    NSString* diff;        //难度，float，（0.0～1.0）item客观属性，表示item的执行时间／执行代价
    
    NSNumber* inte;        //交互类型，决定用户用户执行计划的页面，
                           /*
                            0: 只显示文字，让用户看，没有任何其他的交互       # 看则笑话吧：话说有一天｀｀｀｀
                            1: 只显示文字，让用户做                       #  发个朋友圈一个校园景色吧
                            2: 显示文字，文字下面有输入框                  # 写下一个高兴的事［］
                            3: 显示文字，文字下面有输入框，输入框下面有文字   ＃写下一个误解的事［］现在试着做出一些改变
                            4: 显示文字＋三个输入框                       ＃记录下三个开心的事
                            5: 显示文字＋输入框＋显示文字＋输入框           ＃文字＋［］＋文字＋［］
                            6: 显示文字＋笑话（从数据库中获得）             ＃文字＋文字
                            
                            */
    NSNumber* chan;        //是否可替换
                            /*
                             0: 不可替换
                             1: 可替换
                             */
    NSNumber* sour;        //压力源
                            /*
                             0:表达感恩之情
                             1:培养乐观的心态
                             2:避免思虑过度
                             3:多行善事
                             4:维护人际关系
                             5:积极应对问题
                             6:学会谅解
                             7:增加心流体验
                             8:享受生活
                             9:努力实现目标
                             10:放松运动
                             */
    NSNumber* numb;        //这个item做过几次，初始值为0
    NSNumber* clus;        //cluster，表示相近的类型，替换的时候首先考虑相同cluster的
}
@property(retain,nonatomic)    NSNumber* ID;
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
             clus:(NSNumber* )newClus
               ID:(NSNumber* )newID;
@end