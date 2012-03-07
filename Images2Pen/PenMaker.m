#import <AppKit/AppKit.h>
#import "PenMaker.h"
#import "Notebook.h"
#import "Page.h"

@implementation PenMaker

+ (NSData *) makePenWithTitle: (NSString *) title
                    resources: (NSArray *) resources
{
    if(!(title && resources))
        return nil;
    
    // metadata - 1
    NSDictionary *metadata = [[NSDictionary alloc] initWithObjectsAndKeys:@"Penultimate Notebook", @"kind", [NSNumber numberWithInt:2], @"version", nil];
    
    // notebook - 2
    Notebook *notebook = [[Notebook alloc] init];
    [notebook.title setString:title ? title : @"Untitled"];
    NSMutableArray *pageNames = notebook.pageNames;
    
    NSMutableArray *pages = [[NSMutableArray alloc] init];
    NSMutableArray *resourceIds = [[NSMutableArray alloc] init];
    for(NSData *resource in resources) {
        // page - 3
        Page *page = [[Page alloc] init];
        [pages addObject:page];
        [pageNames addObject:page.name];
        NSMutableArray *pageLayers = page.pageLayers;
        
        // NSImage
        NSImage *image = [[NSImage alloc] initWithData:resource];
        NSSize size = image.size;
        
        // imagePageLayer
        ImagePageLayer *imagePageLayer = [[ImagePageLayer alloc] initWithImageSize:size];
        [pageLayers addObject:imagePageLayer];
        NSMutableString *layerResourceId = imagePageLayer.resourceId;
        
        // resource - 4
        NSString *resourceId = [[NSString alloc] initWithFormat:@"%d-%d-%d", (unsigned int)resource, (unsigned int)time(NULL), (unsigned int)resource];
        [resourceIds addObject:resourceId];
        [layerResourceId appendString:resourceId];
    }
    
    // archive & penContents
    NSMutableData *penContents = [[NSMutableData alloc] init];
    
    NSData *archivedMetadata = [NSKeyedArchiver archivedDataWithRootObject:metadata]; 
    [penContents appendData:archivedMetadata];
    
    NSData *archivedNotebook = [NSKeyedArchiver archivedDataWithRootObject:notebook]; 
    [penContents appendData:archivedNotebook];
    
    NSMutableArray *archivedPages = [[NSMutableArray alloc] init];
    for(Page *page in pages) {
        NSData *archivedPage = [NSKeyedArchiver archivedDataWithRootObject:page];
        [archivedPages addObject:archivedPage];
        [penContents appendData:archivedPage];
    }
    
    for(NSData *resource in resources)
        [penContents appendData:resource];
    
    // penFooter - 5
    NSMutableArray *penFooters = [[NSMutableArray alloc] init];
    long int startOffset = 20;
    
    NSMutableDictionary *footerMetadata = [[NSMutableDictionary alloc] init];
    [footerMetadata setObject:@"metadata" forKey:@"name"];
    [footerMetadata setObject:[NSNumber numberWithInt:[archivedMetadata length]] forKey:@"size"];
    [footerMetadata setObject:[NSNumber numberWithLong:startOffset] forKey:@"startOffset"];
    startOffset += [archivedMetadata length];
    [penFooters addObject:footerMetadata];
    
    NSMutableDictionary *footerNotebook = [[NSMutableDictionary alloc] init];
    [footerNotebook setObject:@"notebook" forKey:@"name"];
    [footerNotebook setObject:[NSNumber numberWithInt:[archivedNotebook length]] forKey:@"size"];
    [footerNotebook setObject:[NSNumber numberWithLong:startOffset] forKey:@"startOffset"];
    startOffset += [archivedNotebook length];
    [penFooters addObject:footerNotebook];
    
    for(int i=0; i<[archivedPages count]; i++) {
        NSData *archivedPage = [archivedPages objectAtIndex:i];
        NSMutableDictionary *footerPage = [[NSMutableDictionary alloc] init];
        [footerPage setObject:[NSString stringWithFormat:@"page_%@", [pageNames objectAtIndex:i]] forKey:@"name"];
        [footerPage setObject:[NSNumber numberWithInt:[archivedPage length]] forKey:@"size"];
        [footerPage setObject:[NSNumber numberWithLong:startOffset] forKey:@"startOffset"];
        startOffset += [archivedPage length];
        [penFooters addObject:footerPage];
    }
    
    for(int i=0; i<[resources count]; i++) {
        NSData *resource = [resources objectAtIndex:i];
        NSMutableDictionary *footerResource = [[NSMutableDictionary alloc] init];
        [footerResource setObject:[NSString stringWithFormat:@"resource_%@_%@", [pageNames objectAtIndex:i], [resourceIds objectAtIndex:i]] forKey:@"name"];
        [footerResource setObject:[NSNumber numberWithInt:[resource length]] forKey:@"size"];
        [footerResource setObject:[NSNumber numberWithLong:startOffset] forKey:@"startOffset"];
        startOffset += [resource length];
        [penFooters addObject:footerResource];
    }
    
    NSData *penFooter = [NSKeyedArchiver archivedDataWithRootObject:penFooters];
    
    // penHeader - 0
    char header[20];
    header[0] = 0x42;
    header[1] = 0x5A;
    header[2] = 0x01;
    header[3] = 0x00;
    
    long int value1 = 20 + [penContents length] + [penFooter length]; 
    long int value2 = value1 - [penFooter length];
    
    char *source = (char *)&value1;
    char *destination = &header[4];
    for(int i=0; i<8; i++)
        *(destination+i) = *(source+(7-i));
    
    source = (char *)&value2;
    destination = &header[12];
    for(int i=0; i<8; i++)
        *(destination+i) = *(source+(7-i));
    
    NSMutableData *penHeader = [[NSMutableData alloc] initWithBytes:header length:20];
    
    
    // 전체
    NSMutableData *pen = [[NSMutableData alloc] init];
    [pen appendData:penHeader];
    [pen appendData:penContents];
    [pen appendData:penFooter];   
    
    return pen;
}

@end
