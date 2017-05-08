# Kandinsky

<p align="left">
<a href="https://travis-ci.org/mislavjavor/Kandinsky"><img src="https://travis-ci.org/mislavjavor/Kandinsky.svg?branch=master" alt="Build status" /></a>
<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift3-compatible-4BC51D.svg?style=flat" alt="Swift 3 compatible" /></a>
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage compatible" /></a>
<a href="https://cocoapods.org/pods/XLActionController"><img src="https://img.shields.io/cocoapods/v/Kandinsky.svg" alt="CocoaPods compatible" /></a>
<a href="https://raw.githubusercontent.com/mislavjavor/Kandinsky/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
</p>

Built by [Mislav Javor](http://mislavjavor.com).

Built with ❤️  &nbsp; at [Ingemark](http://www.ingemark.com) agency, Zagreb

## Introduction

Kandinsky is a Swift powered DSL for writing easy to merge,
readable and modular layouts. Write your layout in Swift instead of
storyboards.


## Features example

```swift
// Create a root UIView
k<UIView>().add { r in

    // Create a label in the center of the root UIView
    k<UILabel>.make {
        $0.id = "titleLabel"
        $0.view.text = "Welcome to Kandinsky" // Full UIKit support with the `view`
        $0.font = .systemFont(ofSize: 30)
        $0.centerInParent() // Generate in-place constraints
    }/r

    // Add button under titleLabel
    k<UIButton>.make {
        $0.id = "alertButton"
        $0.view.setTitle("Push me!", for: .normal)
        $0.under("titleLabel", offset: 30)
        $0.centerHorizontallyInParent()
    }/r

    // Declare variables in layout
    let viewAboveImagesID: String

    // Add views conditionally
    if hasAdminRights && isDevelopment {
        k<UIButton>.make {
            viewAboveImagesID = "loginAsAdminButton"
            $0.id = viewAboveImagesID
            $0.view.setTitle("Login as admin", for: .default)
            $0.under("titleLabel", offset: 30)
            $0.centerHorizontallyInParent()
        }/r
    } else {
        viewAboveImagesID = "alertButton"
    }

    k<UIView>.make {
        $0.id = "imageHolder"
        $0.alignParentLeadingAndTrailing()
        $0.under(viewAboveImagesID, offset: 20) // Use variables to affect layout
        $0.matchHeightToParent(dividedBy: 2)
        $0.alignParentBottom()}.add { n in

        // Use iteration in layout code
        images.forEach { image, offset in
            k<UIImageView>.make {
                $0.id = "bottomImg\(offset)"
                $0.view.src = image.srcImage
                if offset == 0 { // Conditional constraints
                    $0.alignParentLeading()
                } else if offset == (images.count - 1) {
                    $0.alignParentTrailing()
                } else {
                    $0.toLeftOfNextSibling()
                }
            }
        }

    }/r

}
```

## Requirements

* iOS 9.0+
* Xcode 8.0+

## Getting involved

* If you **want to contribute** please feel free to **submit pull requests**.
* If you **have a feature request** please **open an issue**.
* If you **found a bug** or **need help** please **check older issues, [FAQ](#faq) and threads on [StackOverflow](http://stackoverflow.com/questions/tagged/Kandinsky) (Tag 'Kandinsky') before submitting an issue.**.

Before contribute check the [CONTRIBUTING](https://github.com/mislavjavor/Kandinsky/blob/master/CONTRIBUTING.md) file for more info.

If you use **Kandinsky** in your app We would love to hear about it! Drop us a line on [twitter](https://twitter.com/mislavjavor).

## Examples

Follow these 3 steps to run Example project:
- Clone Kandinsky repository
- Open `Kandinsky.xcworkspace`
- Run the `Example` project

**OR**

- Open the `Example/Playground` and play around with live-preview

## Installation

#### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects.

To install Kandinsky, simply add the following line to your Podfile:

```ruby
pod 'Kandinsky', '~> 1.0'
```

#### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a simple, decentralized dependency manager for Cocoa.

To install Kandinsky, simply add the following line to your Cartfile:

```ogdl
github "mislavjavor/Kandinsky" ~> 1.0
```

## Author

* [Mislav Javor](https://github.com/mislavjavor) ([@mislavjavor](https://twitter.com/mislavjavor))


# Change Log

This can be found in the [CHANGELOG.md](CHANGELOG.md) file.
