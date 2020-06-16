//
//  TableCell.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 15/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class TableCell : BaseCEll<MoviesDetails>{
    var myView : UIView!
    var cellImageView : UIImageView!
    var ratingCircle: RatingCircle?
    var ratingLabel: UILabel?
    var totalVotes: UILabel?
    var language: UILabel?
    var label : UILabel?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "")
        myView =  UIView.getSquareUIView(parentView: contentView, frame: .zero)
        cellImageView = UIImageView.getRoundedImageView(ParentView: myView, frame: .zero, cornerRadius: 20.0, topAnchor: 0.0, leadingAnchor: 0.0, trailingAnchor: 0.0, bottomAnchor: 90.0)
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        textLabel?.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 10).isActive = true
        textLabel?.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 80).isActive = true
        textLabel?.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -10).isActive = true
        textLabel?.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -20).isActive = true
        textLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 40, weight: .heavy)
        ratingCircle = RatingCircle(frame: .zero)
        ratingCircle?.progressColor = .systemGreen
        contentView.addSubview(ratingCircle!)
        guard let textLabel = textLabel else {return}
        ratingCircle?.translatesAutoresizingMaskIntoConstraints = false
        ratingCircle?.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 40).isActive = true
        ratingCircle?.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 40).isActive = true
        ratingCircle?.trailingAnchor.constraint(equalTo: textLabel.leadingAnchor, constant: -10).isActive = true
        ratingCircle?.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -10).isActive = true
        ratingLabel = UILabel.getUILabel(parentView: myView)
        ratingLabel?.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel?.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 0).isActive = true
        ratingLabel?.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 0).isActive = true
        ratingLabel?.trailingAnchor.constraint(equalTo: textLabel.leadingAnchor, constant: 0).isActive = true
        ratingLabel?.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant:   -10).isActive = true
        
        label = UILabel.getUILabel(parentView: myView)
        label?.textAlignment = .left
        label?.translatesAutoresizingMaskIntoConstraints = false
        label?.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 70).isActive = true
        label?.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 10).isActive = true
        label?.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 0).isActive = true
        label?.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant:   -3).isActive = true
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var item: MoviesDetails!{
        didSet{
            let pPath = item.poster_path
            let movieNAME = item.title
            ratingCircle?.LoadingBarAnimation(toValue: item.vote_average!/10)
            cellImageView.image = UIImage()
            textLabel?.text = movieNAME
            ratingLabel?.text = "\(item.vote_average!)"
            textLabel?.textAlignment = .center
            textLabel?.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            textLabel?.layer.shadowColor = UIColor.black.cgColor
            textLabel?.layer.shadowRadius = 12.0
            textLabel?.layer.shadowOpacity = 0.7
            label?.text = "User Score"
            DBAcess.LoadPosterImages( cellImage : cellImageView, pPath: pPath)
        }
        
        
    }
}

