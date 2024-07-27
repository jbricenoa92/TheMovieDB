//
//  MovieViewController.swift
//  TheMovieDB
//
//  Created by juan.briceno on 25/07/24.
//

import UIKit

class DetailMovieViewController: UIViewController {
    
    var viewModel: MovieViewModel = DependencyInjector.shared.provideMovieViewModel() as! MovieViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    var imageContainer: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "vacio_img.png")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var titleLabel: UILabel = {
        let title = UILabel()
        title.text = ""
        title.textColor = .darkText
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    var descriptionLabel:UILabel = {
        let description = UILabel()
        description.text = ""
        description.textColor = .darkText
        description.translatesAutoresizingMaskIntoConstraints = false
        description.numberOfLines = 0
        description.textAlignment = .justified
        return description
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func configUI() {
        view.backgroundColor = .systemGray4
        view.addSubview(stackView)
        stackView.addArrangedSubview(imageContainer)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        setupStackViewConstraints()

    }
    
    func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imageContainer.widthAnchor.constraint(equalToConstant: 180),
            imageContainer.heightAnchor.constraint(equalToConstant: 180),
            titleLabel.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 10),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            
        ])
    }

}
