//
//  ViewController.swift
//  ScrollViewImplement
//
//  Created by Mehedi on 2/14/20.
//  Copyright © 2020 MatrixSolution. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {
    static let id = "ScrollViewController"

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var slides:[Slide] = [];
       
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        slides = createSlides()
        setupSlideScrollView(slides: slides)

        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }
    


}

extension ScrollViewController{
    
    
    func createSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed(Slide.id, owner: self, options: nil)?.first as! Slide
        slide1.imageForSlideImageView.image = UIImage(named: "pic1")
        slide1.titleForSlideLabel.text = "A real-life bear 1"
        slide1.descriptionForSlideLabel.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        let slide2:Slide = Bundle.main.loadNibNamed(Slide.id, owner: self, options: nil)?.first as! Slide
        slide2.imageForSlideImageView.image = UIImage(named: "pic2")
        slide2.titleForSlideLabel.text = "A real-life bear 2"
        slide2.descriptionForSlideLabel.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        let slide3:Slide = Bundle.main.loadNibNamed(Slide.id, owner: self, options: nil)?.first as! Slide
        slide3.imageForSlideImageView.image = UIImage(named: "pic3")
        slide3.titleForSlideLabel.text = "A real-life bear 3"
        slide3.descriptionForSlideLabel.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        let slide4:Slide = Bundle.main.loadNibNamed(Slide.id, owner: self, options: nil)?.first as! Slide
        slide4.imageForSlideImageView.image = UIImage(named: "pic4")
        slide4.titleForSlideLabel.text = "A real-life bear 4"
        slide4.descriptionForSlideLabel.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        
        let slide5:Slide = Bundle.main.loadNibNamed(Slide.id, owner: self, options: nil)?.first as! Slide
        slide5.imageForSlideImageView.image = UIImage(named: "pic5")
        slide5.titleForSlideLabel.text = "A real-life bear 5"
        slide5.descriptionForSlideLabel.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
            pageControl.currentPage = Int(pageIndex)
            
            let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
   
            let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
       
            let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
    
            let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
            
            let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
            let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
            
            
            /*
             * below code changes the background color of view on paging the scrollview
             */
    //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
            
        
            /*
             * below code scales the imageview on paging the scrollview
             */
            let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        // Total pair is 4 and so 1 / 4 = 0.25
            
            if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
                
                slides[0].imageForSlideImageView.transform = CGAffineTransform(scaleX: (0.25 - percentOffset.x) / 0.25, y: (0.25 - percentOffset.x) / 0.25)
                slides[1].imageForSlideImageView.transform = CGAffineTransform(scaleX: percentOffset.x / 0.25, y: percentOffset.x / 0.25)
                
            } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
                slides[1].imageForSlideImageView.transform = CGAffineTransform(scaleX: (0.50 - percentOffset.x) / 0.25, y: (0.50 - percentOffset.x) / 0.25)
                slides[2].imageForSlideImageView.transform = CGAffineTransform(scaleX: percentOffset.x / 0.50, y: percentOffset.x / 0.50)
                
            } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
                slides[2].imageForSlideImageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x) / 0.25, y: (0.75 - percentOffset.x) / 0.25)
                slides[3].imageForSlideImageView.transform = CGAffineTransform(scaleX: percentOffset.x / 0.75, y: percentOffset.x / 0.75)
                
            } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
                slides[3].imageForSlideImageView.transform = CGAffineTransform(scaleX: (1 - percentOffset.x) / 0.25, y: (1 - percentOffset.x) / 0.25)
                slides[4].imageForSlideImageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
            }
        }
}

