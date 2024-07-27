//
//  FilterViewCOntroller.swift
//  TheMovieDB
//
//  Created by juan.briceno on 26/07/24.
//

import Foundation
import UIKit


class FilterViewController: UIViewController {
    
    var viewModel: MovieViewModel = DependencyInjector.shared.provideMovieViewModel() as! MovieViewModel

    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
    
    
    
    
}
