//
//  ImageDownloadWorker.swift
//  GithubUsers
//
//  Created by Nik Cane on 08/09/16.
//  Copyright © 2016 Nik Cane. All rights reserved.
//

import UIKit

class ImageDownloadWorker: NSObject
{
  class func loadImageForURL(urlStr: String, completion: (NSData?)->())
  {
    guard let URL = NSURL(string: urlStr + "&s=100") else { completion(nil); return }
    task(URL, completion:completion)
  }
  
  private class func task(URL: NSURL, completion: (NSData?)->())
  {
    NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
      .dataTaskWithURL(URL) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
        guard error == nil else { completion(nil); return }
        if let data = data {
          completion(data)
        }
    }
      .resume()
  }
}
