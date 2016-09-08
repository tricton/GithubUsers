//
//  UserCell.swift
//  GithubUsers
//
//  Created by Nik Cane on 08/09/16.
//  Copyright © 2016 Nik Cane. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell
{
  func setupUserCell(user: UserModel)
  {
    setUserImage(user.avatarUrl)
    setUserData(user)
  }
  
  private func setUserImage(urlStr: String)
  {
    ImageWorker.getUserImage(urlStr){ [weak self] image in
      if let image = image {
        self?.setUserImageOnMainThread(image)
      }
    }
  }
  
  private func setUserData(user: UserModel)
  {
    textLabel?.text = user.login
    detailTextLabel?.text = user.htmlUrl
  }
  
  private func setUserImageOnMainThread(image: UIImage)
  {
    dispatch_async(dispatch_get_main_queue(), { [weak self] in
      self?.imageView?.image = image
    })
  }
}
