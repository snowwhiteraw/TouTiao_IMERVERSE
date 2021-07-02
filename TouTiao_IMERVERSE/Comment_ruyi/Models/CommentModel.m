//
//  CommentModel.m
//  toutiao_Comment
//
//  Created by Admin on 2021/6/28.
//

#import "CommentModel.h"

@implementation CommentModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)commentModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
