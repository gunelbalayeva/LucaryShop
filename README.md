# LucaryShop
### Start date: June 7, 2025
# Lucary – Bringing the Magic of Art to Your Mobile Device

**Lucary** is a unique e-commerce iOS application that brings the world of art and creativity right to your fingertips.  
Handmade goods, decorative items, original artworks, and much more — **now just a tap away!**

---
##  App Preview

<p align="center">
  <img src="LucaryShop/Lucary" alt="Lucary Shop" width="270"/>
</p>

## About the Project

**Lucary** is an iOS mobile platform specially designed for artists, designers, and creative minds.  
Our mission is to **connect creators with a wider audience**, and provide users with **authentic, high-quality handcrafted products made with love and care**.

With Lucary, users can:  
- Discover unique handmade creations from local artists  
- Seamlessly browse product categories and search for desired items  
- Add favorites and easily manage their shopping cart  
- Enjoy smooth navigation with an intuitive, modern UI/UX  
- Experience multilingual support with dynamic localization  
- Track and manage orders effortlessly  

> **Lucary – Feel the art in every touch.**

---

## Technologies Used

- **UIKit Framework** (`UIViewController`, `UICollectionView`, `UISearchBar`, `UITableView` etc.)  
- **SnapKit** — for declarative, readable AutoLayout constraints  
- **Combine Framework** — reactive programming for data binding and event handling  
- **MVVM (Model-View-ViewModel)** Design Pattern — clean separation of concerns  
- **Coordinator Pattern** — modular and manageable navigation flow  
- **Builder Pattern** — scalable UI component assembly  
- **Networking & API Services** (Alamofire / URLSession)  
- **UICollectionViewDiffableDataSource** — modern, efficient collection view data management  
- **NotificationCenter** — for broadcasting events and app-wide updates  
- **Localization & Multilingual Support**  
- **Memory Management** best practices  
- **UIPageViewController** — onboarding and tutorial flows  
- **Custom Fonts & Animations** (including Lottie animations)  
- **Video Handling & MapKit Integration**  
- **Dependency Injection & Clean Architecture** — maintainable and testable codebase  
- **Utility Extensions** on UIView, UILabel, UIImageView (Kingfisher), String, Combine, UIStackView, UIViewController  
- **Custom UI Components** — buttons, popups, message cards  
- **Custom Animated Success & Error Popup Views** — visually appealing feedback messages  

---

## Features

- **Authentication Flow**: Login, Register, Forgot Password, OTP Verification, Edit Profile, Logout  
- **Splash Screen & Onboarding Flow**: Engaging intro screens with smooth animations  
- **Home Screen**: Dynamic product lists, category browsing, featured products  
- **Search**: Powerful, reactive search bar for filtering products  
- **Favorites & Cart Management**: Add/remove favorites, cart updates with real-time feedback  
- **Profile Management**: User info, order history, preferences  
- **Orders Tracking**: Place, view, and manage orders easily  
- **About & Terms Screens**: Informational pages with localization support  
- **Reusable Components & Modular Architecture**: Easily maintainable and extensible code  
- **Multilingual UI**: Switch languages dynamically with smooth UI updates  

---

## Architecture

- **MVVM + Coordinator + Builder Pattern** for clean, scalable, and testable code  
- Modular navigation using **Coordinator Pattern**  
- Reactive UI updates with **Combine**  
- API calls handled by dedicated service classes with proper error handling  
- Extensive use of **Swift Extensions** to keep code DRY and maintainable  

---

## Project Structure Highlights

- **Services**: `ProductService`, `CategoryService`, `CompanyService`, `CartService`, `FavoritesService`, `OrderService`  
- **Coordinators**: `AppCoordinator`, `MainTabBarCoordinator`, `HomeCoordinator`, `ProductDetailCoordinator`, etc.  
- **ViewModels**: For all main screens with business logic and data binding  
- **Views**: Custom UIViews and UIKit controllers, including animated popups and custom buttons  
- **Utilities**: `InputSanitizer`, localization helpers, UI extensions  
- **Animations**: Lottie integration for success/error feedback  

---

## Contribution

Contributions are welcome! Please open issues or pull requests for improvements, bug fixes, or new features.

---

## About the Project

**Lucary** is an iOS mobile platform specially designed for artists, designers, and creative minds.  
Our mission is to **connect creators with a wider audience**, and provide users with **authentic, high-quality handcrafted products made with love and care**.

>  **This project was developed as the final project for ATL Academy’s iOS Developer Course.**

---

## License

This project is licensed under the MIT License.


---

**Thank you for checking out Lucary! Feel free to explore, contribute, and enjoy the magic of art at your fingertips.**

