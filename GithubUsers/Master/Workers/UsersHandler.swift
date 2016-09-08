//
//  UsersHandler.swift
//  GithubUsers
//
//  Created by Nik Cane on 08/09/16.
//  Copyright © 2016 Nik Cane. All rights reserved.
//

import UIKit

struct UsersHandler
{
  private let _completion: ([UserModel]?)->()
  
  init(completion: ([UserModel]?)->())
  {
    self._completion = completion
  }
  
  func loadNextChunkOfUsers(request: NSURLRequest)
  {
    task(request, completion: userListDownloadCompletion)?.resume()
  }
  
  func task(request: NSURLRequest, completion: (NSData?, NSURLResponse?, NSError?) -> ()) -> NSURLSessionDataTask?
  {
    return NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
      .dataTaskWithRequest(request, completionHandler: completion)
  }
  
  func userListDownloadCompletion(data: NSData?, response: NSURLResponse?, error: NSError?)
  {
    guard error == nil else { _completion(nil); print(error); return }
    guard let data = data else { return }
    parseResponse(data)
  }
  
  private func parseResponse(data: NSData)
  {
    do {
      if let userList = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [NSDictionary] {
        makeuserListCompletion(userList)
      }
    }
    catch let error as NSError {
      _completion(nil)
      print(error)
    }
  }
  
  private func makeuserListCompletion(userList: [NSDictionary])
  {
    _completion(userList.flatMap({ UserModel(user: $0)}))
  }
}
