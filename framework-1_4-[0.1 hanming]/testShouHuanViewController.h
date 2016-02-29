//
//  testShouHuanViewController.h
//  framework-1_4-[0.1 hanming]
//
//  Created by 韩明 on 16/2/27.
//  Copyright © 2016年 韩明. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ASYNC_MAIN_QUEUE_START \
dispatch_async(dispatch_get_main_queue(), ^(){ \
if (error) { \
[self showAlertWithString:[NSString stringWithFormat:@"%@", error]]; \
}else{

#define ASYNC_MAIN_QUEUE_END \
} \
});

@interface testShouHuanViewController : UIViewController

@end
