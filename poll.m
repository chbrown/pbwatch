#import <Foundation/Foundation.h>
#import <AppKit/NSPasteboard.h>
#import "poll.h"

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
  @autoreleasepool {
    NSInteger changeCount = [pasteboard changeCount];
    if (changeCount > observedChangeCount) {
      NSString *pasteboard_string = [pasteboard stringForType:NSPasteboardTypeString];
      printf("%ld\t%s\n", changeCount, [pasteboard_string UTF8String]);
      observedChangeCount = changeCount;
    }
  }
}

@end

int main(int argc, const char * argv[]) {
  NSPasteboard *pasteboard = [NSPasteboard generalPasteboard]; // i.e., "Apple CFPasteboard general"
  PasteboardWatcher *watcher = [[PasteboardWatcher alloc] initWithPasteboard:pasteboard];

  // `watcher` should have a `-(void)timerCallback:(NSTimer *)` method
  NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.25
    target:watcher selector:@selector(timerCallback:)
    userInfo:nil repeats:YES];

  NSRunLoop *runLoop = [NSRunLoop mainRunLoop]; // ? [NSRunLoop currentRunLoop];
  [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
  [runLoop run];

  return 0;
}
