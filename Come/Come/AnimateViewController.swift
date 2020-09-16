//
//  AnimateViewController.swift
//  Come
//
//  Created by Eduardo Souza on 16/09/20.
//  Copyright © 2020 Eduardo Tarallo Souza. All rights reserved.
//

import UIKit

class AnimateViewController: UIViewController {


    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "launchImage")
        return imageView
    }()





    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.animate()
        }
    }

    private func animate() {

    }


}
