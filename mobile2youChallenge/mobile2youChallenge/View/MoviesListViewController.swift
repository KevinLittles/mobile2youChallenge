//
//  MoviesListViewController.swift
//  mobile2youChallenge
//
//  Created by Kevin Ribeiro on 22/08/21.
//

import UIKit
import RxSwift

class MoviesListViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var viewModel = MoviesListViewModel()
    
    let scrollView = UIScrollView()
    let movieImage = UIImageView()
    let movieTitle = UILabel()
    let topLikeButton = UIButton()
    let stackView = UIStackView()
    let likesIcon = UIImageView()
    let likes = UILabel()
    let viewsIcon = UIImageView()
    let views = UILabel()
    let tableView = UITableView()
    let bottomLikeButtom = UIButton()
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
    
        apllyViewCode()
    }
    
    @objc func likeButtonAction() {
        
    }
}

extension MoviesListViewController: ViewCodeConfiguration {
    
    func buildHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieImage)
        contentView.addSubview(movieTitle)
        contentView.addSubview(topLikeButton)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(likesIcon)
        stackView.addArrangedSubview(likes)
        stackView.addArrangedSubview(viewsIcon)
        stackView.addArrangedSubview(views)
        contentView.addSubview(tableView)
        contentView.addSubview(bottomLikeButtom)
    }
    
    func confirugateViews() {
        setupMovieImage()
        setupMovieTitle()
        setupTopLikeButtom()
        setupStack()
        setupTable()
        setupBottomLikeButtom()
        
        func setupMovieImage() {
            
            viewModel.getPrincipalMovie()
                .observe(on: MainScheduler.instance)
                .subscribe { movieDetails in
                    
                    if let path = movieDetails.backdropPath {
                        let image = self.viewModel.getImageByPath(path: path)
                        self.movieImage.image = image
                    } else {
                        self.movieImage.image = UIImage(systemName: "film")!
                    }
                    
                } onError: { error in
                    switch error {
                    case ServiceError.conflict:
                        print("Conflict error")
                    case ServiceError.forbidden:
                        print("Forbidden error")
                    case ServiceError.notFound:
                        print("Not found error")
                    default:
                        print("Unknown error:", error)
            
                    }
                }
                .disposed(by: disposeBag)

        }
        
        func setupMovieTitle() {
            
            viewModel.getPrincipalMovie()
                .observe(on: MainScheduler.instance)
                .subscribe { movieDetails in
                    
                    self.movieTitle.text = movieDetails.title
                    
                } onError: { error in
                    switch error {
                    case ServiceError.conflict:
                        print("Conflict error")
                    case ServiceError.forbidden:
                        print("Forbidden error")
                    case ServiceError.notFound:
                        print("Not found error")
                    default:
                        print("Unknown error:", error)
            
                    }
                }
                .disposed(by: disposeBag)
            
            movieTitle.textColor = .white
        }
        
        func setupTopLikeButtom() {
            
        }
        
        func setupStack() {
            
            setupLikesIcon()
            setupLikes()
            setupViewsIcon()
            setupViews()
            
            func setupLikesIcon() {
                
            }
            
            func setupLikes() {
                
                viewModel.getPrincipalMovie()
                    .observe(on: MainScheduler.instance)
                    .subscribe { movieDetails in
                        
                        self.likes.text = String(movieDetails.voteCount)
                        
                    } onError: { error in
                        switch error {
                        case ServiceError.conflict:
                            print("Conflict error")
                        case ServiceError.forbidden:
                            print("Forbidden error")
                        case ServiceError.notFound:
                            print("Not found error")
                        default:
                            print("Unknown error:", error)
                
                        }
                    }
                    .disposed(by: disposeBag)
                
            }
            
            func setupViewsIcon() {
                
            }
            
            func setupViews() {
                
            }
        }
        
        func setupTable() {
            
        }
        
        func setupBottomLikeButtom() {
            
        }
    }
    
    func setupAutoLayout() {
        setupScroll()
        setupMovieImage()
        setupMovieTitle()
        setupTopLikeButtom()
        setupStack()
        setupTable()
        setupBottomLikeButtom()
        
        func setupScroll() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false

            scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true;
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true;
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            
            setupContent()
            
            func setupContent() {
                contentView.translatesAutoresizingMaskIntoConstraints = false
                
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
                contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            }
        }
        
        func setupMovieImage() {
            movieImage.translatesAutoresizingMaskIntoConstraints = false
            
            movieImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            
            movieImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
            movieImage.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        }
        
        func setupMovieTitle() {
            movieTitle.numberOfLines = 0
            movieTitle.sizeToFit()
            movieTitle.translatesAutoresizingMaskIntoConstraints = false

            movieTitle.font = UIFont.systemFont(ofSize: 28)
            movieTitle.frame.size = CGSize(width: movieTitle.intrinsicContentSize.width,height: movieTitle.intrinsicContentSize.height)
            
            movieTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
            movieTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
            movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 20).isActive = true
        }
        
        func setupTopLikeButtom() {
            topLikeButton.backgroundColor = .none
            topLikeButton.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
            topLikeButton.translatesAutoresizingMaskIntoConstraints = false
            
            topLikeButton.frame.size = CGSize(width: 50 ,height: 50)
            
            topLikeButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
            topLikeButton.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 20).isActive = true
        }
        
        func setupStack() {
            stackView.axis = .horizontal
            stackView.alignment = .fill // .leading .firstBaseline .center .trailing .lastBaseline
            stackView.distribution = .fillEqually // .fillEqually .fillProportionally .equalSpacing .equalCentering
            stackView.spacing = 5
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.frame.size = CGSize(width: 300,height: 100)
            
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            
            stackView.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 20).isActive = true
            
            setupLikesIcon()
            setupLikes()
            setupViewsIcon()
            setupViews()
            
            func setupLikesIcon() {
                likesIcon.translatesAutoresizingMaskIntoConstraints = false
                
                likesIcon.frame.size = CGSize(width: 100,height: 100)
            }
            
            func setupLikes() {
                likes.translatesAutoresizingMaskIntoConstraints = false
                
                likes.font = UIFont.systemFont(ofSize: 16)
                likes.sizeToFit()
            }
            
            func setupViewsIcon() {
                viewsIcon.translatesAutoresizingMaskIntoConstraints = false
                
                likesIcon.frame.size = CGSize(width: 100,height: 100)
            }
            
            func setupViews() {
                views.translatesAutoresizingMaskIntoConstraints = false
                
                likes.font = UIFont.systemFont(ofSize: 16)
                likes.sizeToFit()
            }
        }
        
        func setupTable() {
            tableView.translatesAutoresizingMaskIntoConstraints = false
            
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
            tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
            tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        }
        
        func setupBottomLikeButtom() {
            bottomLikeButtom.backgroundColor = .none
            bottomLikeButtom.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
            bottomLikeButtom.translatesAutoresizingMaskIntoConstraints = false
            
            bottomLikeButtom.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
            bottomLikeButtom.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 100).isActive = true
            bottomLikeButtom.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -100).isActive = true
            bottomLikeButtom.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }
    }
    
}

extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension MoviesListViewController: MoviesListViewModelDelegate {
    func didChangeIsMovieLiked() {

    }
}
