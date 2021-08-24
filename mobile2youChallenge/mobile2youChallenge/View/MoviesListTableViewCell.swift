//
//  MoviesListTableViewCell.swift
//  mobile2youChallenge
//
//  Created by Kevin Ribeiro on 24/08/21.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {

    let movieImage = UIImageView()
    let verticalStackView = UIStackView()
    let movieTitleLabel = UILabel()
    let horizontalContentView = UIView()
    let movieYearLabel = UILabel()
    let movieGenreLabel = UILabel()
    
    let identifier = "movieCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        apllyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MoviesListTableViewCell: ViewCodeConfiguration {
    
    func buildHierarchy() {
        contentView.addSubview(movieImage)
        contentView.addSubview(verticalStackView)
        verticalStackView.addSubview(movieTitleLabel)
        verticalStackView.addSubview(horizontalContentView)
        horizontalContentView.addSubview(movieYearLabel)
        horizontalContentView.addSubview(movieGenreLabel)
    }
    
    func setupAutoLayout() {
        setupMovieImage()
        setupVerticalStackView()
        
        func setupMovieImage() {
            movieImage.translatesAutoresizingMaskIntoConstraints = false
            
            movieImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
            movieImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            movieImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8).isActive = true
            movieImage.contentMode = .scaleAspectFit
        }
        
        func setupVerticalStackView() {
            verticalStackView.translatesAutoresizingMaskIntoConstraints = false
            verticalStackView.alignment = .center
            verticalStackView.spacing = 5
            
            verticalStackView.leftAnchor.constraint(equalTo: movieImage.rightAnchor, constant: 10).isActive = true
            verticalStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            verticalStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
            
            setupMovieTitleLabel()
            setupHorizontalContentView()
            
            func setupMovieTitleLabel() {
                movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
                
                movieTitleLabel.numberOfLines = 1
                movieTitleLabel.sizeToFit()

                movieTitleLabel.font = UIFont.systemFont(ofSize: 18)
                movieTitleLabel.frame.size = CGSize(width: movieTitleLabel.intrinsicContentSize.width,height: movieTitleLabel.intrinsicContentSize.height)
            }
            
            func setupHorizontalContentView() {
                horizontalContentView.translatesAutoresizingMaskIntoConstraints = false

                horizontalContentView.leftAnchor.constraint(equalTo: verticalStackView.rightAnchor).isActive = true
                horizontalContentView.heightAnchor.constraint(equalTo: movieYearLabel.heightAnchor).isActive = true
                
                setupMovieYearLabel()
                setupMovieGenreLabel()
                
                func setupMovieYearLabel() {
                    movieYearLabel.translatesAutoresizingMaskIntoConstraints = false
                    
                    movieYearLabel.numberOfLines = 1
                    movieYearLabel.sizeToFit()

                    movieYearLabel.font = UIFont.systemFont(ofSize: 14)
                    movieYearLabel.frame.size = CGSize(width: movieYearLabel.intrinsicContentSize.width,height: movieYearLabel.intrinsicContentSize.height)
                    
                    movieYearLabel.leftAnchor.constraint(equalTo: horizontalContentView.leftAnchor).isActive = true
                    movieYearLabel.centerXAnchor.constraint(equalTo: horizontalContentView.centerXAnchor).isActive = true
                }
                
                func setupMovieGenreLabel() {
                    movieGenreLabel.translatesAutoresizingMaskIntoConstraints = false
                    
                    movieGenreLabel.numberOfLines = 1
                    movieGenreLabel.sizeToFit()

                    movieGenreLabel.font = UIFont.systemFont(ofSize: 14)
                    movieGenreLabel.frame.size = CGSize(width: movieGenreLabel.intrinsicContentSize.width,height: movieGenreLabel.intrinsicContentSize.height)
                    
                    movieGenreLabel.leftAnchor.constraint(equalTo: movieYearLabel.leftAnchor, constant: 5).isActive = true
                    movieGenreLabel.centerXAnchor.constraint(equalTo: horizontalContentView.centerXAnchor).isActive = true
                }
            }
            
        }
        
    }
    
    func confirugateViews() {
        
    }
    
    
}
