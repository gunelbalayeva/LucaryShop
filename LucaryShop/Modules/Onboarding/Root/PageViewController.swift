//
//  PageViewController.swift
//  LucaryShop
//
//  Created by User on 10.06.25.
//

import UIKit

final class PageViewController: UIPageViewController {
    
    private let pages: [UIViewController]
    private var currentIndex: Int = 0
    private let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPageControl()
        setInitialPage()
        dataSource = self
        delegate = self
    }
    
    init(pages: [UIViewController]) {
        self.pages = pages
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = currentIndex
        pageControl.currentPageIndicatorTintColor = UIColor(named: "baseButton") ?? .systemBlue
        pageControl.pageIndicatorTintColor = (UIColor(named: "baseButton") ?? .systemBlue).withAlphaComponent(0.3)
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
    }
    private func updatePageControlIndicator(for index: Int) {
        let imageName = index == 0 ? "smallcircle.fill.circle" : "star.fill"
        let indicatorImage = UIImage(systemName: imageName)?
            .withTintColor(UIColor(named: "baseButton") ?? .systemBlue, renderingMode: .alwaysOriginal)
        
        pageControl.setIndicatorImage(indicatorImage, forPage: index)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.pageControl.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.pageControl.transform = .identity
            }
        }
    }
    
    private func setInitialPage() {
        guard let firstPage = pages.first else { return }
        setViewControllers([firstPage], direction: .forward, animated: false, completion: nil)
    }
    
    func goToPage(index: Int, animated: Bool = true) {
        guard index >= 0, index < pages.count else { return }
        
        let direction: UIPageViewController.NavigationDirection = index >= currentIndex ? .forward : .reverse
        currentIndex = index
        
        setViewControllers([pages[index]], direction: direction, animated: animated, completion: nil)
        pageControl.currentPage = index
    }
}


extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        
        guard completed,
              let currentVC = pageViewController.viewControllers?.first,
              let index = pages.firstIndex(of: currentVC) else { return }
        
        currentIndex = index
        pageControl.currentPage = index
        updatePageControlIndicator(for: index)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.pageControl.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.pageControl.transform = .identity
            }
        }
    }
}
