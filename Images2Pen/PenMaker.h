#import <Foundation/Foundation.h>

@interface PenMaker : NSObject

+ (NSData *) makePenWithTitle: (NSString *) title
                    resources: (NSArray *) resources;

@end
