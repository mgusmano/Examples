import UIKit

class OnboardingPager: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        view.backgroundColor = .darkGray
        setViewControllers([getStepZero()], direction: .forward, animated: false, completion: nil)
    }
    
    func getStepZero() -> StepZero {
        return storyboard!.instantiateViewController(withIdentifier: "StepZero") as! StepZero
    }
    
    func getStepOne() -> StepOne {
        return storyboard!.instantiateViewController(withIdentifier: "StepOne") as! StepOne
    }
    
    func getStepTwo() -> StepTwo {
        return storyboard!.instantiateViewController(withIdentifier: "StepTwo") as! StepTwo
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UIPageViewControllerDataSource methods

extension OnboardingPager : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: StepTwo.self) {
            // 2 -> 1
            return getStepOne()
        } else if viewController.isKind(of: StepOne.self) {
            // 1 -> 0
            return getStepZero()
        } else {
            // 0 -> end of the road
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: StepZero.self) {
            // 0 -> 1
            return getStepOne()
        } else if viewController.isKind(of: StepOne.self) {
            // 1 -> 2
            return getStepTwo()
        } else {
            // 2 -> end of the road
            return nil
        }
    }
    
    // Enables pagination dots
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    // This only gets called once, when setViewControllers is called
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

// MARK: - UIPageViewControllerDelegate methods

extension OnboardingPager : UIPageViewControllerDelegate {
    
}
