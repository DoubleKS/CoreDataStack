//
//  DKCoreDataManager.h
//  CoreDataStack
//
//  Created by doublek on 2017/5/22.
//  Copyright © 2017年 doublek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define kDKCoreDataManager [DKCoreDataManager shareInstane]
#define kFileName @"DK"

@interface DKCoreDataManager : NSObject

+(DKCoreDataManager *)shareInstane;

//管理上下文
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;

//对象模型
@property(nonatomic,strong)NSManagedObjectModel *managedObjectModel;

//存储调度器
@property(nonatomic,strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;

//保存到数据库
-(void)save;

//清空数据库
-(void)deletAllEnties;




@end
