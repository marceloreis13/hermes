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
I spend a little over `4 hours` since I wasted some time trying to understand how the GitHub api worked (seems this challenge are using a new version and I was not able to find enough information on google), so unfortunately I was not able to finish the challenge as I wished.

### Evidences
![Simulator Screen Shot - iPhone 13 mini - 2022-04-29 at 20 35 42](https://user-images.githubusercontent.com/3719474/166080874-f2e301f8-b00b-42eb-b74f-42964271fe2b.png)

