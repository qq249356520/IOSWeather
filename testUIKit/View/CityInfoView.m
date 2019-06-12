//
//  CityInfoView.m
//  testUIKit
//
//  Created by serriezhang on 2019/6/6.
//  Copyright © 2019 serriezhang. All rights reserved.
//

#import "CityInfoView.h"

@implementation CityInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//设置textview内容居中
- (void)contentSizeToFit{
    //先判断一下有没有文字（没文字就没必要设置居中了）
    if([self.infoText.text length]>0){
        //textView的contentSize属性
        CGSize contentSize = self.infoText.contentSize;
        //textView的内边距属性
        UIEdgeInsets offset;
        CGSize newSize = contentSize;
        
        //如果文字内容高度没有超过textView的高度
        if(contentSize.height <= self.infoText.frame.size.height)
        {
            //textView的高度减去文字高度除以2就是Y方向的偏移量，也就是textView的上内边距
            CGFloat offsetY = (self.infoText.frame.size.height - contentSize.height)/2 - 110;
            offset = UIEdgeInsetsMake(offsetY, 0, 0, 0);
        }
        else          //如果文字高度超出textView的高度
{
            newSize = self.infoText.frame.size;
            offset = UIEdgeInsetsZero;
            
            //通过一个while循环，设置textView的文字大小，使内容不超过整个textView的高度（这个根据需要可以自己设置）
            while (contentSize.height > self.infoText.frame.size.height)
            {
                [self.infoText setFont:[UIFont fontWithName:@"Helvetica Neue" size:20]];
                contentSize = self.infoText.contentSize;
            }
            newSize = contentSize;
        }
        
        //根据前面计算设置textView的ContentSize和Y方向偏移量
        [self.infoText setContentSize:newSize];
        [self.infoText setContentInset:offset];
        
    }
}

- (CityInfoView* )initWithName:(NSMutableString*) name andDetail: (NSString*) detailText{
    self = [super init];
    if (self) {
        //布局
        CGFloat leftSideSpace = 50;
        CGFloat upSideSpace = (SCREEN_HEIGHT - 300) / 2;
        self.frame = CGRectMake(leftSideSpace, upSideSpace + 50, SCREEN_WIDTH - 2 * leftSideSpace, 300);
        //    176 196 222
        self.backgroundColor = [UIColor colorWithRed:176/255.0 green:196/255.0 blue:222/255.0 alpha:0.96];
        
        //设置圆角角度
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
        
        //text
        self.infoText = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 2 * leftSideSpace, 500)];
        
        NSMutableString* str = [NSMutableString stringWithFormat:@"             %@", name];
        if(![detailText  isEqual: @" 城市信息有误//未查询到天气状况！！"]){
            [str appendFormat:@"\n             一座美丽的城市"];
        }
        else{
            [str appendFormat:@"\n             城市信息不存在"];
        }

        self.infoText.text = str;
        self.infoText.editable = NO;
        self.infoText.font = [UIFont systemFontOfSize:20];
        self.infoText.textColor = [UIColor blackColor];
        self.infoText.backgroundColor = [UIColor clearColor];
        
        [self contentSizeToFit];
        [self addSubview:_infoText];
        
        //控制 消失返回
        self.overlayView = [[UIControl alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
        [self.overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

//页面展示
-(void)show{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:self.overlayView];
    [keywindow addSubview:self];
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.35 animations:^{
        weakSelf.alpha = 1;
        weakSelf.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

//页面消失
-(void)dismiss{
    [self.overlayView removeFromSuperview];
    //消除当前view方法
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end
