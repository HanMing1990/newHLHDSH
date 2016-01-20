//
//  InitSqlite3.m
//  store
//
//  Created by yangjun on 16/1/9.
//  Copyright © 2016年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSArray.h>
#import "InitSqlite3.h"
#import "KCDbManager.h"
#import "Item.h"
#define sqlFileName @"plan.sqlite3"

@implementation InitSqlite3
- (void) createDataBase{
    NSString *key=@"IsCreatedDb";
    NSUserDefaults *defaults=[[NSUserDefaults alloc]init];
    
    [defaults setValue:@0 forKey:key];
    
    if ([[defaults valueForKey:key] intValue]!=1) {
        NSLog(@"we create the world!!!");
        [self createPlanItemTable];
        [self createPlanHistoryTable];
        [self createJokeItemTable];
        [self createPictureItemTable];
        [self insertPlanItem];
        [self insertJokeItem];
        [self insertPictureItem];
        [defaults setValue:@1 forKey:key];
    }
    [self outputTable];
}
- (void) insertPlanItem{
    //NSString* content1 = @"hello";
    //NSString* content2 = @"content1";
    //NSString* content3 = @"content2";
    //NSString* info = @"info";
    NSString* pref = @"1";
    NSString* effe = @"1";
    //NSString* diff = @"diff";

    //NSNumber* inte = [[NSNumber alloc] initWithInt:1];
    //NSNumber* chan = [[NSNumber alloc] initWithInt:1];
    //NSNumber* sour = [[NSNumber alloc] initWithInt:1];
    NSNumber* numb = [[NSNumber alloc] initWithInt:0];
    //NSNumber* clus = [[NSNumber alloc] initWithInt:1];
    
    
    NSArray * content1 = [[NSArray alloc] initWithObjects:
      @"写下一件值得感恩的事",
      @"想一想某个值得感恩的人，并向TA表达你的感恩之情",
      @"从积极、值得感恩的角度去思考一件让你不开心的事",
      @"与好友分享一件值得感恩的事情",
      @"向父母表达感恩之情",
      @"问候一个很久没有联系的好友",
      @"记录一件来自陌生人的暖心小事",
      @"记录一件与家人相处的充满爱的小事",   /* class 1 */
      @"想象并写下未来期待中的美好生活",
      @"写下当前困扰你的事",
      //10
      @"写下今天三件开心的事",
      @"关注下上学路上看到的美好景色，并用优美的文字描述一下它",
      @"深呼吸，让自己从焦虑中平静下来",
      @"记录下自己最近的3个小进步",
      @"写下一个最近想要实现的但还没达成的目标",
      @"记录一件你曾经历过的好事、喜事",   /* class 2 */
      @"在心里对自己大喊“停！别想了！”来阻止自己纠结的没完没了",
      @"动起来，选一件自己喜欢的事做起来，把自己从思虑过度中拯救出来",
      @"平静下来，抽出30分钟来思考",
      @"找朋友倾诉",
      //20
      @"将困扰你的事写下来",
      @"唱一首自己喜欢的歌曲",
      @"看一则笑话段子开心一下",        /* class 3 */
      @"试着做三件好事并记录下来",
      @"看一些轻松的图片",
      @"给家人打个问候电话",
      @"给朋友发张电子贺卡",
      @"给最近要过生日的朋友准备一份礼物",
      @"参加一个志愿者活动",
      @"对他人报以微笑",
      //30
      @"记得笑着对服务员说“你好”“谢谢”",   /* class 4 */
      @"试着与父母多一些交流",
      @"和朋友一起散步聊天",
      @"和朋友一起出去吃顿大餐",
      @"和朋友一起去看场电影",
      @"和妈妈一起做顿饭",
      @"和父母一起逛超市采购",
      @"和妈妈一起去买菜",
      @"和朋友一起逛街",
      @"和朋友相约运动一下",
      //40
      @"为家人做一件事",
      @"帮助你的好朋友实现一个小梦想",
      @"与父母或朋友分享你的内心体验",
      @"拥抱父母",
      @"试着拥抱你的好朋友",
      @"和朋友一起玩桌游",          /* class 5 */
      @"集中精力处理和问题有关的事务",
      @"闭眼半分钟，不要想任何事。然后选择一件最重要的事入手完成",
      @"写出这一周的主要工作,并列成条目",
      @"理清必须做的事，制定并记录下相关计划，一步步去完成",
      //50
      @"试着向他人请教以寻求帮助",
      @"写下自己的痛苦，以及感悟",
      @"做一套“ABCDE”思想辩论训练", /* class 6 */
      @"试着谅解那些伤害过你的人",
      @"回忆一下自己给父母带来的伤害，感谢他们原谅了你",
      @"对于给你带来伤害的人，多想想TA好的一面",
      @"不要再回想过去的伤痛",
      @"回忆给你带来伤害的人，试这写下谅解的话",/* class 7 */
      @"选择一种擅长的运动，和朋友一起玩high",
      @"集中精力解决工作或学习中的一个问题，完成后给自己放松",
      //60
      @"给朋友推荐一部喜欢的电影/电视剧，说说自己对它的独到见解", /* class 8 */
      @"回忆并写下过去的一件幸福小事",
      @"抽出几分钟投入地做一件事（吃饭、洗澡、等车等），并仔细体会",
      @"细细体会今天两件快乐的事",
      @"出去晒晒太阳，呼吸一下新鲜空气，感受生活中平凡的小幸福",
      @"找个朋友一起回忆和TA曾经的一件开心小事",
      @"和朋友一起对于一项共同回忆故地重游，重温幸福美好",
      @"和家人一起翻看过去的照片",
      @"和家人一起回忆过去的幸福时光",
      @"去猫咖啡馆和喵星人亲密接触",
      //70
      @"整理一下自己收到的所有礼物，回味幸福",
      @"去户外走走，欣赏大自然",
      @"抽出几分钟欣赏阳光、落日、晚霞或星空",
      @"认真观察感受周围的一切，记录三件身边的快乐、美好与神奇",
      @"做一点简单的伸展运动，集中注意力，在伸展的过程中感受身体细微的变化",
      @"试着沉醉于你进行的任何一项活动中，比如安心享用食物而不思考其他任何",
      @"给自己准备一本随身幸福小相册，心情不好的时候拿出来看一看",
      @"用镜头记录美好的瞬间",
      @"计划一次短途旅行",
      @"听听经典怀旧老歌",
      //80
      @"闭上眼慢慢地欣赏一段轻音乐",
      @"和家人朋友来一个烛光晚餐",
      @"试着买一盆绿植点缀卧室",
      @"试着养一个宠物，推荐植物、乌龟、金鱼",
      @"去拍一套写真，感受一下不同风格的自己",
      @"抽出5分钟，对着镜子微笑",
      @"和朋友一起烧烤、野餐",
      @"试着学习做一道菜，可以加点自己的小创意哦",
      @"沏壶茶，给自己一个小时细细品读美文",    /* class  9*/
      @"给自己定下一个容易实现的小目标，完成后给自己一些小奖励",
      //90
      @"给自己制定一套近期内的一系列小目标，每完成一个就做记录并给自己小奖励", /* class  10 */
      @"抽出10分钟进行冥想训练",
      @"去操场慢跑30分钟",
      @"上一节瑜伽课",
      @"试试跳绳",
      @"去健身房运动一下",
      @"上一节舞蹈课",
      @"和朋友相约去打球",
      @"抽出5分钟，跟着视频做一节呼吸操",
      @"阳光明媚的日子和一众朋友去骑行",
      @"游一场泳",   /* class 11 */
      //100
                                                          nil];
    NSArray * info = [[NSArray alloc] initWithObjects:@"写下一件值得感恩的事",
                                                      @"向他人表达你的感恩之情",
                                                      @"从积极的角度去思考",
                                                      @"与好友分享一件值得感恩的事情",
                                                      @"向父母表达感恩之情",
                                                      @"问候好友",
                                                      @"记录暖心小事",
                                                      @"记录充满爱的小事",   /* class 1 */
                                                      @"想象并写下期待的生活",
                                                      @"积极面对困扰",
                                                      //10
                                                      @"写下今天三件开心的事",
                                                      @"记录美好景色",
                                                      @"深呼吸",
                                                      @"记录下小进步",
                                                      @"写下你的计划",
                                                      @"记录一件好事",   /* class 2 */
                                                      @"停止纠结",
                                                      @"做自己喜欢的事",
                                                      @"静心来思考",
                                                      @"找朋友倾诉",
                                                      //20
                                                      @"丢掉困扰的包袱",
                                                      @"用歌声释放自己",
                                                      @"来看一则笑话吧",
                                                      @"做三件好事",       /* class 3 */
                                                      @"看轻松的图片",
                                                      @"电话问候家人",
                                                      @"给朋友发电子贺卡",
                                                      @"给要过生日的朋友准备礼物",
                                                      @"参加志愿活动",
                                                      @"对他人报以微笑",
                                                      //30
                                                      @"与服务员互动",   /* class 4 */
                                                      @"与父母交流想法",
                                                      @"和朋友散步聊天",
                                                      @"和朋友吃顿大餐",
                                                      @"和朋友看场电影",
                                                      @"和妈妈做饭",
                                                      @"和父母逛超市",
                                                      @"和妈妈去买菜",
                                                      @"和朋友逛街",
                                                      @"和朋友相约运动",
                                                      //40
                                                      @"为家人做一件事",
                                                      @"给好朋友帮助",
                                                      @"与父母或朋友分享",
                                                      @"拥抱父母",
                                                      @"试着拥抱好朋友",
                                                      @"和朋友玩桌游",          /* class 5 */
                                                      @"集中精力做事",
                                                      @"闭眼",
                                                      @"给工作排优先级",
                                                      @"理清当前的工作",
                                                      //50
                                                      @"向他人请教",
                                                      @"写下痛苦和感悟",
                                                      @"做一套训练题", /* class 6 */
                                                      @"谅解别人",
                                                      @"回忆一件谅解的事",
                                                      @"试着谅解他人",
                                                      @"不要回想伤痛的事",
                                                      @"尝试谅解他人",   /* class 7 */
                                                      @"去玩擅长的运动",
                                                      @"集中精力工作",
                                                      //60
                                                      @"向朋友推荐", /* class 8 */
                                                      @"回忆一件幸福小事",
                                                      @"投入地做一件事",
                                                      @"回味快乐的事",
                                                      @"去户外晒晒太阳",
                                                      @"回忆开心小事",
                                                      @"故地重游",
                                                      @"翻看过去的照片",
                                                      @"回忆幸福时光",
                                                      @"尝试新鲜的事",
                                                      //70
                                                      @"整理收到过的礼物",
                                                      @"去户外走走",
                                                      @"欣赏自然美景",
                                                      @"记录生活",
                                                      @"做简单的伸展运动",
                                                      @"试着沉醉于当前活动",
                                                      @"给做一个幸福小相册",
                                                      @"用镜头记录美好的瞬间",
                                                      @"计划一次短途旅行",
                                                      @"听听经典怀旧老歌",
                                                      //80
                                                      @"闭上眼欣赏一段轻音乐",
                                                      @"和家人朋友来一个烛光晚餐",
                                                      @"试着买一盆绿植",
                                                      @"试着养一个宠物",
                                                      @"去拍一拍写真",
                                                      @"对着镜子微笑",
                                                      @"和朋友一起烧烤、野餐",
                                                      @"试着学习做一道菜",
                                                      @"品读美文",    /* class 9 */
                                                      @"完成一个小目标",
                                                      //90
                                                      @"制定一系列小目标",/* class 10 */
                                                      @"冥想",
                                                      @"慢跑",
                                                      @"上一节瑜伽课",
                                                      @"试试跳绳",
                                                      @"去健身房运动一下",
                                                      @"上一节舞蹈课",
                                                      @"和朋友相约去打球",
                                                      @"做一节呼吸操",
                                                      @"和朋友去骑行",
                      
                                                      @"游一场泳",   /* class 11 */
                                                    //100
                      
                                                      nil];
    NSArray * content2 = [[NSArray alloc] initWithObjects:
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"试着用积极的态度去分析它的前因后果",
      @"",@"",@"",@"",@"为这个目标定出你的计划",@"",@"",@"",@"",@"",
      @"不要有思想负担，甩开包袱，轻装前进",@"",@"",@"",@"",@"",@"",@"",@"",@"",
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
      @"",@"",@"",@"",@"",@"",@"",@"",@"排好它们的优先级，按优先级去完成",@"",
                          
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
                                                          nil];
    NSArray * content3 = [[NSArray alloc] initWithObjects:
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
      @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",
                                                          nil];

    NSArray * inte = [[NSArray alloc] initWithObjects:
      @"2",@"1",@"1",@"1",@"1",@"1",@"2",@"2",@"2",@"3",
      @"4",@"2",@"1",@"4",@"1",@"2",@"1",@"1",@"1",@"1",
      @"2",@"1",@"6",@"4",@"7",@"1",@"1",@"1",@"1",@"1",
      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"5",@"1",
      
      @"1",@"2",@"1",@"1",@"1",@"1",@"1",@"2",@"1",@"1",
      @"1",@"2",@"1",@"4",@"1",@"1",@"1",@"1",@"1",@"1",
      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      nil];
    NSArray * diff = [[NSArray alloc] initWithObjects:
      @"0.1",@"0.2",@"0.3",@"0.4",@"0.5",@"0.6",@"0.7",@"0.8",@"0.9",@"1.0",
      @"0.1",@"0.2",@"0.3",@"0.4",@"0.5",@"0.6",@"0.7",@"0.8",@"0.9",@"1.0",
      @"0.1",@"0.2",@"0.3",@"0.4",@"0.5",@"0.6",@"0.7",@"0.8",@"0.9",@"1.0",
      @"0.1",@"0.2",@"0.3",@"0.4",@"0.5",@"0.6",@"0.7",@"0.8",@"0.9",@"1.0",
      @"0.1",@"0.2",@"0.3",@"0.4",@"0.5",@"0.6",@"0.7",@"0.8",@"0.9",@"1.0",

      @"0.1",@"0.2",@"0.3",@"0.4",@"0.5",@"0.6",@"0.7",@"0.8",@"0.9",@"1.0",
      @"0.1",@"0.2",@"0.3",@"0.4",@"0.5",@"0.6",@"0.7",@"0.8",@"0.9",@"1.0",
      @"0.1",@"0.2",@"0.3",@"0.4",@"0.5",@"0.6",@"0.7",@"0.8",@"0.9",@"1.0",
      @"0.1",@"0.2",@"0.3",@"0.4",@"0.5",@"0.6",@"0.7",@"0.8",@"0.9",@"1.0",
      @"0.1",@"0.2",@"0.3",@"0.4",@"0.5",@"0.6",@"0.7",@"0.8",@"0.9",@"1.0",
                                                     nil];
    NSArray * chan = [[NSArray alloc] initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                      
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      nil];
    NSArray * sour = [[NSArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"2",@"2",@"2",@"2",@"2",
                                                      @"3",@"3",@"3",@"3",@"3",@"3",@"3",@"3",@"3",@"3",
                                                      @"4",@"4",@"4",@"4",@"4",@"4",@"4",@"4",@"4",@"4",
                                                      @"4",@"4",@"4",@"5",@"5",@"5",@"5",@"5",@"5",@"5",
                                                      
                                                      @"5",@"5",@"6",@"6",@"6",@"6",@"6",@"7",@"7",@"7",
                                                      @"8",@"8",@"8",@"8",@"8",@"8",@"8",@"8",@"8",@"8",
                                                      @"8",@"8",@"8",@"8",@"8",@"8",@"8",@"8",@"8",@"8",
                                                      @"8",@"8",@"8",@"8",@"8",@"8",@"8",@"8",@"9",@"9",
                                                      @"9",@"9",@"9",@"9",@"9",@"9",@"9",@"9",@"9",@"9",
                                                      nil];
    NSArray * clus = [[NSArray alloc] initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      @"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",
                                                      nil];
    KCDbManager *manager = [KCDbManager new];
    [manager openDb:sqlFileName];
    int loop;
    for(loop = 0; loop < SUM_OF_ITEM; loop ++){
        //给笑话和图片加上比较大的权重
        if (loop == 22 || loop == 24) {
            effe = @"20";
        }else{
            effe = @"1";
        }
        NSArray* array = [[NSArray alloc] initWithObjects:content1[loop], content2[loop], content3[loop], info[loop], pref, effe, diff[loop], inte[loop], chan[loop], sour[loop], numb, clus[loop], nil];
        NSString * sql = [NSString stringWithFormat:@"INSERT INTO PlanList (\
                          content1 ,content2 , content3 ,info ,pref , effe ,\
                          diff , inte , chan , sour , numb , clus) VALUES \
                          ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",array[0],array[1],array[2],array[3],array[4],array[5],array[6],array[7],array[8],array[9],array[10],array[11]];
        [manager executeNonQuery:sql];
    }
    [manager close];
}
- (void) outputTable{
    NSString *sql= @"SELECT * FROM PlanList ORDER BY ID";
    KCDbManager* manager = [KCDbManager new];
    [manager openDb:sqlFileName];
    NSArray * all = [manager executeQuery:sql];
    for(int i=0;i<all.count;i++){
        NSLog(@"output item %i ",i);
        Item *item = [Item new];
        item.content1 = [all[i] objectForKey:@"content1"];
        item.content2 = [all[i] objectForKey:@"content2"];
        item.content3 = [all[i] objectForKey:@"content3"];
        item.info = [all[i] objectForKey:@"info"];
        item.pref = [all[i] objectForKey:@"pref"];
        item.effe = [all[i] objectForKey:@"effe"];
        item.diff = [all[i] objectForKey:@"diff"];
        item.inte = [all[i] objectForKey:@"inte"];
        item.chan = [all[i] objectForKey:@"chan"];
        item.sour = [all[i] objectForKey:@"sour"];
        item.numb = [all[i] objectForKey:@"numb"];
        item.clus = [all[i] objectForKey:@"clus"];
        NSLog(@"succeed output a value:");
        NSLog(@"%@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@",item.content1,item.content2,item.content3,item.info, item.pref, item.effe, item.diff, item.inte, item.chan, item.sour, item.numb, item.clus);
    }
    [manager close];
}
- (void) createPlanItemTable{
    NSString *drop_if_exists = @"DROP TABLE IF EXISTS PlanList;";
    NSString *sql=      @"CREATE TABLE PlanList (id integer PRIMARY KEY AUTOINCREMENT,\
         content1 text,content2 text, content3 text,info text,pref text, effe text,\
    diff text, inte integer, chan integer, sour integer, numb integer, clus integer\
    )";
    
    KCDbManager* manager = [KCDbManager new];
    [manager openDb:sqlFileName];
    [manager executeNonQuery:drop_if_exists];
    [manager executeNonQuery:sql];
    [manager close];
}
- (void) createPlanHistoryTable{
    NSString *sql=@"CREATE TABLE History (id integer PRIMARY KEY AUTOINCREMENT,\
    done integer,have integer,number integer, currentNumber integer, id1 integer, id2 integer,id3 integer,\
    id4 integer, type1 integer, type2 integer, type3 integer, type4 integer,time0 text, time1 text,time2 \
    text,time3 text,time4 text,fintime1 text, fintime2 text, fintime3 text, fintime4 text, fin1 integer,\
    fin2 integer,fin3 integer, fin4 integer, output1 text, output2 text, output3 text, output4 text, \
    stress0 text, stress1 text, stress2 text,stress3 text, stress4 text, stress5 text,effect text)";
    KCDbManager* manager = [KCDbManager new];
    [manager openDb:sqlFileName];
    [manager executeNonQuery:sql];
    [manager close];
}
- (void) createJokeItemTable{
    NSString *drop_if_exists = @"DROP TABLE IF EXISTS JokeList;";
    NSString *sql=      @"CREATE TABLE JokeList (id integer PRIMARY KEY AUTOINCREMENT,sentence text)";
    KCDbManager* manager = [KCDbManager new];
    [manager openDb:sqlFileName];
    [manager executeNonQuery:drop_if_exists];
    [manager executeNonQuery:sql];
    [manager close];
}
- (void) createPictureItemTable{
    NSString *drop_if_exists = @"DROP TABLE IF EXISTS PictureList;";
    NSString *sql=      @"CREATE TABLE PictureList (id integer PRIMARY KEY AUTOINCREMENT,\
    sentence text,pictureName text, type text)";
    KCDbManager* manager = [KCDbManager new];
    [manager openDb:sqlFileName];
    [manager executeNonQuery:drop_if_exists];
    [manager executeNonQuery:sql];
    [manager close];
}
- (void) insertJokeItem{
    NSString *joke[SUM_OF_JOKE]={
        @"上小学三年级时我总欺负同桌，直到有天她老爸来给她送伞，看她老爸光头纹身，一脸的横肉！\r\n我问她：“你老爸干嘛的？”\r\n她说贩毒的！\r\n从那以后再也不敢欺负她了！直到有一天，我看到她爸在街上卖老鼠药。。。",
        @"我学的美术，我问朋友能否画一张他的画象作为课堂作业。\r\n他同意了，我画好后交上，只得了个C。\r\n我问为什么给这么低的分，教授说我的画比例不对：“头太大，肩太宽，胳膊太细。”\r\n第二天，我带朋友去见教授。\r\n教授瞧了朋友一眼，说：“好吧，A。”",
        @"上课的时候我正津津有味的玩手机，突然坐在窗子边的同学喊：注意了，校长来了。\r\n我连忙把手机藏好然后清了清嗓子说：同学们，今天我们讲第三章。",
        @"这次的四级考试还不错，发货挺快的坐下就收到卷子了，试卷印刷很清晰，题型都全了，监考老师服务态度挺好给一个赞，唯一不好的就是都是回头客还不给优惠。总体五星好评，下次还会再来的。",
        @"中学时的数学李老师特别能拖堂，有天漂亮的语文老师很奇怪的问：为什么你们总是管你们李老师叫托塔李天王呢？！\r\n同学说：老师，你听错了，是拖堂李天王。\r\n语文老师:噗。。。",
    };
    KCDbManager *manager = [KCDbManager new];
    [manager openDb:sqlFileName];
    int loop;
    for(loop = 0; loop < SUM_OF_JOKE; loop ++){
        NSString * sql = [NSString stringWithFormat:@"INSERT INTO JokeList (sentence) VALUES ('%@')",joke[loop]];
        [manager executeNonQuery:sql];
    }
    [manager close];
}
- (void) insertPictureItem{
    NSString* sentence[SUM_OF_PICTURE] = {
        @"要轻盈的像鸟，而不是羽毛。",
        @"如果可以，请直视生活中不被阳光照耀的角落、 被压迫者的痛苦和我们自己的软弱。",
        @"这世上一定还藏着很多很多只要坚持寻找，就能找到的东西。",
        @"电脑前的取暖装备和姿势，你最适合哪一种？",
        @"孤单是一种境界。",
        @"永远不要认为我们可以逃避，我们的每一步都决定着最后的结局，我们的脚正在走向我们自己选定的终点。",
        @"把我们带到过去的是回忆，将我们带向未来的是梦想。",
        @"你看到什么样的世界，你就拥有什么样的内心。",
        @"一个人路过晴天也好，穿行风雨也罢，希望你能接受，孤独才是人生常态。",
        @"我们领教了世界是何等凶顽，同时又得知世界也可以变得温存和美好。——村上春树",
        @"丢掉垃圾,保持好心情",
        @"雪绒花，短暂而永恒的美丽，装点着这纯真的世界。",
        @"生活中没有什么是一成不变的，我们只有一个选择：对生活充满希望，继续前进。",
        @"别人不是你的彼岸",
        @"可爱的食物",
        @"可爱的食物",
        @"永远不要拿你自己和任何人比，你是最美的。",
        @"人的成长秘密，就是去不断淘汰自己，找到完美的路。",
        @"很希望自己是一棵树，守静，向光，安然，敏感的神经末梢，触着流云和微风，窃窃的欢喜。脚下踩着最卑贱的泥，很踏实。还有，每一天都在隐秘成长。——黎戈",
        @"就算生活有一些挫折，还是要对自己微笑。",
        @"一万个美丽的未来，抵不上一个温暖的现在。加油！",
        @"桃红复含宿雨，柳绿更带春烟。花落家童未扫，莺啼山客犹眠。",
        @"偶尔要回头看看，否则永远都在追寻，而不知道自己失去了什么。",
        @"你能留给岁月的，岁月能留给你的，除了一个最好的自己，别无他物。",
        @"生命中，有些人即使不在你身边也能让你微笑，这样真好。",
        @"一家人就是应该一起吃饭",
        @"当你在清晨醒来，想想活着是一种多么珍贵的权利：你还能呼吸，还能思考，还能享受，还能去爱。",
        @"有时可以静下来，看看这个世界，看看晒着阳光的苔藓们，看看这一丛丛鲜活的碧绿。",
        @"我们总能在最深的绝望里，看到最美的风景。",
        @"愿你被很多人爱。如果没有，愿你在寂寞中学会宽容。",
        @"所有的喵星人都拥有软糯糯的爪子和软绵绵的肉垫 ，如果我肯把爪子给你，是因为我信任和喜欢你",
        @"这是你的人生，你必须为之奋斗。为你认为对的事情奋斗，为那些对于你来说重要的东西而奋斗，为你爱的人而奋斗。",
        @"有时候，你需要走出去，呼吸呼吸新鲜空气，提醒自己你是谁，你想要成为谁。",
        @"有些事，与其花时间逃避，不如早一点面对。",
        @"生活处处是快乐，只要有一颗善良细腻的心，那么一切都会是幸福的源泉",
        @"最温暖的事，莫过于陪伴。",
        @"成长会让人明白，唯一后悔的只是那些自己不曾尝试的事。",
        @"向日葵的理想，是伴随着太阳起落，用自己沉默的爱，去追求自己想要的幸福。",
        @"有一条路，每个人非走不可，那就是年轻时候的弯路。——张爱玲",
        @"假如我们把自己力所能及的事都完成了，我们会真的令自己大吃一惊。",
        @"知识永远是我们的小伙伴。",
        @"身是菩提树，心如明镜台。时时勤拂拭，莫使惹尘埃。",
        @"是不是坐久了感觉全身硬邦邦，有时候腰酸背痛。教大家三个动作，让大家摆脱头晕，背痛困扰。",
        @"用一杯水的单纯，面对一辈子的复杂。",
        @"每一个今日，都是你曾经幻想的明天，所以请为这个今天而努力。",
        @"活在当下，别在怀念过去或者憧憬未来中浪费掉你现在的生活。",
        @"在世如莲，净心素雅，不污不垢，淡看浮华。",
        @"随光阴流转的是岁月，随岁月流逝的是人生，而随人生流动的是风景。",
        @"出路出路，走出去才有路",
        @"吃饭，睡觉，打豆豆",
        @"像小黄人一样开心。",
        @"做一只幸福的小黄人。",
        @"和朋友在一起最开心。",
        @"友情弥足珍贵。",
        @"我们本该满足，再多便是贪婪。",
        @"猫咪老师一天的生活",
        @"梦想这种东西啊，只有能持续最初冲动的人才能实现。",
        @"人生就如同一辆列车，我们在这趟列车上碰上形形色色的人，他们来来往往，在我们的身边来了又去，但终究会成为过客；所以，请善待身边的人。",
        @"不能僭越的是生死边界，可以融合的是心灵体温 。纵有疾风起，人生不言弃。——《起风了》",
        @"生活还是很美好的!加油呀少年！",
        @"优点和缺点的分界未必很明显，关键在于心态。",
        @"你是不是也有这样一个萌萌的好朋友~有什么不开心的可以告诉它~",
        @"勤运动，坏心情就随着汗水消失啦！",
        @"可爱妞妞阿格尼丝Agnes表情集，嘟嘟的小脸蛋很萌很治愈"
    };
    
    KCDbManager *manager = [KCDbManager new];
    [manager openDb:sqlFileName];
    int loop;
    NSString* pictureName;
    
    int type;
    for(loop = 1; loop <= SUM_OF_PICTURE; loop ++){

        if (loop == 12 || loop > 50 || loop == 31) {
            type = 2;
        }else{
            type = 1;
        }
        if (loop <= 50) {
            pictureName = [NSString stringWithFormat:@"%i.jpg",loop];
        }else{
            pictureName = [NSString stringWithFormat:@"%i.gif",loop];
        }
        NSString * sql = [NSString stringWithFormat:@"INSERT INTO PictureList (sentence, pictureName, type) VALUES ('%@','%@','%@')",sentence[loop-1],pictureName,[NSNumber numberWithInt:type]];
        [manager executeNonQuery:sql];
    }
    
    [manager close];
}
@end