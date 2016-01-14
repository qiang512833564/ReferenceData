//
//  OpenGL_ES_TestAppDelegate.m
//  OpenGL_ES_Test
//
//  Created by Zenny Chen on 09-6-29.
//  Copyright GreenGames Studio 2009. All rights reserved.
//

#import "OpenGL_ES_TestAppDelegate.h"
#import "EAGLView.h"

@implementation OpenGL_ES_TestAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    // The following instructions are just for test
    // You can remove them any time
    __asm__ volatile("fadds s0, s1, s2");
    __asm__ volatile("faddd d0, d1, d2");
    unsigned reg;
    __asm__ volatile("vmrs %0, FPSCR" : "=r"(reg));
    
    reg = 0x12345678;
    __asm__ volatile("mov r0, %0" : :"r"(reg));
    reg = 0x87654321;
    __asm__ volatile("mov r1, %0" : :"r"(reg));
    __asm__ volatile("uhadd8 %0, r0, r1" : "=r"(reg));
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}

@end
