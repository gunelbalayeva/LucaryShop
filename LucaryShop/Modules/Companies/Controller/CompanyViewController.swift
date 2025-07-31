//
//  CompanyViewController.swift
//  LucaryShop
//
//  Created by User on 20.06.25.
//
import Foundation
import UIKit
import Combine
final class CompanyViewController: UIViewController {
    let companyView = CompanyView()
    let viewModel: CompanyViewModel
    private var cancellables = Set<AnyCancellable>()
     var filteredCompanies: [Company] = []
    var dataSource: UICollectionViewDiffableDataSource<CompanySection, Company>!

    override func loadView() {
        self.view = companyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        setupDataSource()
        call()
        binding()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            viewModel.coordinator?.finish()
        }
    }

    init(viewModel: CompanyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func call(){
        NotificationCenter.default.addObserver(self,
               selector: #selector(languageDidChange),
               name: .appLanguageDidChange,
               object: nil)
           updateTextsForCurrentLanguage()
        companyView.tabSwitcher.searchBar.delegate = self
        companyView.companiesCollectionView.delegate = self
        companyView.companiesCollectionView.register(CompanyCell.self,
                                                     forCellWithReuseIdentifier: CompanyCell.identifier)

        companyView.onHomeTapped = { [weak self] in
            self?.viewModel.coordinator?.finish()
            self?.navigationController?.popViewController(animated: true)
        }
    }

    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<CompanySection, Company>(
            collectionView: companyView.companiesCollectionView
        ) { (collectionView, indexPath, company) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyCell.identifier, 
                                                          for: indexPath) as! CompanyCell
            cell.configure(with: company)
            return cell
        }
    }

     func applySnapshot(companies: [Company]) {
        var snapshot = NSDiffableDataSourceSnapshot<CompanySection, Company>()
        snapshot.appendSections([.main])
        snapshot.appendItems(companies, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func binding() {
        viewModel.fetchCompanies()
        viewModel.$companies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] companies in
                self?.applySnapshot(companies: companies)
                print("count: \(companies.count)")
            }
            .store(in: &cancellables)
    }
    
    @objc
    private func languageDidChange() {
        updateTextsForCurrentLanguage()
    }

    func updateTextsForCurrentLanguage() {
        companyView.tabSwitcher.searchBar.placeholder = LocalizedStrings.searchBar
    }
}

