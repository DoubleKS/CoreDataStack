//
//  ViewController.m
//  CoreDataStack
//
//  Created by doublek on 2017/5/22.
//  Copyright © 2017年 doublek. All rights reserved.
//

#import "ViewController.h"
#import "DKCoreDataManager.h"
#import "Person+CoreDataClass.h"
#import "Student+CoreDataClass.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSLog(@"%@",NSHomeDirectory());
}


#pragma mark - 增加
- (IBAction)insertButtonClick:(UIButton *)sender {
    
    //创建对象
    Person *per = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:kDKCoreDataManager.managedObjectContext];
    
    //赋值
    per.name = @"道格森二世";
    per.age = 22;
    
    //创建对象
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:kDKCoreDataManager.managedObjectContext] ;
    student.name = @"犬次郎";
    
    [kDKCoreDataManager save];
}

#pragma mark - 删除
- (IBAction)deletBuutonClick:(UIButton *)sender {
    
    [kDKCoreDataManager deletAllEnties];
    
    return;
    //删除数据的逻辑就是
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Person"];
    
    //设置查询请求的谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.name CONTAINS %@",@"犬次郎"];
    
    request.predicate = predicate;
    
    NSArray<Person *>*requestArr = [kDKCoreDataManager.managedObjectContext executeFetchRequest:request error:nil];
    
    [kDKCoreDataManager.managedObjectContext deleteObject:requestArr.firstObject];
}

#pragma mark - 修改
- (IBAction)updateButtonClick:(UIButton *)sender {
    
    //修改数据的逻辑就是先将想要的数据查询出来,然后再修改即可
    //创建查询请求 参数是要查询的实体
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Person"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.name CONTAINS %@",@"犬次郎"];
    
    request.predicate = predicate;
    
    NSArray<Person *>*requstArr = [kDKCoreDataManager.managedObjectContext executeFetchRequest:request error:nil];
    
    requstArr.firstObject.age = 30;
    
    //保存到数据库
    [kDKCoreDataManager save];
    
}
#pragma mark - 查询
- (IBAction)fetchButtonClick:(UIButton *)sender {
    
    //创建查询请求 参数是要查询的实体
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Student"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.name CONTAINS %@",@"犬次郎"];
    
    request.predicate = predicate;
    
    NSArray *requestArr = [kDKCoreDataManager.managedObjectContext executeFetchRequest:request error:nil];
    
    for (Student *stu in requestArr) {
        
        NSLog(@"%@",stu.name);
    }
}



@end
