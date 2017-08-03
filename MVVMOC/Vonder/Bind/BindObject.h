//
//  BindObject.h
//  mvvm
//
//  Created by 王亚军 on 14-8-23.
//  Copyright (c) 2014年 qing.ruijie. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface BindObjectUnit:NSObject
@property(nonatomic)int countTag;
@property(nonatomic,weak)id obj;
@end



@interface BindObject : NSObject
+(instancetype)shareBindObject;
-(instancetype)shareBindObject;
/*
 * 函数功能：用字典dic里面的key-value更新 oid标识的对象。
 * @param: oid 某类对象的唯一标识符 
 * @param：dic key 为对象的属性名称 value 为对应属性的值
 */
-(void)updataObjectOid:(NSString *)oid withDic:(NSDictionary *)dic;

/*
 * 函数功能：注册对象 为了能更新对象，需要提供注册
 * @param: oid 所有同类对象所共有的唯一标示符
 * @param: obj 要注册的对象
 */
-(void)registerObject:(NSString *)oid Object:(id)obj;
/*
 * 带小分组的注册，主要用于ViewController可以将同意vc所拥有的对象一次注册
 * 这样便于正对vc进行对象生命周期的管理
 * @param: oid 所有同类对象所共有的唯一标示符
 * @param: gid 要注册的对象的分组
 * @param: objs 要注册的对象的数据集合
 */
-(void)registerObject:(NSString *)oid groupid:(NSString *)gid Objects:(NSArray *)objs;
/*
 * 删除对象注册
 * @param: oid 所有同类对象所共有的唯一标示符
 * @param: obj 要删除注册的对象
 */

-(void)delRegisterObject:(NSString *)oid Obj:(id)obj;

/*
 * 删除某类对象的所有注册 一般不建议使用
 * @param: oid 所有同类对象所共有的唯一标示符
 */

-(void)delRegisterOid:(NSString *)oid;
/*
 * 删除带小分组的注册，主要用于ViewController消亡时取消依赖于它的注册
 * 这样便于正对vc进行对象生命周期的管理
 * @param: oid 所有同类对象所共有的唯一标示符
 * @param: gid 要注册的对象的分组
 */
-(void)delRegisterObject:(NSString *)oid groupid:(NSString *)gid;
@end
