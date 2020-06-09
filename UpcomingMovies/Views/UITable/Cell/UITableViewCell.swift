//
//  UITableViewCell.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit


class BaseCEll<U> : UITableViewCell{
    var item : U!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TableCell : BaseCEll<MoviesDetails>{
    let cellImageView = UIImageView.getRoundedImageView(frame: .zero, cornerRadius: 20.0)
    let myView =  UIView.getSquareUIView(frame: .zero)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "")
        contentView.addSubview(myView )
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0).isActive = true
        myView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0).isActive = true
        myView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0).isActive = true
        myView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.0).isActive = true
        myView.addSubview(cellImageView)
       cellImageView.translatesAutoresizingMaskIntoConstraints = false
       cellImageView.topAnchor.constraint(equalTo: myView.topAnchor, constant: 0.0).isActive = true
       cellImageView.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 0.0).isActive = true
       cellImageView.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: 0.0).isActive = true
       cellImageView.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: 0.0).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var item: MoviesDetails!{
        didSet{
            let pPath = item.poster_path
            let movieNAME = item.title
            DBAcess.LoadPosterImages(textLabel: (textLabel)!, cellImage : cellImageView, pPath: pPath, text : movieNAME!)
        }
        
        
    }
}
