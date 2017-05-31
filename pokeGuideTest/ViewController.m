//
//  ViewController.m
//  pokeGuideTest
//
//  Created by LAI KIN WA on 31/5/2017.
//  Copyright © 2017年 LAI KIN WA. All rights reserved.
//

#import "ViewController.h"
#import "SqlDatabase.h"
#define DB_NAME @"pokeGuide.db"
@interface ViewController () <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *nameArray;
    NSMutableArray *genderArray;
}

@end

NSInteger rowNum;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initDatabase];
    [_maleButton addTarget:self action:@selector(maleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_femaleButton addTarget:self action:@selector(femaleButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)maleButtonClick{
    sqlite3 *db;
    NSString *databasePath=[SqlDatabase getDatabasePath:DB_NAME];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &db) != SQLITE_OK)
    {
        NSLog(@"[ERROR] Database open failed.");
        return;
    }
    
    nameArray=[[NSMutableArray alloc] init];
    genderArray=[[NSMutableArray alloc] init];
    const char *sql = "select * from pokeGuide where gender = 'Male'";
    sqlite3_stmt *statement =nil;
    int index=0;
    if (sqlite3_prepare_v2(db, sql, -1, &statement, NULL) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            [nameArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)]];
            [genderArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)]];
            
            NSLog(@"Record: %@ , %@", [nameArray objectAtIndex:index], [genderArray objectAtIndex:index]);
            index++;
        }
        
        sqlite3_finalize(statement);
    }
    [_tableView reloadData];
}

-(void)femaleButtonClick{
    sqlite3 *db;
    NSString *databasePath=[SqlDatabase getDatabasePath:DB_NAME];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &db) != SQLITE_OK)
    {
        NSLog(@"[ERROR] Database open failed.");
        return;
    }
    
    nameArray=[[NSMutableArray alloc] init];
    genderArray=[[NSMutableArray alloc] init];
    const char *sql = "select * from pokeGuide where gender = 'Female'";
    sqlite3_stmt *statement =nil;
    int index=0;
    if (sqlite3_prepare_v2(db, sql, -1, &statement, NULL) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            [nameArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)]];
            [genderArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)]];
            
            NSLog(@"Record: %@ , %@", [nameArray objectAtIndex:index], [genderArray objectAtIndex:index]);
            index++;
        }
        
        sqlite3_finalize(statement);
    }
    [_tableView reloadData];
}

- (void)initDatabase{
    SqlDatabase *sqlDb=  [[SqlDatabase alloc]init];
    
    if([sqlDb createDatabase:DB_NAME]==NO){
        NSLog(@"Database create failed.");
    }
    
    sqlite3 *db;
    NSString *databasePath=[SqlDatabase getDatabasePath:DB_NAME];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &db) != SQLITE_OK)
    {
        NSLog(@"[ERROR] Database open failed.");
        return;
    }
    
    char *errorMsg;
    const char *sql = "DELETE FROM pokeGuide";
    
    if (sqlite3_exec(db, sql, NULL, NULL, &errorMsg)==SQLITE_OK) {
        NSLog(@"DELETE OK");
    }else{
        NSLog(@"DELETE error: %s",errorMsg);
    }
    
    const char *insertSql="insert into pokeGuide(name,gender) values('Mary','Female')";
    if (sqlite3_exec(db, insertSql, NULL, NULL, &errorMsg)==SQLITE_OK) {
        NSLog(@"INSERT OK");
    }else{
        NSLog(@"Insert error: %s",errorMsg);
    }
    
    insertSql="insert into pokeGuide(name,gender) values('John','Male')";
    if (sqlite3_exec(db, insertSql, NULL, NULL, &errorMsg)==SQLITE_OK) {
        NSLog(@"INSERT OK");
    }else{
        NSLog(@"Insert error: %s",errorMsg);
    }
    
    insertSql="insert into pokeGuide(name,gender) values('Tom','Male')";
    if (sqlite3_exec(db, insertSql, NULL, NULL, &errorMsg)==SQLITE_OK) {
        NSLog(@"INSERT OK");
    }else{
        NSLog(@"Insert error: %s",errorMsg);
    }
    
    insertSql="insert into pokeGuide(name,gender) values('Susan','Female')";
    if (sqlite3_exec(db, insertSql, NULL, NULL, &errorMsg)==SQLITE_OK) {
        NSLog(@"INSERT OK");
    }else{
        NSLog(@"Insert error: %s",errorMsg);
    }
    
    insertSql="insert into pokeGuide(name,gender) values('Kay','Female')";
    if (sqlite3_exec(db, insertSql, NULL, NULL, &errorMsg)==SQLITE_OK) {
        NSLog(@"INSERT OK");
    }else{
        NSLog(@"Insert error: %s",errorMsg);
    }
    
    nameArray=[[NSMutableArray alloc] init];
    genderArray=[[NSMutableArray alloc] init];
    sql = "select * from pokeGuide";
    sqlite3_stmt *statement =nil;
    int index=0;
    if (sqlite3_prepare_v2(db, sql, -1, &statement, NULL) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            [nameArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)]];
            [genderArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)]];
            
            NSLog(@"Record: %@ , %@", [nameArray objectAtIndex:index], [genderArray objectAtIndex:index]);
            index++;
        }
        
        sqlite3_finalize(statement);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    /*sqlite3 *db;
    NSString *databasePath=[SqlDatabase getDatabasePath:DB_NAME];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &db) != SQLITE_OK)
    {
        NSLog(@"[ERROR] Database open failed.");
        return 0;
    }
    
    NSLog(@"*** COUNT ***");
    const char *sql ="select count(*) from pokeGuide";
    sqlite3_stmt *statement=nil;
    if (sqlite3_prepare_v2(db, sql, -1, &statement, NULL) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            rowNum = sqlite3_column_int(statement, 0);

            NSLog(@"Record: %ld",(long)rowNum);
        }
        
        sqlite3_finalize(statement);
    }*/
    return [nameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UITextField *nameTextField=[[UITextField alloc] init];
    UITextField *genderTextField=[[UITextField alloc] init];
    
    [nameTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [genderTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    nameTextField.text=[nameArray objectAtIndex:indexPath.row];
    genderTextField.text=[genderArray objectAtIndex:indexPath.row];
    
    [cell addSubview:nameTextField];
    [cell addSubview:genderTextField];
    
    NSDictionary *views=NSDictionaryOfVariableBindings(nameTextField,genderTextField);
    
    NSArray *horizontalConstraints1 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[nameTextField]-0-[genderTextField]-0-|" options:0 metrics:nil views:views];
    [cell addConstraints:horizontalConstraints1];
    
    NSArray *equalWidthConstraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"[nameTextField(==genderTextField)]" options:0 metrics:nil views:views];
    [cell addConstraints:equalWidthConstraints1];
    
    NSArray *verticalConstraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[nameTextField]-5-|" options:0 metrics:nil views:views];
    NSArray *verticalConstraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[genderTextField]-5-|" options:0 metrics:nil views:views];
    
    [cell addConstraints:verticalConstraints1];
    [cell addConstraints:verticalConstraints2];

    nameTextField.adjustsFontSizeToFitWidth=YES;
    nameTextField.textColor=[UIColor blackColor];
    nameTextField.backgroundColor=[UIColor clearColor];
    
    genderTextField.adjustsFontSizeToFitWidth=YES;
    genderTextField.textColor=[UIColor blackColor];
    genderTextField.backgroundColor=[UIColor clearColor];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
