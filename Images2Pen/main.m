#define version 1

#import <Foundation/Foundation.h>
#import "PenMaker.h"

int main(int argc, const char * argv[])
{
    puts("Images2Pen: make a pen (Penultimate) document with a bunch of images.");
    puts("");
    puts("  Copyright (C) 2012 Dongsung \"Don\" Kim");
    puts("");
    puts("  This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.");
    puts("");
    puts("  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.");
    puts("");
    puts("  You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.");
    puts("");
    
    if (argc > 3 || argc < 2) {
        printf("%s: \"[imagesFolder]\" \"[title]\"\n", argv[0]);
        return 1;
    }    
    
    // Getting imagesFolder argument.
    NSString *imagesFolder = [[NSString alloc] initWithCString:argv[1] encoding:NSUTF8StringEncoding];
    NSURL *imagesFolderURL = [[NSURL alloc] initWithString:imagesFolder];
    if(!imagesFolderURL) {
        NSLog(@"Couldn't locate imagesFolder.");
        return 1;
    }
    
    // Getting file list in imagesFolder.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *err = nil;
    NSArray *fileList = [fileManager contentsOfDirectoryAtURL:imagesFolderURL 
                                   includingPropertiesForKeys:[NSArray arrayWithObject:NSURLIsRegularFileKey] 
                                                      options:NSDirectoryEnumerationSkipsHiddenFiles 
                                                        error:&err];
    if(err) {
        NSLog(@"Couldn't get file list of imagesFolder: %@", [err domain]);
        return 1;
    }
    
    // Making NSData array from images.
    char png[12];
    *((int *)png) = 0x474E5089;
    *(((int *)png + 1)) = 0x0A1A0A0D;
    *(((int *)png + 2)) = 0x0D000000;
    char jpg[12];
    *((int *)jpg) = 0xE0FFD8FF;
    *(((int *)jpg + 1)) = 0x464A1000;
    *(((int *)jpg + 2)) = 0x01004649;
    
    NSMutableArray *imagesDataArray = [[NSMutableArray alloc] init];
    for(NSURL *file in fileList) {
        // Analyze the file if it is JPG or PNG.
        NSData *data = [NSData dataWithContentsOfURL:file];
        if (!data || ([data length] < 12)) {
            printf("%s is not JPG nor PNG. Skipping...\n", [[file lastPathComponent] cStringUsingEncoding:NSUTF8StringEncoding]);
            continue;
        }

        void *p = (void *)[data bytes];
        
        if(!memcmp(p, png, 12))
            printf("Fetching %s (PNG)...\n", [[file lastPathComponent] cStringUsingEncoding:NSUTF8StringEncoding]);
        else if(!memcmp(p, jpg, 12))
            printf("Fetching %s (JPG)...\n", [[file lastPathComponent] cStringUsingEncoding:NSUTF8StringEncoding]);
        else {
            printf("%s is not JPG nor PNG. Skipping...\n", [[file lastPathComponent] cStringUsingEncoding:NSUTF8StringEncoding]);
            continue;
        }
        
        [imagesDataArray addObject:data];
    }
    
    // Getting title argument.
    NSString *title = nil;
    if (argc == 3)
        title = [[NSString alloc] initWithCString:argv[2] encoding:NSUTF8StringEncoding];
    else
        title = [[NSString alloc] initWithFormat:@"Untitled_%d", time(NULL)];
    
    // Making a pen file.
    NSData *pen = [PenMaker makePenWithTitle:title
                                   resources:imagesDataArray];
    if(!pen) {
        NSLog(@"Couldn't make pen data.");
        return 1;
    }
        
    NSString *penOutput = [[NSString alloc] initWithFormat:@"%@/%@.pen", imagesFolder, title];
    
    printf("Writing to %s (%.1f MB)...\n", [penOutput cStringUsingEncoding:NSUTF8StringEncoding], (float)[pen length]/1000000.0f);
    if(![pen writeToFile:penOutput atomically:YES]) {
        NSLog(@"Couldn't write to %@.", penOutput);
        return 1;
    }
    
    printf("Done.\n");
    
    return 0;
}