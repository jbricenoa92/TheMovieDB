//
//  FilterViewCOntroller.swift
//  TheMovieDB
//
//  Created by juan.briceno on 26/07/24.
//


import UIKit


class FilterViewController: UIViewController {
    
    var viewModel: MovieViewModel = DependencyInjector.shared.provideMovieViewModel() as! MovieViewModel

    
    override func viewDidLoad(){
        super.viewDidLoad()
        print(viewModel.onlyAdult)
        configUI()
        onlyAdultSwicth.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        onlyAdultSwicth.isOn = viewModel.onlyAdult    }
    
    var filterTitle: UILabel = {
        let label = UILabel()
        label.text = "FILTRAR"
        label.textColor = .darkText
        return label
    }()
    
    var filterAdult: UILabel = {
        let label = UILabel()
        label.text = "Solo peliculas para adultos"
        label.textColor = .darkText
        return label
    }()
    
    var onlyAdultSwicth: UISwitch = {
        let button = UISwitch()
        return button
    }()
   
    
    var stackV: UIStackView = {
        let stackv = UIStackView()
        stackv.alignment = .center
        stackv.axis = .vertical
        stackv.distribution = .equalCentering
        stackv.translatesAutoresizingMaskIntoConstraints = false
        return stackv
    }()
    
    var stackSubContainer: UIStackView = {
        let stackv = UIStackView()
        stackv.alignment = .leading
        stackv.axis = .horizontal
        stackv.distribution = .equalSpacing
        stackv.translatesAutoresizingMaskIntoConstraints = false
        return stackv
    }()
    
    func configUI(){
        view.backgroundColor = .systemGray4
        view.addSubview(stackV)
        stackV.addArrangedSubview(filterTitle)
        stackV.addArrangedSubview(stackSubContainer)
        stackSubContainer.addArrangedSubview(filterAdult)
        stackSubContainer.addArrangedSubview(onlyAdultSwicth)
        setupStackViewConstraints()
        
    }
    
    func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackSubContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackSubContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackSubContainer.topAnchor.constraint(equalTo: filterTitle.bottomAnchor, constant: 10),
            
        ])
        
    }
    
    
    @objc
    func switchChanged(_ sender: UISwitch) {
                viewModel.onlyAdult = sender.isOn
        }
    
}
