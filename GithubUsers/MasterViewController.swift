//
//  MasterViewController.swift
//  GithubUsers
//
//  Created by Nik Cane on 07/09/16.
//  Copyright © 2016 Nik Cane. All rights reserved.
//

import UIKit

protocol MasterViewControllerOutput
{
  var users: [UserModel] { get set }
  
  func requestUsers()
}

protocol DetailViewControllerOutput
{
  var users: [UserModel] { get set }
  
  func requestFollowers(currentUser: UserModel?)
}

class MasterViewController: UITableViewController
{
  var masterMode = true
  var currentUser: UserModel?

//  MARK: Delegates
  
  var masterOutput: MasterViewControllerOutput?
  var detailOutput: DetailViewControllerOutput?
  
  private var users: [UserModel] {
    if let users = self.masterMode ? self.masterOutput?.users : self.detailOutput?.users { return  users }
    else { return [UserModel]() }
  }
  
//  MARK: Object lifecycle
  
  override func viewDidLoad()
  {
    configureEnvironment()
    super.viewDidLoad()
    setupViews()
    initialLoading()
  }
  
  private func configureEnvironment() {
    MasterConfigurator.configure(self, masterMode: masterMode)
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
//  MARK:
  
  private func setupViews()
  {
    if masterMode {
      setupRefreshController()
    }
    else {
      refreshControl = nil
    }
  }
  
  private func setupRefreshController()
  {
    refreshControl?.addTarget(self, action: #selector(getMoreGithubUsers), forControlEvents: .ValueChanged)
  }
  
  private func initialLoading()
  {
    getMoreGithubUsers() 
  }
  
  @objc private func getMoreGithubUsers()
  {
    if masterMode {
      masterOutput?.requestUsers()
    }
    else {
      detailOutput?.requestFollowers(currentUser)
    }
  }

  // MARK: - Table View

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return users.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    if let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? UserCell {
      cell.setupUserCell(users[indexPath.row])
      return cell
    }
    return UITableViewCell()
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    if masterMode {
      showFollowersForUser(users[indexPath.row])
    }
  }
  
  // MARK: - Segues
  
  private func showFollowersForUser(user: UserModel)
  {
    guard let detailVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MasterViewController") as? MasterViewController else { return }
    detailVC.currentUser = user
    detailVC.masterMode = false
    navigationController?.pushViewController(detailVC, animated: true)
  }
  
}

extension MasterViewController: MasterPresenterOutput
{
  func presentUsers()
  {
    refreshControl?.endRefreshing()
    tableView.reloadData()
  }
}



