//
//  FollowersWorker.swift
//  GithubUsers
//
//  Created by Nik Cane on 08/09/16.
//  Copyright © 2016 Nik Cane. All rights reserved.
//

import UIKit

class FollowersWorker: NSOperation
{
  private let _followersURL: String
  private let _completion: ([UserModel]?)->()
  
  init(request: FollowersRequest)
  {
    self._followersURL = request.urlStr
    self._completion = request.completion
  }
  
  override func main()
  {
    guard cancelled == false else { _completion(nil); return }
    guard let request = createRequest() else { _completion(nil); return }
    let usersHandler = UsersHandler(completion: _completion)
    usersHandler.loadNextChunkOfUsers(request)
  }
  
  private func createRequest() -> NSURLRequest?
  {
    guard let url = NSURL(string: _followersURL) else { _completion(nil); return nil }
    return NSURLRequest(URL: url)
  }
}

