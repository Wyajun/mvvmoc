//
//  NSString+Path.m
//  nsstring+strogy
//
//  Created by 王亚军 on 14-4-11.
//  Copyright (c) 2014年 王亚军. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)
+(NSString *)getDocumentPath
{
    static NSString *documentsDirectory = nil;
    static dispatch_once_t oncePredicate = 0;
    dispatch_once(&oncePredicate, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDirectory = [paths objectAtIndex:0];
    });
    return documentsDirectory;
}
-(NSString *)getDirectoryForDocuments
{
  
    NSString* path = [[NSString getDocumentPath] stringByAppendingPathComponent:self];
    return path;
}
-(NSString *)getPathForDocuments
{
    return [[NSString getDocumentPath] stringByAppendingPathComponent:self];
}
-(NSString *)getPathForDocumentsinDir:(NSString *)dir
{
    return [[dir getDirectoryForDocuments]stringByAppendingPathComponent:self];
}
-(BOOL)isFileExists
{
    return [[NSFileManager defaultManager] fileExistsAtPath:self];
}
-(BOOL)deleteWithFilepath
{
    return [[NSFileManager defaultManager] removeItemAtPath:self error:nil];
}
-(NSArray*)getFilenamesWithDir
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:self error:nil];
    return fileList;
}
@end
