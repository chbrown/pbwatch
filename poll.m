#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>

#import <Foundation/Foundation.h>
// NSPasteboard documentation: http://bit.ly/J0NMn1
#import <AppKit/NSPasteboard.h>
#import "poll.h"
// #import <CoreLocation/CoreLocation.h>
// #import <ApplicationServices/ApplicationServices.h>

// Compile like:
// clang poll.m -o poll -Wall -framework Foundation -framework AppKit
//  -fobjc-arc
// ARC help:
//   * http://en.wikipedia.org/wiki/Automatic_Reference_Counting
//   *
//  -lobjc
//  -std=c99
//  -framework ApplicationServices

// int age = [args integerForKey:@"age"];
// printf("I'm  years old.\n", pb_string);
// NSLog(@"Hello there worldlings!");

@implementation PasteboardWatcher

@synthesize pasteboard;
@synthesize observedChangeCount;

- (id)initWithPasteboard:(NSPasteboard *)pasteboard_ {
  self = [super init];
  if (self) {
    pasteboard = pasteboard_;
    observedChangeCount = -1;
  }
  return self;
}

- (void)timerCallback:(NSTimer *)timer {
  // [[timer userInfo] poll];
  // }
  //
  // - (void)poll {
  NSInteger changeCount = [pasteboard changeCount];
  if (changeCount != observedChangeCount) {

    printf("general pasteboard changeCount = %ld\n", changeCount);
    NSString *pb_string = [pasteboard stringForType:NSPasteboardTypeString];
    printf("general pasteboard string-type contents = %s\n", [pb_string UTF8String]);
    // NSUserDefaults *args = [NSUserDefaults standardUserDefaults];
    // NSLog(@"Pasteboard updated: %@", [pasteboard types]);

    observedChangeCount = changeCount;
  }
}

// - (void)checkChangeCount:(NSTimer *)timer {}

@end

int main() {
  // set up a socket in the local scope of this main() program
  int unix_socket = socket(AF_UNIX, SOCK_STREAM, 0);

  // set up a socket file
  struct sockaddr_un local;
  local.sun_family = AF_UNIX;
  strcpy(local.sun_path, "/tmp/poll-main.sock");
  unlink(local.sun_path);

  printf("Using path: %s\n", local.sun_path);

  // bind to that socket file
  // unsigned long path_length =
  unsigned long sun_length = strlen(local.sun_path) + sizeof(local.sun_family);
  printf("sun_length = %lu + %lu = %lu\n", strlen(local.sun_path), sizeof(local.sun_family), sun_length);

  bind(unix_socket, (struct sockaddr *)&local, sun_length);
  listen(unix_socket, 5);

  struct sockaddr_un remote;
  int socket_incoming = accept(unix_socket, (struct sockaddr *)&remote, &t);
  printf("socket_incoming: %d\n", socket_incoming);

      // perror("accept");
      // exit(1);
    // }
  t = sizeof(remote);


  return 0;
}


// - (void)parseArgs {
//   NSUserDefaults *args = [NSUserDefaults standardUserDefaults];
//   // grabs command line arguments -x and -y
//   int x = [args integerForKey:@"x"];
//   int y = [args integerForKey:@"y"];
//   NSLog(@"Got -xy args: %d, %d!", x, y);
// }

// unsigned int s2;
// printf("Ints: %d, %d: %d\n", AF_UNIX, SOCK_STREAM, s);
// return 0;

int main2 (int argc, const char * argv[]) {
  // initialization
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  // initialization
  NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
  PasteboardWatcher *watcher = [[PasteboardWatcher alloc] initWithPasteboard:pasteboard];

  // start loop
  // `watcher` should have a `-(void)timerCallback:(NSTimer *)` method
  NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.25
    target:watcher selector:@selector(timerCallback:)
    userInfo:nil repeats:YES];

  // [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5.0]];
   // if (![[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])
  // NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
  NSRunLoop *runLoop = [NSRunLoop mainRunLoop];
  [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
  [runLoop run];

  // @autoreleasepool {
  //   MyClass *obj = [[MyClass alloc] init];
  //   [[NSRunLoop currentRunLoop] run];
  // }

  [pool drain]; // [pool release];
  return 0;
}


// NSFileHandle *aFileHandle = [NSFileHandle fileHandleForWritingAtPath:[@"/tmp/myapp.log" stringByExpandingTildeInPath]];
// [aFileHandle truncateFileAtOffset:[aFileHandle seekToEndOfFile]];
// [aFileHandle writeData:[[NSString stringWithFormat:@"Simulator-[%@ %s]", self, _cmd] dataUsingEncoding:NSUTF8StringEncoding]];
// [aFileHandle writeData:[NSStringFromCGSize(contentSize) dataUsingEncoding:NSUTF8StringEncoding]];

// // NSPrint
// [nsstr writeToFile:@"/dev/stdout" atomically:NO encoding:NSUTF8StringEncoding error:nil];
// // NSPrintUTF8
// printf("%s", [nsstr cStringUsingEncoding:NSUTF8StringEncoding]);
// // NSPrintMac
// printf("%s", [str cStringUsingEncoding:NSMacOSRomanStringEncoding]);
