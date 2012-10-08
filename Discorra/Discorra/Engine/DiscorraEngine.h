//
//  DiscorraEngine.h
//  Discorra
//
//  Created by Arnaud Barisain Monrose on 08/10/12.
//  Copyright (c) 2012 Arnaud Barisain Monrose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscorraEngine : NSObject {
    NSString *targetPath;
}

-(id) initWithPath:(NSString*)path;

@end
