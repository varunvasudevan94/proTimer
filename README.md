## ProTimer

A super dummy timer for chess  

Sincere thanks to my cousin Nand and my chess partner for motivation of this idea.
Now that we have this app we will only play **timed matches**, and stop pissing me with extremely slow moves.

## How to Use

Open https://protimer.herokuapp.com/index.html on fullscreen mode in your mobile browser.
I need to figure out some means to convert this into an android app but for now lets manage with this.

## Build and Deploy
1. Build the elm file to generate js  
    `elm make src/Main.elm`
2. Deploy the build into heroku (I have served with php to keep things simple)
    `git push heroku master`

## Elm
Created the project primarily to explore elm and write an end to end application using it.

Getting Started - https://guide.elm-lang.org/
I started by tweeking the clock example and finding why way to a MVP.

# Pros
1. Certain things which only functional language gives
2. Easy error messages
3. No runtime errors
4. Refactoring is easier (checkout my theory on functional language, how I try to refactor)
5. When there is a bug in your code you can say “there is nightmare on the elm street” :P
6. Fewer parentheses	

# Cons
1. Language felt overwhelming at beginning
2. Functional language is not intuitive to begin with
3. JSX is easy to grasp
4. I am spoilt with React :( (not a bad con though)


