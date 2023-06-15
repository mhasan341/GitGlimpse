//
//  ImageService.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import UIKit
/// protocol for any vc that uses image
protocol ImageService {
    func downloadImage(urlString: String, completed: @escaping (UIImage?)-> Void)
}
