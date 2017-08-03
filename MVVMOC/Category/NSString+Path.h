//
//  NSString+Path.h
//  nsstring+strogy
//
//  Created by 王亚军 on 14-4-11.
//  Copyright (c) 2014年 王亚军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)
+(NSString*) getDocumentPath;
//返回 "document/dir/" 文件夹路径
-(NSString*) getDirectoryForDocuments;
//返回 "document/filename" 路径
-(NSString*) getPathForDocuments;
//返回 "document/dir/filename" 路径
-(NSString*) getPathForDocumentsinDir:(NSString*)dir;
//文件是否存在
-(BOOL) isFileExists;
//删除文件
-(BOOL)deleteWithFilepath;
//返回该文件目录下 所有文件名
-(NSArray*)getFilenamesWithDir;
@end
