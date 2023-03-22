//
//  Customeqns3.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 8/8/22.
//  Copyright © 2022 Carl Hsieh. All rights reserved.
//

import Foundation
import UIKit
class CustomeCellqns3: UICollectionViewCell
{
    
 
    var animation = 0
override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
}

let imageView: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
   
  //    UIView.animate(withDuration: 3.0, animations: ({
  //        image.transform = CGAffineTransform(rotationAngle: 388)
  //    }))
    
    return image
}()

let textLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.textColor = .black
    if GameName.shared.width > 80
    {
        label.font =  .boldSystemFont(ofSize: 38)
    }
    else
    {
        if GameName.shared.width > 30
        {
            label.font =  .boldSystemFont(ofSize: 28)
        }
        else
        {
            label.font =  .boldSystemFont(ofSize: 20)
        }
    }
    return label
}()

func  setupView()
{
    addSubview(imageView)
    addSubview(textLabel)
    
    imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: CGFloat(GameName.shared.width)).isActive = true
    imageView.widthAnchor.constraint(equalToConstant:  CGFloat(GameName.shared.width)).isActive = true
    
    textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    // textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
    textLabel.heightAnchor.constraint(equalToConstant: CGFloat(GameName.shared.width)).isActive = true
    textLabel.widthAnchor.constraint(equalToConstant: CGFloat(GameName.shared.width)).isActive = true
 //   print("carl text = \(textLabel.text)")
    
}

required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
    
}
