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
    //保存图片的个数
    NSDictionary *_dict;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    //通过NSBundle下的路径创建字典
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 传入动画的名称以及图片数
-(void)animationWithFuncName:(NSString *)name picNo:(int)num{

    //如果动画正在播放则返回, 执行效果为, 在没有结束上一个动画前, 新动画不执行
    if (_tom.isAnimating) {
        return;
    }
    //创建一个可变数组用来添加UIImage对象
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < num; i++) {
        //图片名
        NSString *imgName = [NSString stringWithFormat:@"%@_%02d.jpg", name, i];
        //加载图片(根据文件名加载, 会有缓存)
        //使用于图片经常使用, 图片加载一次后就进入缓存
        //如果做程序, 使用了大量的图片, 谨慎使用imageNamed:@""该方法
        //有缓存, 无法释放(参数传的是文件名).
        UIImage *img = [UIImage imageNamed:imgName];

        //使用该方法无缓存(用完就释放,传的是全路径)
        //UIImage *img = [UIImage alloc] initWithContentsOfFile:<#(nonnull NSString *)#>
        [images addObject:img];
    }
    //设置动画的图片
    self.tom.animationImages = images;

    //设置动画的持续时间
    self.tom.animationDuration = 0.1 * num;

    //设置动画的重复次数
    self.tom.animationRepeatCount = 1;
    //设置动画开始
    [self.tom startAnimating];
    //以下写法会报错
    //Property access result unused - getters should not be used for side effects
    //_tom.startAnimating;

}

/*每次点击该方法都需要进入NSBundle中进行读写字典的操作,
 但其实只可以做一次操作, 既然只需要做一次,
 就可以将其设置为成员变量, 并在viewDidLoad方法中加载.
 */
#pragma mark 通过UIButton获取用户点击的按钮, 并通过字典输出相应的动作名称与所对应的值
- (IBAction)function:(UIButton *)sender {



    //通过该方法访问按钮UIControlStateNormal状态下的文字
    NSString *functionName = [sender titleForState:UIControlStateNormal];
    int picNo = [_dict[functionName] intValue];
    //调用方法, 传入动画名与图片张数.
    [self animationWithFuncName:functionName picNo:picNo];


}
@end
