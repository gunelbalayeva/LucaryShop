//
//  GetStartedOnboardingViewController  .swift
//  LucaryShop
//
//  Created by User on 10.06.25.
//

import UIKit

final class GetStartedOnboardingViewController :UIViewController{
    
    private let viewModel: GetStartedOnboardingViewModel
    private let pageView = GetStartedOnboardingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .onboarding
        setupUI()
    }
    
    func setupUI(){
        view.addSubview(pageView)
        pageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageView.configure(viewModel: viewModel)
    }
    init(viewModel: GetStartedOnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
