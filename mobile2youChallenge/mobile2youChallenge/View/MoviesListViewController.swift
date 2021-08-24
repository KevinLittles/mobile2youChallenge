//
//  MoviesListViewController.swift
//  mobile2youChallenge
//
//  Created by Kevin Ribeiro on 22/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import ChameleonFramework

class MoviesListViewController: UIViewController, UIScrollViewDelegate {
    
    private var disposeBag = DisposeBag()
    var viewModel = MoviesListViewModel()
    
    let scrollView = UIScrollView()
    let movieImage = UIImageView()
    let movieImageFade = UIImageView()
    let movieTitle = UILabel()
    let topLikeButton = UIButton()
    let likesIcon = UIImageView()
    let likes = UILabel()
    let viewsIcon = UIImageView()
    let views = UILabel()
    let tableView = UITableView()
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        apllyViewCode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension MoviesListViewController: ViewCodeConfiguration {
    
    func buildHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieImage)
        movieImage.addSubview(movieImageFade)
        contentView.addSubview(movieTitle)
        contentView.addSubview(topLikeButton)
        contentView.addSubview(likesIcon)
        contentView.addSubview(likes)
        contentView.addSubview(viewsIcon)
        contentView.addSubview(views)
        contentView.addSubview(tableView)
    }
    
    func setupAutoLayout() {
        setupScroll()
        setupMovieImage()
        setupMovieTitle()
        setupTopLikeButtom()
        setupLikesIcon()
        setupLikes()
        setupViewsIcon()
        setupViews()
        setupTable()
        
        func setupScroll() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.contentInsetAdjustmentBehavior = .never

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
            movieImage.contentMode = .scaleAspectFill
            
            movieImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            
            movieImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
            movieImage.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
            
            setupMovieImageFade()
            
            func setupMovieImageFade() {
                movieImageFade.translatesAutoresizingMaskIntoConstraints = false
                movieImageFade.contentMode = .scaleAspectFill
                
                movieImageFade.centerXAnchor.constraint(equalTo: movieImage.centerXAnchor).isActive = true
                movieImageFade.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor).isActive = true
                
                movieImageFade.widthAnchor.constraint(equalTo: movieImage.widthAnchor).isActive = true
                movieImageFade.heightAnchor.constraint(equalTo: movieImage.heightAnchor, multiplier: 1/3).isActive = true

            }
        }
        
        func setupMovieTitle() {
            movieTitle.numberOfLines = 0
            movieTitle.sizeToFit()
            movieTitle.translatesAutoresizingMaskIntoConstraints = false

            movieTitle.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
            
            movieTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
            movieTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
            movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor).isActive = true
        }
        
        func setupTopLikeButtom() {
            topLikeButton.backgroundColor = .none
            topLikeButton.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
            topLikeButton.translatesAutoresizingMaskIntoConstraints = false
            
            topLikeButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/15).isActive = true
            topLikeButton.heightAnchor.constraint(equalTo: topLikeButton.widthAnchor).isActive = true
            
            topLikeButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
            topLikeButton.topAnchor.constraint(equalTo: movieImage.bottomAnchor).isActive = true
        }
        
        func setupLikesIcon() {
            likesIcon.translatesAutoresizingMaskIntoConstraints = false
            
            likesIcon.heightAnchor.constraint(equalTo: likes.heightAnchor).isActive = true
            
            likesIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
            likesIcon.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10).isActive = true
            
            likesIcon.contentMode = .scaleAspectFit
            likesIcon.clipsToBounds = true
            
            likesIcon.tintColor = .lightGray
        }
        
        func setupLikes() {
            likes.translatesAutoresizingMaskIntoConstraints = false
            
            likes.font = UIFont.systemFont(ofSize: 16)
            likes.textColor = .lightGray
            likes.numberOfLines = 1
            likes.sizeToFit()
            
            likes.leftAnchor.constraint(equalTo: likesIcon.rightAnchor, constant: 5).isActive = true
            likes.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10).isActive = true
            
            likes.heightAnchor.constraint(equalToConstant: 16).isActive = true
        }
        
        func setupViewsIcon() {
            viewsIcon.translatesAutoresizingMaskIntoConstraints = false
            
            viewsIcon.heightAnchor.constraint(equalTo: views.heightAnchor).isActive = true
            
            viewsIcon.leftAnchor.constraint(equalTo: likes.rightAnchor, constant: 20).isActive = true
            viewsIcon.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10).isActive = true
            
            viewsIcon.contentMode = .scaleAspectFit
            viewsIcon.clipsToBounds = true
            
            viewsIcon.tintColor = .lightGray
        }
        
        func setupViews() {
            views.translatesAutoresizingMaskIntoConstraints = false
            
            views.font = UIFont.systemFont(ofSize: 16)
            views.textColor = .lightGray
            views.numberOfLines = 1
            views.sizeToFit()
            
            views.leftAnchor.constraint(equalTo: viewsIcon.rightAnchor, constant: 5).isActive = true
            views.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10).isActive = true
            
            views.heightAnchor.constraint(equalToConstant: 16).isActive = true
        }
        
        func setupTable() {
            tableView.translatesAutoresizingMaskIntoConstraints = false
            
            tableView.topAnchor.constraint(equalTo: likes.bottomAnchor, constant: 10).isActive = true
            tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
            tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            
            tableView.heightAnchor.constraint(equalToConstant: (view.frame.size.height/8)*20).isActive = true

        }
        
    }
    
    func confirugateViews() {
        setupMovieImage()
        setupMovieTitle()
        setupTopLikeButtom()
        setupStack()
        setupTable()
        
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
                    
                    if let image = self.movieImage.image {
                        self.movieTitle.textColor = AverageColorFromImage(image: image)
                        self.topLikeButton.imageView?.tintColor = AverageColorFromImage(image: image)
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

            setupMovieImageFade()
            
            func setupMovieImageFade() {
                movieImageFade.image = UIImage.init(named: "movieImageFade")

            }
            
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
        }
        
        func setupTopLikeButtom() {
            topLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            topLikeButton.imageView?.contentMode = .scaleAspectFit
            
            topLikeButton.imageEdgeInsets = UIEdgeInsets(
                    top: (topLikeButton.frame.size.height),
                    left: (topLikeButton.frame.size.width),
                    bottom: (topLikeButton.frame.size.height),
                    right: (topLikeButton.frame.size.width))

        }
        
        func setupStack() {
            
            setupLikesIcon()
            setupLikes()
            setupViewsIcon()
            setupViews()
            
            func setupLikesIcon() {
                likesIcon.image = UIImage(systemName: "heart.fill")
            }
            
            func setupLikes() {
                
                viewModel.getPrincipalMovie()
                    .observe(on: MainScheduler.instance)
                    .subscribe { movieDetails in
                        
                        self.likes.text = String(movieDetails.voteCount) + " likes"
                        
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
                viewsIcon.image = UIImage(systemName: "eye.fill")
            }
            
            func setupViews() {
                
                viewModel.getPrincipalMovie()
                    .observe(on: MainScheduler.instance)
                    .subscribe { movieDetails in
                        
                        self.views.text = String(movieDetails.popularity) + " views"
                        
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
        }
        
        func setupTable() {
            tableView.delegate = nil
            tableView.dataSource = nil
            tableView.rx.setDelegate(self)
                .disposed(by: disposeBag)
            
            tableView.isUserInteractionEnabled = false
        
            tableView.register(MoviesListTableViewCell.self, forCellReuseIdentifier: "movieCell")
            
            viewModel.getSimilarMoviesDetails()
                .bind(to: tableView.rx.items(cellIdentifier: "movieCell", cellType: MoviesListTableViewCell.self)) { ( row, model, cell) in
                    
                    cell.movieTitleLabel.text = model.title
                        
                    if let path = model.backdropPath {
                        cell.movieImage.image = self.viewModel.getImageByPath(path: path)
                    }
                    cell.movieYearLabel.text = String(model.releaseDate.prefix(4))
                    
                    if model.genres.count >= 2 {
                        cell.movieGenreLabel.text = model.genres[0].name + ", " + model.genres[1].name
                    } else {
                        cell.movieGenreLabel.text = model.genres[0].name
                    }
                    
                    if let image = self.movieImage.image {
                        cell.movieYearLabel.textColor = AverageColorFromImage(image: image)
                        cell.movieTitleLabel.textColor = AverageColorFromImage(image: image)
                    }
                    
            }.disposed(by: disposeBag)
        }
        
    }

}

extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/8
    }
    
}

extension MoviesListViewController: MoviesListViewModelDelegate {
    
    func didChangeIsMovieLiked() {
        if viewModel.isMovieLiked == true {
            
            topLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            topLikeButton.imageView?.contentMode = .scaleAspectFit
            topLikeButton.imageEdgeInsets = UIEdgeInsets(
                    top: (topLikeButton.frame.size.height),
                    left: (topLikeButton.frame.size.width),
                    bottom: (topLikeButton.frame.size.height),
                    right: (topLikeButton.frame.size.width))
        } else {
            
            topLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            topLikeButton.imageView?.contentMode = .scaleAspectFit
            topLikeButton.imageEdgeInsets = UIEdgeInsets(
                    top: (topLikeButton.frame.size.height),
                    left: (topLikeButton.frame.size.width),
                    bottom: (topLikeButton.frame.size.height),
                    right: (topLikeButton.frame.size.width))
        }
    }
    
    @objc func likeButtonAction() {
        viewModel.changeIsMovieLiked()
    }
}
