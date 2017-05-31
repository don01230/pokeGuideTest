//
//  SqlDatabase.h
//  pokeGuideTest
//
//  Created by LAI KIN WA on 31/5/2017.
//  Copyright © 2017年 LAI KIN WA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SqlDatabase : NSObject

-(BOOL) createDatabase:(NSString *)databaseName;
-(BOOL) copyDatabase:(NSString *)databaseName;
+(NSString *) getDatabasePath:(NSString *) databaseName;

@end
