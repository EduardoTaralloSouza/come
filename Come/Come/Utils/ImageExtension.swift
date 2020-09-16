//
//  ImageExtension.swift
//  Come
//
//  Created by Eduardo Souza on 14/09/20.
//  Copyright © 2020 Eduardo Tarallo Souza. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(url: URL) {
        DispatchQueue.global().async {[weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
