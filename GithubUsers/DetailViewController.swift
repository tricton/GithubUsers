//
//  DetailViewController.swift
//  GithubUsers
//
//  Created by Nik Cane on 07/09/16.
//  Copyright © 2016 Nik Cane. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var detailDescriptionLabel: UILabel!

  var detailItem: UserModel? {
    didSet {
        // Update the view.
        self.configureView()
    }
  }

  func configureView()
  {
    if let detail = self.detailItem {
      if let label = self.detailDescriptionLabel {
//          label.text = detail.description
      }
    }
  }

  override func viewDidLoad()
  {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.configureView()
  }

  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

