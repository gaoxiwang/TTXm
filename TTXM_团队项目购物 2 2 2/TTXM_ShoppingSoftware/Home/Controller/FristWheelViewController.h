//
//  FristWheelViewController.h
//  TTXM_ShoppingSoftware
//
//  Created by lanou3g on 16/1/15.
//  Copyright © 2016年 周洪庆. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidSelectedEnder)();


@interface FristWheelViewController : UIViewController

@property (copy,nonatomic)DidSelectedEnder didSelectedEnder;


@end
