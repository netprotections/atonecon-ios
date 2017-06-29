//
//  HomeViewController.swift
//  Demo
//
//  Created by Pham Ngoc Hanh on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit
import AtoneCon

class HomeViewController: UIViewController {

    @IBOutlet weak var atoneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = Strings.homeTitle
        atoneButton.layer.cornerRadius = 10
    }

    // MARK: - Action
    @IBAction func didTapAtoneButton(_ sender: Any) {
        let atoneController = AtoneViewController()
        present(atoneController, animated: true, completion: nil)
    }
}
