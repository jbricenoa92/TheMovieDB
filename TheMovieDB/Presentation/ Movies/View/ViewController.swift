//
//  ViewController.swift
//  TheMovieDB
//
//  Created by juan.briceno on 25/07/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var categorySegment: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var SearchTextField: UITextField!
    
    
    @IBOutlet weak var filterButton: UIButton!
    
    var viewModel: MovieViewModel = DependencyInjector.shared.provideMovieViewModel() as! MovieViewModel
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        SearchTextField.delegate = self
        setupBindings()
        viewModel.loadMoviesData()
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
    }
    
    func setupBindings() {
        viewModel.onMoviesUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        viewModel.searchLetter = updatedText
        return true
    }
    
    @IBAction func FilterButtonAction(_ sender: UIButton) {
        navigateToFilterView()

    }
    
    @IBAction func CateogrySegmentAction(_ sender: UISegmentedControl) {
        if let selectedCategory = MovieCategory(rawValue: sender.selectedSegmentIndex) {
            viewModel.genre = selectedCategory.title
            viewModel.moviesData = []
            viewModel.leakedMovies = []
            viewModel.page = 1
            viewModel.loadMoviesData()
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.leakedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCell
        cell.posterImageView.image = viewModel.leakedMovies[indexPath.row].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.leakedMovies.count - 1 && !viewModel.isFetchingMore {
            viewModel.loadMoviesData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-10)/2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.movieSelected = [viewModel.leakedMovies[indexPath.row]]
        navigateToDetalleMovie()
    }
    
    
    @objc
    private func navigateToDetalleMovie(){
        
        let detailView = DetailMovieViewController()
        detailView.imageContainer.image = viewModel.movieSelected[0].image
        detailView.titleLabel.text = viewModel.movieSelected[0].title
        detailView.descriptionLabel.text = viewModel.movieSelected[0].overview
        if let sheet = detailView.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.selectedDetentIdentifier = .medium
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            
            self.present(detailView, animated: true)
            
        }
    }
    
    @objc
    private func navigateToFilterView(){
        
        let filterView = FilterViewController()
        
        if let sheet = filterView.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.selectedDetentIdentifier = .medium
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            self.present(filterView, animated: true)
            
        }
    }
    
}

