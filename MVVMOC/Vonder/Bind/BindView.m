//
//  BindView.m
//  mvvm
//
//  Created by 王亚军 on 14-8-16.
//  Copyright (c) 2014年 qing.ruijie. All rights reserved.
//

#import "BindView.h"
#import "FBKVOController.h"
@interface BindView()
{
    NSMutableDictionary *BindObjectDic;
    NSMutableDictionary *bindUnitDic;
    NSMutableDictionary *BindViewDic;
    FBKVOController     *fb;
    dispatch_queue_t    Bindqueue;
}
@end

@implementation BindView

+(instancetype)shareBindWith:(id)obver
{
    return [[[BindView class] alloc] initobj:obver];
}
-(instancetype)initobj:(id)obj
{
    fb = [[FBKVOController alloc] initWithObserver:obj];
    bindUnitDic = [NSMutableDictionary dictionary];
    BindViewDic = [NSMutableDictionary dictionary];
    BindObjectDic = [NSMutableDictionary dictionary];
    Bindqueue =  dispatch_queue_create([@"BindSetUnitQueue" UTF8String], DISPATCH_QUEUE_CONCURRENT);
    return [self init];
}

-(void)bind:(id)object keyPath:(NSString *)keyPath to:(NSString *)tag block:(bindBlock)block
{
    dispatch_barrier_async(Bindqueue, ^{
        [self bind:object property:keyPath to:tag block:block];
    });
}

-(void)bind:(id)object property:(NSString *)property to:(NSString *)tag block:(bindBlock)block
{
    // 1.判断对象是否还有property属性
    // 2.判断对象的这个属性是否曾经被绑定过
    if (!object || !property || !tag ) {
        return ;
    }
    if (block) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block([object valueForKey:property]);
        });
    }
    NSString *str = [NSString stringWithFormat:@"%p--%@",object,property];
    NSNumber *number = [BindObjectDic objectForKey:str];
    BOOL bindb = YES;
    if (!number) {
        [BindObjectDic setObject:@1 forKey:str];
        bindb = NO;
    }
    if (bindb) {
        [self bindYes:object property:property to:tag  block:block];
    }else
    {
        [self bindNo:object property:property to:tag block:block];
    }
}
-(void)bindYes:(id)object property:(NSString *)property to:(NSString *)tag  block:(bindBlock)block
{
    NSString *str = [NSString stringWithFormat:@"%p--%@",object,property];
    NSMutableDictionary *unitDic = [bindUnitDic objectForKey:str];
    if (!unitDic) {
        unitDic = [NSMutableDictionary dictionary];
        [bindUnitDic setObject:unitDic forKey:str];
    }
    bindUnit *unit = [unitDic objectForKey:tag];
    if (unit) {
        unit.block = block;
        return;
    }
    unit = [[bindUnit alloc] init];
    unit.tag = tag;
    unit.block = block;
    [unitDic setObject:unit forKey:tag];
}
-(void)bindNo:(id)object property:(NSString *)property to:(NSString *)tag  block:(bindBlock)block
{
    [self bindYes:object property:property to:tag block:block];
    __weak   typeof(self) welf = self;
    [fb observe:object keyPath:property options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        [welf sendchang:object property:property new:change[@"new"]];
    }];
}
-(void)sendchang:(id)object property:(NSString *)property new:(NSString *)new
{
    dispatch_async(Bindqueue, ^{
        NSString *str = [NSString stringWithFormat:@"%p--%@",object,property];
//        NSLog(@"%@",str);
        NSMutableDictionary *unitDic = [[bindUnitDic objectForKey:str] copy];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [unitDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                bindUnit *unit = obj;
                if (unit.block) {
                    unit.block(new);
                }
            }];
        }];
    });
    
}

-(void)bindMeb:(id)object property:(NSString *)property to:(NSString *)tag view:(NSString *)viewtag block:(bindBlock)block
{
    if (!object || !property || !tag || !viewtag ) {
        return ;
    }
    bind12 *b12 = [BindViewDic objectForKey:viewtag];
    if (b12) {
        
        [self bind:b12.object property:b12.property to:b12.bid block:nil];
    }else
    {
        b12 = [[bind12 alloc] init];
        b12.object = object;
        b12.property = property;
        b12.bid = tag;
        [BindViewDic setObject:b12 forKey:viewtag];
    }
    [self bind:object property:property to:tag block:block];
}

- (void)bindGroup:(NSString *)groupId block:(bind12Block)block
{
    NSString *gid = [groupId copy];
    bind12Block b12b = [block copy];
    dispatch_barrier_async(Bindqueue, ^{
        if (!gid || !b12b ) {
            return ;
        }
         NSArray *unitArr = b12b();
        NSArray *arr = [BindViewDic objectForKey:gid];
        if (arr) {
            for (bind12 *b12 in arr) {
                [self bind:b12.object property:b12.property to:b12.bid block:nil];
            }
        }
        [BindViewDic setObject:unitArr forKey:gid];
        for (bind12 *b12 in unitArr) {
            [self bind:b12.object property:b12.property to:b12.bid block:b12.block];
        }

    });
}

- (void)addBindGroup:(NSString *)groupId block:(bind12Block)block
{
    NSString *gid = [groupId copy];
    bind12Block b12b = [block copy];
    dispatch_barrier_async(Bindqueue, ^{
        if (!gid || !b12b ) {
            return ;
        }
        NSArray *unitArr = b12b();
        NSArray *arr = [BindViewDic objectForKey:gid];
        [BindViewDic setObject:[unitArr arrayByAddingObjectsFromArray:arr] forKey:gid];
        for (bind12 *b12 in unitArr) {
            [self bind:b12.object property:b12.property to:b12.bid block:b12.block];
        }
    });
}

+(bind12 *)bindUnit:(id)object property:(NSString *)property to:(NSString *)tag block:(bindBlock)block
{
    bind12 *b12 = [[bind12 alloc] init];
    b12.object = object;
    b12.property = property;
    b12.bid = tag;
    b12.block = block;
    return b12;
    
}
-(void)dealloc
{
    NSLog(@"dealloc----%@",NSStringFromClass([self class]));
}
@end

@implementation bind12



@end

@implementation bindUnit

@end
