//
//  CityInfoView.h
//  testUIKit
//
//  Created by serriezhang on 2019/6/6.
//  Copyright © 2019 serriezhang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface CityInfoView : UIView
@property (nonatomic, strong) UIControl *overlayView;
@property (nonatomic, strong) UITextView* infoText;

@property (nonatomic, strong) NSMutableString* cityName;

- (CityInfoView* )initWithName:(NSMutableString*) name andDetail:(NSString*) detailText;
-(void)show;
@end

NS_ASSUME_NONNULL_END
