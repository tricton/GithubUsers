//
//  ImageWorker.swift
//  GithubUsers
//
//  Created by Nik Cane on 08/09/16.
//  Copyright © 2016 Nik Cane. All rights reserved.
//

import UIKit

class ImageWorker: NSObject
{
  class func getUserImage(urlStr: String, completion: (UIImage?)->())
  {
    if NSFileManager.defaultManager().fileExistsAtPath(urlStr) {
      completion(UIImage(contentsOfFile: urlStr))
    }
    else {
      downloadImageForURL(urlStr, completion: completion)
    }
  }
  
  private class func downloadImageForURL(urlStr: String, completion: (UIImage?)->())
  {
    ImageDownloadWorker.loadImageForURL(urlStr){ data in
      guard let data = data else { completion(nil); return }
      completion(UIImage(data: data))
      saveThumbnailToDocumentsFolder(urlStr, imageData: data)
    }
  }
  
  private class func saveThumbnailToDocumentsFolder(urlStr: String, imageData: NSData) -> Bool
  {
    guard let thumbPath = thumbPath(urlStr) else { return false }
    return NSFileManager.defaultManager().createFileAtPath(thumbPath, contents: imageData, attributes: nil)
  }
  
  private class func thumbPath(urlStr: String) -> String?
  {
    let thumb = "thumbnail" + urlStr + ".jpg"
    return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first?.stringByAppendingString("/"+thumb)
  }
}
