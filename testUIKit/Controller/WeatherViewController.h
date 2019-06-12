//
//  testViewController.h
//  testUIKit
//
//  Created by serriezhang on 2019/6/1.
//  Copyright © 2019 serriezhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "CityInfoView.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface WeatherViewController : UIViewController

@property(nonatomic, strong) CityInfoView* cinfoView;

@property(nonatomic, strong) UIControl *overlayView;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic, strong) UITextView* detialText;

@property(nonatomic, strong) NSMutableString* cityName;
@property(nonatomic, strong) NSDictionary* dict;
-(void)weatherRequestTask;
@end

NS_ASSUME_NONNULL_END
