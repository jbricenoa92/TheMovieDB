//
//  MovieCellCollectionViewCell.swift
//  TheMovieDB
//
//  Created by juan.briceno on 25/07/24.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        
    }
    
}
