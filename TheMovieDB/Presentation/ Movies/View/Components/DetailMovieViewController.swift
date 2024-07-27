//
//  MovieViewController.swift
//  TheMovieDB
//
//  Created by juan.briceno on 25/07/24.
//

import UIKit
import Combine

class DetailMovieViewController: UIViewController {
    
    var viewModel: MovieViewModel = DependencyInjector.shared.provideMovieViewModel() as! MovieViewModel
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configUI()
       print(viewModel.MovieSelected)
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
        title.textColor = .darkGray
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    var descriptionLabel:UILabel = {
        let description = UILabel()
        description.text = "nw_connection_copy_connected_local_endpoint_block_invoke [C2] Client called nw_connection_copy_connected_local_endpoint on unconnected nw_connection"
        description.textColor = .darkText
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func configUI() {
        view.addSubview(imageContainer)
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        setupStackViewConstraints()

    }
    
    func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imageContainer.widthAnchor.constraint(equalToConstant: 180),
            imageContainer.heightAnchor.constraint(equalToConstant: 180),
            imageContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
        ])
    }

}
