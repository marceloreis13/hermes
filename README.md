### What was done
- [x] Initial launch: fetch the initial set of repos that contain the string graphql
- [x] Display the result of each repository returned from the query
- [x] Infinite scrolling - when reaching the bottom of the currently loaded dataset, the query should continue from the last point
- [x] Error handling - let the user know when an error happens
- [x] MVVM architecture

### What would I do if I had more time
- Avoid [magic numbers](https://ashley-oldham.medium.com/avoiding-magic-numbers-7f2721b20402)
- Create a search field
- Create UnitTests
- Support/Test layout on all possible devices

### What was my approach and why
In this challenge I used SwiftUI since I'm currently working 100% on my projects, so naturally would be more comfortable with that. Regarding libs, I believe wasn't necessary to import/use any, as all elements, services and extensions were simple and fast to implement, otherwise I would import without a doubt.

### How many time 
I spent a little over `4 hours` to complete all mandatory requirements, and less than `1 hour` to finish all that was delivered (including the tests).

### Evidences
| Normal Case   |      Stressed Case |  Error Case
|:----------:|:-------------:|:-------------:|
| ![Simulator Screen Shot - iPhone 13 mini - 2022-04-30 at 08 48 18](https://user-images.githubusercontent.com/3719474/166104237-eb922077-90e5-4391-9b1f-a9b6421f54bb.png) | ![Simulator Screen Shot - iPhone 13 mini - 2022-04-30 at 08 52 35](https://user-images.githubusercontent.com/3719474/166104469-d7b7d232-b06e-41c4-8c7c-de45ec58b7de.png) | ![Simulator Screen Shot - iPhone 13 mini - 2022-04-30 at 09 01 40](https://user-images.githubusercontent.com/3719474/166104678-9e34c1d7-9d7b-487f-9c77-0b2e63cd83ee.png) |
