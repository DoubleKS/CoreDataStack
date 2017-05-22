//
//  DKCoreDataManager.m
//  CoreDataStack
//
//  Created by doublek on 2017/5/22.
//  Copyright © 2017年 doublek. All rights reserved.
//

#import "DKCoreDataManager.h"

@implementation DKCoreDataManager

//懒加载属性
+(DKCoreDataManager *)shareInstane{
    
    static DKCoreDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[DKCoreDataManager alloc]init];
    });
    
    return manager;
}


//重写get方法实现懒加载
-(NSManagedObjectContext *)managedObjectContext{
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    //创建管理对象上下文 参数是指定上下文的线程环境 建议使用NSMainQueueConcurrencyType (主线程操作,没有延误)
    //    NSPrivateQueueConcurrencyType(子线程操作有一定的延误)
    _managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    //设置存储调度器(存储数据时,对象上下文负责给存储调度器发送指令)
    [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];

    return _managedObjectContext;
}

-(NSManagedObjectModel *)managedObjectModel{
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    //使用合并的方式创建对象模型
    //参数是一个bundle路径的数组 如果设为nil 则会自动帮你寻找整个项目中的左右路径下的cx模型文件
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

-(NSURL *)getDocumentUrl{
    
    return [[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.managedObjectModel];
    
    NSURL *fileURL = [[self getDocumentUrl]URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",kFileName]];
    
    //2.给存储调度器添加存储器(存储调度器的作用是调度存储器)
    /**storeType
     NSSQLiteStoreType 数据库形式存储
     NSXMLStoreType XML形式存储
     NSBinaryStoreType 二进制存储
     NSInMemoryStoreType 内存形式存储
     */
    /**
     type:     
     configuration:配置 一般为nil，默认设置
     URL:数据库文件保存的路径
     options:参数信息  一般为nil,默认设置
     error：报错
     */
    [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:fileURL options:nil error:nil];
    //返回
    return _persistentStoreCoordinator;
}

-(void)save{
    
    NSError *errol = nil;
    
    [self.managedObjectContext save:&errol];
    
    if (errol == nil) {
        NSLog(@"保存数据库成功");
    }else{
        NSLog(@"%@",errol.description);
    }
    
}

-(void)deletAllEnties{
    
    //清空数据库快捷方式可以直接删除数据库文件
    NSString *filePath1 = [NSString stringWithFormat:@"%@/Documents/%@.db",NSHomeDirectory(),kFileName];
    NSString *filePath2 = [NSString stringWithFormat:@"%@/Documents/%@.db-shm",NSHomeDirectory(),kFileName];
    NSString *filePath3 = [NSString stringWithFormat:@"%@/Documents/%@.db-wal",NSHomeDirectory(),kFileName];
    
    NSError *error;
    
    [[NSFileManager defaultManager] removeItemAtPath:filePath1 error:&error];
    
    [[NSFileManager defaultManager] removeItemAtPath:filePath2 error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:filePath3 error:&error];
    
    if (error == nil) {
        NSLog(@"清除数据库成功");
    }else{
        NSLog(@"%@",error.description);
    }
    
}







@end
