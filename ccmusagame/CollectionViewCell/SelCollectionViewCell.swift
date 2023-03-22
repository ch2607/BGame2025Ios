//
//  SewlCollectionViewCell.swift
//  ccmusagame
//
//  Created by Carl Hsieh on 8/22/22.
//  Copyright © 2022 Carl Hsieh. All rights reserved.
//

import UIKit

class SelCollectionViewCell: UICollectionViewCell {

  //  static let identifier = "SewlCollectionViewCell"
  
   
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        setupView()
    }
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
    
        return image
    }()
    var imagestar1: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    let imagestar2: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    let imagestar3: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemBlue
      //  label.text = "1"
        if GameName.shared.width > 80
        {
            label.font =  .boldSystemFont(ofSize: 14)
        }
        else
        {
            if GameName.shared.width > 30
            {
                label.font =  .boldSystemFont(ofSize: 15)
            }
            else
            {
                label.font =  .boldSystemFont(ofSize: 15)
            }
        }
        return label
    }()


    func  setupView()
    {
        addSubview(imageView)
       addSubview(textLabel)
        addSubview(imagestar1)
        addSubview(imagestar2)
        addSubview(imagestar3)
       
        imagestar1.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 2.0).isActive = true
        imagestar1.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imagestar1.widthAnchor.constraint(equalToConstant:  30).isActive = true
        imagestar1.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 50).isActive = true
        imagestar1.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -100).isActive = true
      
        imagestar2.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 2).isActive = true
        imagestar2.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -100).isActive = true
        imagestar2.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 1.0).isActive = true
        imagestar2.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imagestar2.widthAnchor.constraint(equalToConstant:  80).isActive = true
     
        imagestar3.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 1.0).isActive = true
        imagestar3.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imagestar3.widthAnchor.constraint(equalToConstant:  80).isActive = true
        imagestar3.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 2).isActive = true
        imagestar3.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -100).isActive = true
       
        imageView.topAnchor.constraint(equalTo:
        self.safeAreaLayoutGuide.topAnchor).isActive = true
        //  imagestar1.bottomAnchor, constant: 5).isActive = true
       // imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
      //  imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant:  80).isActive = true
     /*
        textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 190).isActive = true
   //     textLabel.heightAnchor.constraint(equalToConstant: CGFloat(25)).isActive = true
    //   textLabel.widthAnchor.constraint(equalToConstant: CGFloat(GameName.shared.width)).isActive = true
        textLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textLabel.widthAnchor.constraint(equalToConstant:  60).isActive = true
        textLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20).isActive = true
        textLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -100).isActive = true
        
        textLabel.text = "創世記"  */
     
    }

    required init?(coder: NSCoder) {
      //  form = Form()
        super.init(coder: coder)
   }

}
