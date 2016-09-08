//
//  UserModel.swift
//  GithubUsers
//
//  Created by Nik Cane on 07/09/16.
//  Copyright © 2016 Nik Cane. All rights reserved.
//

import UIKit

struct UserModel
{
  var id: Int = 0
  var login: String = ""
  var avatarUrl: String = ""
  var htmlUrl: String = ""
  var followersUrl: String = ""
  
  init(user: NSDictionary)
  {
    if let id = user["id"] as? NSNumber {
      self.id = id.longValue
    }
    if let login = user["login"] as? String {
      self.login = login
    }
    if let avatarUrl = user["avatar_url"] as? String {
      self.avatarUrl = avatarUrl
    }
    if let htmlUrl = user["html_url"] as? String {
      self.htmlUrl = htmlUrl
    }
    if let followersUrl = user["followers_url"] as? String {
      self.followersUrl = followersUrl
    } 
  }
}
