//
//  analysisViewController.h
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/1/5.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChart.h" //数据可视化, old

@interface analysisViewController : UIViewController{
    NSNumber* currentId;
}
@property (nonatomic) PNLineChart * lineChart;//数据可视化,old
@property (retain,nonatomic) NSNumber* currentId;
@end
