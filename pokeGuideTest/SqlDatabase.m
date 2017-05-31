//
//  SqlDatabase.m
//  pokeGuideTest
//
//  Created by LAI KIN WA on 31/5/2017.
//  Copyright © 2017年 LAI KIN WA. All rights reserved.
//

#import "SqlDatabase.h"
#import <sqlite3.h>

@implementation SqlDatabase

+(NSString *) getDatabasePath:(NSString *) databaseName
{
    NSString *docsDir;
    NSArray *dirPath;
    // Get the documents directory
    dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPath objectAtIndex:0];
    
    // Build the path to the database file
    NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: databaseName]];
    return databasePath;
}

-(BOOL) createDatabase:(NSString *)databaseName{
    sqlite3 *db;
    
    NSString *databasePath=[SqlDatabase getDatabasePath:databaseName];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO) {
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &db) == SQLITE_OK) {
            char *errMsg;
            // create SQL statements
            const char *sql = "CREATE TABLE IF NOT EXISTS pokeGuide (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, gender TEXT)";
            
            if (sqlite3_exec(db, sql, NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog( @"Failed to create table");
                return NO;
            }
            sqlite3_close(db);
            NSLog(@"Database created.");
            return YES;
        }
        else {
            NSLog( @"Failed to open/create database");
            return NO;
        }
    }else{
        NSLog(@"Database already created.");
        return YES;
    }
}

-(BOOL) copyDatabase:(NSString *)databaseName{
    NSString *databasePath=[SqlDatabase getDatabasePath:databaseName];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO) {
        NSError *error;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:databaseName ofType:NULL];
        [fileManager copyItemAtPath:bundlePath toPath:databasePath error:&error];
        if(error){
            NSLog(@"Error: %@)" , [error localizedDescription]);
            return NO;
        }else{
            NSLog(@"Database copied from NSBundle to Document directory.");
            return YES;
        }
    }else{
        NSLog(@"Database already copied.");
        return YES;
    }
}

@end
