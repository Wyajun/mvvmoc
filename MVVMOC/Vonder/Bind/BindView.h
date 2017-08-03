//
//  BindView.h
//  mvvm
//
//  Created by 王亚军 on 14-8-16.
//  Copyright (c) 2014年 qing.ruijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#define BindGroupID(view) [NSString stringWithFormat:@"%p",view]
typedef void (^bindBlock) (id );
typedef NSArray * (^bind12Block) ();
@interface bindUnit : NSObject
@property(nonatomic,copy)NSString *tag;
@property(nonatomic,copy) bindBlock block;
@end

@interface bind12 : NSObject
@property(nonatomic,weak)id object;
@property(nonatomic,copy)NSString *property;
@property(nonatomic,copy)NSString *bid;
@property(nonatomic,copy)bindBlock block;
@end

@interface BindView : NSObject
+(instancetype)shareBindWith:(id)obver;

/*
 * 绑定模型对象的属性于想要执行的代码块
 * 这种绑定用于view对model的唯一 确定 和不变。
 * 这种绑定view和model一旦绑定，则view就不会在和同类的其他model发生绑定关系
 * @param object 模型对象
 * @param name   对象的属性name
 * @param tag    对应绑定关系的唯一标示符
 * @param block  当name属性发生变话的时候，所执行的行为
 */
-(void)bind:(id)object keyPath:(NSString *)keyPath to:(NSString *)tag  block:(bindBlock)block;

/*
 * 绑定模型对象的属性于想要执行的代码块
 * 这种绑定用于view对model的唯一 确定 和可以改变。
 * 这种绑定view和model一旦绑定，view还可以和同类的其他model发生
 * 绑定关系，即改变现有的绑定
 * @param object 模型对象
 * @param name   对象的属性name
 * @param tag    对应绑定关系的唯一标示符
 * @param viewtag 对于此绑定来说唯一对应的标识符 
 * 这个viewTag的要求是比较高的，对于同一view的不同绑定都需要不同的viewTag
 * @param block  当name属性发生变话的时候，所执行的行为
 * 由于其他原因，此方法被丢弃  改为一下三个方法
  -(void)bindMeb:(id)object property:(NSString *)property to:(NSString *)tag view:(NSString *)viewtag block:(bindBlock)block;
 */
// 此方法会生成一个特定的绑定对象镜像
+(bind12 *)bindUnit:(id)object property:(NSString *)property to:(NSString *)tag block:(bindBlock)block;
// 这个方法是初始化方法，所有相同的groupId将会被自动取消上次的绑定关系
- (void)bindGroup:(NSString *)groupId block:(bind12Block)block;
// 添加同组的绑定关系，这个方法只会添加绑定。
- (void)addBindGroup:(NSString *)groupId block:(bind12Block)block;
/*
 * 说明：关于tag和groupId的几点说明
 * * 对象、属性加tag三者合起来才能唯一标识出一个要执行的block
 * 1.tag
 * * tag 为对象和属性 对 执行block 的对应关系的唯一映射标识
 * * 因此对tag取值的限制相对没有多少限制。
 * * 只要保证在此对象下，对应的某属性时 tag 唯一就行。
 * 2.groupId
 * * groupId 是对tag的一种补充。主要用于绑定关系不牢靠的情况
 * * 常见的现象就是tableCell的重用上，当这种绑定关系不牢靠，需要解绑时，
 * * 需要groupId来标识view的唯一性。
 * * 一般建议使用view的地址作为groupId。
 */
@end

