//
//  testViewController.m
//  testUIKit
//
//  Created by serriezhang on 2019/6/1.
//  Copyright © 2019 serriezhang. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController()

@end

@implementation WeatherViewController

- (instancetype)init{
    if (self = [super init]) {
        self.title = @"详细情况列表";
    }
    return self;
}

//api请求
-(void)weatherRequestTask{
    //做get请求
    NSMutableString* urlString =
    [NSMutableString stringWithFormat:@"https://www.apiopen.top/weatherApi?city=%@", _cityName];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //创建管理者
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    //设置接受的响应数据类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //get请求
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* getWeather = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if([[getWeather objectForKey:@"msg"]  isEqual: @"成功!"]){
            NSMutableString* resStr = [[NSMutableString alloc]init];
            NSDictionary* dataDict = [NSDictionary dictionaryWithDictionary:[getWeather objectForKey:@"data"]];
            NSMutableArray* forecastArr = [NSMutableArray arrayWithArray: [dataDict objectForKey:@"forecast"]];
            NSMutableString* notice = [NSMutableString stringWithFormat:@"%@", [dataDict objectForKey:@"ganmao"]];
            
            //拼接字符串
            for(int i = 0; i < forecastArr.count; i++){
                NSDictionary* dateDic = [forecastArr objectAtIndex:i];
                [resStr appendString:@"日期："];
                [resStr appendString:[dateDic objectForKey:@"date"]];
                [resStr appendString:@"\n"];
                [resStr appendString:@"风力："];
                NSMutableString* fengliStr = [NSMutableString stringWithFormat:@"%@", [dateDic objectForKey:@"fengli"]];
                [fengliStr deleteCharactersInRange:NSMakeRange(0, 9)];
                NSRange range = [fengliStr rangeOfString:@"]]>"];
                [fengliStr deleteCharactersInRange:range];
                [resStr appendString:fengliStr];
                [resStr appendString:@"\n"];
                [resStr appendString:@"风向："];
                [resStr appendString:[dateDic objectForKey:@"fengxiang"]];
                [resStr appendString:@"\n"];
                [resStr appendString:@"最高气温："];
                [resStr appendString:[dateDic objectForKey:@"high"]];
                [resStr appendString:@"\n"];
                [resStr appendString:@"最低气温："];
                [resStr appendString:[dateDic objectForKey:@"low"]];
                [resStr appendString:@"\n"];
                [resStr appendString:@"天气状况："];
                [resStr appendString:[dateDic objectForKey:@"type"]];
                [resStr appendString:@"\n"];
                [resStr appendString:@"\n"];
                [resStr appendString:@"\n"];
            }
            [resStr dataUsingEncoding:NSUTF8StringEncoding];
            [resStr appendString:notice];
            NSLog(@"%@", resStr);
            self->_detialText.text = resStr;
        }
        else{
            self->_detialText.text = @" 城市信息有误//未查询到天气状况！！";
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败----%@", error);
        //可以再次添加后续操作
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //NSLog(@"%@&&&&&&&&&&&&&&&&&", _cityDetailStr); //这里获取不到
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"bg4.jpeg"];
    [self.view addSubview:imageView];
    CGRect screen = [[UIScreen mainScreen]bounds];
    
    //button
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(0, 80, screen.size.width, 50)];
    [self.button setTitle:@"点击查看城市介绍" forState:UIControlStateNormal];
    //self.button.backgroundColor = [UIColor colorWithRed:51/255.0 green:161/255.0 blue:201/255.0 alpha:0];
    self.button.backgroundColor = [UIColor clearColor];
    [self.button addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];//注意，这个view不是我们自己建的TestView中的view，而是testviewcontroller自带的view

    //text
    _detialText = [[UITextView alloc]initWithFrame:CGRectMake(0, 160, screen.size.width, screen.size.height - 160)];
    [self weatherRequestTask];
    //202,235,216
    _detialText.textColor = [UIColor colorWithRed: 224 / 255.0 green: 209 / 255.0 blue: 229 / 255.0 alpha:1.0];
    _detialText.font = [UIFont fontWithName:@"Courier-Bold" size:20];
    _detialText.editable = NO;
    _detialText.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_detialText];

}

- (void)jump:(id)sender{
    //跳转：展示城市详细列表
    _cinfoView = [[CityInfoView alloc]initWithName:self.cityName andDetail: self.detialText.text];
    [self.cinfoView show];
}

@end
