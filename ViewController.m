//
//  ViewController.m
//  16_08_22_Tom猫复习
//
//  Created by 姚懿恒 on 16/8/22.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{

    NSDictionary *_dict;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
}



#pragma mark 传入动画的名称以及图片数
-(void)animationWithFuncName:(NSString *)name picNo:(int)num{


    if (_tom.isAnimating) {
        return;
    }

    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < num; i++) {

        NSString *imgName = [NSString stringWithFormat:@"%@_%02d.jpg", name, i];


        NSString *path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];

        UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];

        [images addObject:img];
    }

    self.tom.animationImages = images;

    self.tom.animationDuration = 0.1 * num;

    self.tom.animationRepeatCount = 1;
    [self.tom startAnimating];


}

#pragma mark 通过UIButton获取用户点击的按钮, 并通过字典输出相应的动作名称与所对应的值
- (IBAction)function:(UIButton *)sender {




    NSString *functionName = [sender titleForState:UIControlStateNormal];
    int picNo = [_dict[functionName] intValue];

    [self animationWithFuncName:functionName picNo:picNo];


}
@end
