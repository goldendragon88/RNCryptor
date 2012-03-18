//
//  RNCryptorDataOutputStream
//
//  Copyright (c) 2012 Rob Napier
//
//  This code is licensed under the MIT License:
//
//  Permission is hereby granted, free of charge, to any person obtaining a 
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.

#import <CommonCrypto/CommonHMAC.h>
#import "RNCryptorDataOutputStream.h"

@interface RNCryptorDataOutputStream ()
@property (nonatomic, readwrite, strong) NSMutableData *mutableData;
@property (nonatomic, readwrite, copy) NSData *HMACKey;
@end

@implementation RNCryptorDataOutputStream
@synthesize mutableData = mutableData_;
@synthesize HMACKey = HMACKey_;


- (id)initWithHMACKey:(NSData *)HMACKey
{
  self = [super init];
  if (self)
  {
    mutableData_ = [NSMutableData data];
    HMACKey_ = HMACKey;
  }
  return self;
}

- (NSData *)data
{
  return [self mutableData];
}

- (BOOL)writeData:(NSMutableData *)data error:(NSError **)error
{
  [self.mutableData appendData:data];
  return YES;
}

- (NSData *)HMAC
{
  NSMutableData *HMAC = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
  CCHmac(kCCHmacAlgSHA1, [self.HMACKey bytes], [self.HMACKey length], [self.data bytes], [self.data length], [HMAC mutableBytes]);
  return HMAC;
}

@end