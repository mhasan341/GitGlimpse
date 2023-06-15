//
//  ImageManager.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import UIKit

class ImageManager: ImageService {

    /// stores image in cache for better UX
    let cache = NSCache<NSString, UIImage>()

    /// download an image if not present in cache
    func downloadImage(urlString: String, completed: @escaping (UIImage?)-> Void){
        // check cache
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey){
            completed(image)
            return
        }

        // not found? let's move
        guard let url = URL(string: urlString) else{
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            guard let response = response as? HTTPURLResponse, response.statusCode == 200,
                  error == nil,
                  let data = data,
                  let image = UIImage(data: data) else{

                completed(nil)
                return
            }


            self.cache.setObject(image, forKey: cacheKey)

            completed(image)

        }

        task.resume()

    }
}
