//
//  MasterWorker.swift
//  GithubUsers
//
//  Created by Nik Cane on 07/09/16.
//  Copyright (c) 2016 Nik Cane. All rights reserved.

import UIKit

private let basicRequest = "https://api.github.com/users"
private let perPage = 20

class MasterWorker: NSOperation
{
  private let _startsWith: Int
  private let _completion: ([UserModel]?)->()
  
  init(request: UsersRequest)
  {
    self._startsWith = request.startsWith + 1
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
    let actualURLString = basicRequest + "?since=\(_startsWith)" + "&per_page=\(perPage)"
    guard let url = NSURL(string: actualURLString) else { _completion(nil); return nil }
    return NSURLRequest(URL: url)
  }
}
