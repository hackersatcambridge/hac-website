import HaCTML

// swiftlint:disable line_length

struct WorkshopPage {
  var node: Node {
    return UI.Pages.base(
      title: "Hackers at Cambridge",
      content: Fragment(
        hero, // A big beautiful header
        description, // Who, What, Why
        content // The content of the workshop
      )
    )
  }

  var hero: Node {
    return El.Div[Attr.className => "WorkshopHero"].containing(
      "Hero goes here (similar to landing hero)"
    )
  }

  var description: Node {
    return El.Div[Attr.className => "WorkshopDescription"].containing(
      El.H1[Attr.className => "WorkshopDescription__title"].containing("Intro to Swift"),
      Markdown("""
        If you work with code or data then being comfortable with the command line is essential to your productivity. This workshop will explain and demonstrate the usefulness of the UNIX* shell, Bash.
        We’ll take you through the basics and then show you many useful commands for day-to-day tasks and how to chain commands together using *pipes* and *redirects* (and explain what they are!).

        In particular we will cover:
        - Basic syntax of a Bash command
        - How to find out what commands mean with `man`
        - Navigating the filesystem with `ls` and `cd`
        - Writing to the filesystem with `touch`, `rm`, `mkdir`, `nano`
        - How to get out of a hanging program with ctrl + C
        - How to chain commands togather using _pipes_ (`|`) and _redirects_ (`>>`)

        *although Bash is a UNIX/POSIX/Linux/macOS thing, it's still something that can come incredibly in handy even on windows!
      """),
      El.Div[Attr.className => "WorkshopDescription__prerequisites"].containing(
        El.H1[Attr.className => "Text--sectionHeading"].containing("Prerequisites"),
        Markdown("""
          - Basic programing experience
          - Basic familiarity with the command line
        """)
      ),
      El.Div[Attr.className => "WorkshopDescription__whoFor"].containing(
        El.H1[Attr.className => "Text--sectionHeading"].containing("Who it's for"),
        Markdown("""
          This is for you if you:
          - Are starting to learn how to program
          - Are an expert programmer that has never used the command line
          - Aren’t convinced that the command line is useful
          - Haven't written code but want to learn the best tools for the job
        """)
      ),
      El.Div[Attr.className => "WorkshopDescription__setUp"].containing(
        El.H1[Attr.className => "Text--sectionHeading"].containing("Set up instructions"),
        Markdown("""
          Please make sure you have Swift and Git installed.
          Insert more details here
        """)
      )
    )
  }

  var content: Node {
    return El.Div[Attr.className => "WorkshopContent"].containing(
      El.Div[Attr.className => "BigButton"].containing(
        "View code examples on GitHub"
      ),
      Markdown("""
        Welcome!

        Snake Game
        ===
        ## **Learning aims**
        * Make you confortable with following simple installation instructions 
        * Apply basic programming concepts: variables, `if` statements, `for` loops
        * Understand and interact with helper functions, ready-made code
        * Introduce **events** & **keycodes** 
        * Working with **matrices** 
        * Your first view of the world of games :) 

        ## ***An overview of what is already in the code**
        _If you're confortable with figuring out what the helper code does on your own, you can skip this bit._

        * We have some notion of how we are going to start off this game. In this simple implementation, we'll be modelling the snake game by a 8x8 matrix. **What is a matrix?** Simply put, just an array of arrays, all of the same size. That means, an array `playMatrix` containing 8 arrays, each with 8 elements of their own. This gives us 64 little cells where our snake can run freely (_obviously without biting its tail_)  

        ```js
        /* How the state will be started initially */
        getInitialState(){
            const initialState = {
              playMatrix: [
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
              ],
              snake: [],
              currentDirection: 'up',
              isGameActive: false,
            }
            return initialState;
          }
        ```
        * Our snake starts off in the 'up' direction, we could have chosen any other one. (_The ones I've defined here are `'up'`, `'down'`, `'left`, `'right'` but you can very well name yours whatever, as long as you're consistent - i.e whenever you use them you make sure you know what each name stands for)_

        * Pay close attention to the snake array. What should it be when it starts having values? Ideally, we'd like it to contain **positions**. How will these positions look? They should be just plain **objects** with `row` and `col` properties, to mimic matrix cells, which generally look like `playMatrix[row][col]`. More on this later. 

        * We also have a notion of whetver or not we're actually playing the game, which makes sense in the context of displaying the `Start` button or not. This behaviour is exhibited in the code below: 
        ```js
        renderSnakeGame(){
            if(this.state.isGameActive)
              return this.drawSnakeGame()
            else 
              return <button className="Button" onClick={()=>this.startGame()}>Start</button>
          }
        ```

        And our `drawSnakeGame` looks pretty much like this: 
        ```js
        drawSnakeGame(){
            function getCellClass(cell){
              switch(cell){
                case 0: return 'cell_0';
                case 1: return 'cell_1';
                case 2: return 'cell_2';
                default: return 'cell_0';
              }
            }
            return <div className="Snek_Matrix">
              {this.state.playMatrix.map(row => <div className="Snek_Matrix_Row" >
                {row.map(cell => <div className={"Snek_Matrix_Cell " + getCellClass(cell)}/>)}
                </div>)}
            </div>
          }
        ```

        * The classic helper functions, to get and update the stored values that you saw in `getInitialState()`: 
        ```js
         // Returns the current direction of the snake 
          getCurrentDirection(){
            return this.state.currentDirection;
          }
          
          // Returns the stored snake
          getLocalSnake(){
            return this.state.snake;
          }

          // Returns the stored play matrix value at (row,col) position
          getLocalPlayMatrixValue(row, col){
            return this.state.playMatrix[row][col];
          }
          
          // Updates the snake array with the values in newSnake array
          updateSnakeBody(newSnake){    
            this.setState({snake: newSnake});
          }

          // Updates the current direction of the snake 
          updateSnakeDirection(newDirection){
            this.setState({currentDirection: newDirection});
          }
        ```

        ## **Tasks and Instructions**

        Write the JavaScript code to: 

        ### 1. Make sure our game starts when we press the `Start` button 
           
        * Pressing the Start Button fires up the `this.startGame()` function: 
        ```js
        <button className="Button" onClick={()=>this.startGame()}>Start</button>
        ```
        **Explanation:** Right now all it does is alert you that the game has started, but nothing is really happening. That is because we need to tell our program as well that the game has started. How do we go about that? 

        -> We have a stored `isGameActive` variable which you may notice is set to `false` initially. We want to make sure this is set to true when the game is active. The code contains a helper function that you might want to use: `isPlaying(playing)` takes a `boolean` value as input and assigns it to `isGameActive`. Remember we call these functions with `this.isPlaying(...)`

        **Checkpoint:** This is good. We can now see an 8x8 matrix. It's grey, beautiful. You can leave it like this and be happy or move on and see the snake shaping up. 

        ### 2. Make our snake show up on the playing matrix 
        * Considering we have a `playingMatrix` represented as before, we want to tell our program that the snake should appear at first as a single cell, somewhere on the matrix: 
        ```js
         playMatrix: [
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            ]
        ```
        [**Let's take a small detour**]

        I have tried to make this as enjoyable as possible, you can skip the following and still safely complete the workshop, but I feel this provides a better understanding of what you are working with (_We need to understand how to play around with arrays of arrays a bit_):

        * What does this translate to? Simply put, our `playMatrix` is an array or arrays. If you remember our introductory sessions, we saw ways to get at some of the values stored in arrays of arrays. An example would be:
        ```js
        var arr = [[4,9],['cat','dog'],'Hacker'];
        // Remember in arrays indexes start from 0
        // I want to retrieve Hacker
        console.log(arr[2]);

        // Now I want the number 9 stored in arr
        // I will therefore go into the first element (index 0) -> arr[0]
        // And then get its second element (index 1) -> arr[0][1]
        console.log(arr[0][1]);

        // The same thing could have been done with the following code: 
        var first = arr[0];
        console.log(first[1]);

        // We just did it in one run because it looks cooler and it's more efficient
         ```

        * Let's walk through _(i.e look at all the values of)_ a whole matrix. How would you do that? Remember we used a `for` loop to walk through a normal array. We're going to just develop on that. Below is an example: 
        ```js
        var arr = [0,0,0,0];
        for(var i = 0; i < arr.length; i++){
            console.log(arr[i]);
        }

        // We can use the same principle when walking through arrays of arrays. 

        var matrix = [['00','01'],['10','11']];
        // If it's easier, you can view it as: 
        /* Looks a bit more like a matrix
        [[ '00' , '01'],
         [ '10' , '11']]
        */
        for(var row = 0; row < matrix.length; row++){
            for(var col = 0; col < matrix.length; col++){
                console.log(matrix[row][col]);
            }
        } 

        // Do this in the console or anywhere you want to
        // Make sure you have an intuition of what order they should be printed in :)
        ``` 
        [**Detour over**]

        * We will **differentiate the snake from the rest of the matrix** by giving it a distinctive value. You can choose 1 for now. `playMatrix` will then look something like: 
        ```js
        playMatrix: [
            [1,0,0,0,0,0,0,0], // This means our little snek starts off at position (0,0)
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0],
            ]
        ```

        **DISCLAIMER:** I'm going to be assuming throughout this workshop that, looking at `playMatrix` -> `0` means nothing there, `1` means there is snek there, `2` means there is food there.

        * **Method:** Implement `initializeSnake()`. You should call this immediately after you've done the previous step, in the same `startGame()` function. You want to call `this.setSnake(...)` which is a helper function that takes **an array of positions** which our snake spans and updates the game matrix for us. A `position` object has a `row` and a `col` property. 
        ```js
        var position = {
            row: ...,
            col: ...
        }
        ``` 

        * For this particular step, we are only going to be sending across an array with one position, which is the `initialPosition`.  

        **Checkpoint:** You should now be able to see one cell colored blue and the rest of them still grey. The blue cell is your snake. Isn't it pretty?

        ### 3. Make our snake show up on random places on the playing matrix every time we restart the game 

        * With what we have so far, whenever we press `Start` our snake stays at the same position, which is a set one you've probably **hard-coded** _(i.e manually introduced a value for, with no variable)_. Ideally, we would like our snake to turn up at **random** places on our game matrix. 

        * Implement a function called `getRandomNumber(lowerBound, upperBound)` which takes in a lower bound and an upper bound and returns a random value contained between those. 

        * You may find the following useful: [Math.random()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random) JavaScript built-in functionality _(`.random()` is also built-in in most, if not all new-ish languages)_
        **Warning:** make sure the number is an integer. Also keep in mind that we're working with an 8x8 matrix _(array of 8 arrays each containing 8 values)_ indexing, which means `0` up to `7` are valid entries for indexing into the matrix. If you're really stuck, have a look at the [Hint 1](#1)

        * Now that you have this function, go ahead and **call it** to get random values every time for your initial row and column position. 

        * At this point, you may want to also implement `restartGame()`. Esentially, when we restart the game we want to make our snake tiny again and place it at a _random_ starting position. It therefore suffices to call `initializeSnake()` from within `restartGame`.

        **Checkpoint:** Now, whenever you press `Start` or `Restart`, our snake should be in a different spot on the matrix. A bit more realistic. 

        ### 4. Make snakey move 

        * Here comes the fun bit. We want our snake to actually move around, eat food, etc. To move, it means it will **change position**. So we need to update the positions the snake spans, at each time step of the game. 

        **Some code to copy and paste** into `startGame()`, after the previous step.  
        ```js
        // This is very important, we are now saying: OK, `this` is the only
        // relevant Object you care about, and we assign its contents to the 
        // variable thisSnek. We will work with thisSnek whenever we want to perform
        // actions directly on the snek Object 
        var thisSnek = this;    
        var timer = this.createSnakeTimer(thisSnek,500);
        ```
        **Explanation:** These steps are modelled by a timer: `createSnakeTimer(snakeObject,timeInterval)` which takes a snake object `var thisSnek = this` and a time interval _(measured in ms, so a `var timeInterval = 1000` would mean 1 second)_ and returns a timer object. The timer object is defined at the very bottom of `Snek.js` and has 3 main methods: `stop`, `start` and `reset`. I will define each when/if we need to make use of them.  

        **Checkpoint:** If you've added this timer, we should see our snake move upwards. _To infinity and beyond_ 

        * Our timer is **correlated with** our `moveSnake` function, which takes this timer as its input and makes incremental changes to the snake game at every time step (_or `tick` of a clock, where the tick length is equal to the `timeInterval`, if you prefer that explanation_). 

        * `moveSnake(timer)` is currently only allowing the snake to move in an upwards direction. Take a moment to read through what is there already and understand what's going on. The basic idea is the following: We want to see where the head of the snake is and, knowing which direction it is currently going in, we'll be able to update the coordinates _(i.e new `(row,col)` position)_ of our snake's body. 

        * Also notice that I've already written out the conditional for the `'up'` direction. If we're going up, that means on a matrix, the row index would be decreasing and the column index would be staying the same. If we've hit a margin, we would like to still stay within the matrix, so our only choice is to loop around, like I've done, or `timer.stop()`, which would bring our snake at a stand-still.  

            _**Caveat:** Our code only requires an `if` at these points, and not a while, because the `while`, so to speak, is already the timer itself. In other words, `moveSnake` is called indefinitely, until the timer is stopped or reset._

        * That's nice, but how about moving `'left'`, `'right'`, `'down'`? Please implement these now :) 

        **Checkpoint:** Your snake should still be moving only in an upwards direction, indefinitely, but now you are making sure you take every movement into consideration, which is what we want. 

        _Let's move on and make the snake switch directions._
        ### 5. Make snake move according to keyboard presses

        * When we play a game on our computer we'll most often be using our keyboard, mouse or a combination of the two. _Alternatively, use a console or any other funky device._ Anything of the sort has some `keyCodes`. What that means is that every key on your keyboard has a certain code attributed to it. Please play around a bit: JavaScript [keyCodes](http://keycode.info/)

        * We're going to use these key codes to recognize what our user is pressing and move accordingly. For this, you'll want to complete the `actOnKeyPresses(thisSnek)` function, which takes the current snake object and calls the corresponding methods on it. In this particular case, you may find the helper function `thisSnek.updateSnakeDirection(...)` which takes a direction as input _( one of: `'up'`,`'left'`, `'right'`, `'down'`)_ and updates the current snake's direction

        * **Warning:** Make sure you're either looping around or stopping the timer. Otherwise, modifying the row or column indefinitely will make it difficult to index into the game matrix (i.e in JavaScript, will just say `undefined`)

        * Once you're done implementing this function (or even a bit of it) try it out by calling it at the bottom of our `startGame()` function. Yes, that is our **MAIN** function ;) 

        * _Optional_: If you're feeling funky, you can account for W,A,S,D controls as well

        **Checkpoint:** This is great! If you have correctly implemented `moveSnake` conditionals and catered for any key presses, our snake should now be moving in different directions according to key presses. 

        ### 6. Make food for our snake 

        * Our snake is a bit tiny, and hungry. Let's make some food for it. I've said above that our snake body is going to be modelled by the number `1` and the food is going to be the number `2` in our game matrix. We want to just shove a `2` at a random position on the matrix. You've made the random number generator function, hopefully, if not, feel free to use mine at this point: [getRandomInt](#1). 

        * We'll be implementing the `addFood` function at this point. You want to make sure you have the following: `row` and `col` indexes for your food. We will need these to make sure our food cell is not overlapping with our snake and also to actually add the food element to the matrix. We can check for overlap with: `getLocalPlayMatrixValue(row, col)` which gives us the value of `playMatrix` at (row,col) - _`0` if nothing is there, `1` if there is some snek there, `2` for food_

        * You can use the `addFoodToMatrix(foodPosition)` helper function, which takes, as before, a position object as an input, which has `'row'` and `'col'` keys.     

        * Go ahead and call `addFood` inside _(yes, you guessed it)_ `startGame`, exactly after `this.initializeSnake()` 

        **Checkpoint:** We should now be able to see the snake moving in all directions and also some red food popping up on the matrix. However, neither did out snake grow, nor did we make any extra food if our snake "ate" the existing food. **We need more!**

        ### 7. Make snake grow when he eats food

        * For this functionality, we need to think carefully about how `localSnake` is updated in `moveSnake`:
            ```js
            // Place it at the end of our snake positions array
            localSnake.push(headPosition);
            // Eliminate the tail of the snake (otherwise it would eventually fill up all positions)
            // .shift() eliminates the first element of an array 
            localSnake.shift();

            this.setSnake(localSnake);
            ```

        * We can see that we `.shift()` our array, as I previously explained. What this is doing is it's basically assuming we've not hit any food and just carrying on casually with 1 block only _(as we're always pushing 1 value in at the end, taking 1 value out from the beginning)_. 

        * Therefore, if we want our snake to grow, we just have to specify that if the position at which the snake head is going to be at coincides with a position where we have some food (_how do you check if you're got some food at a position?_) then we **don't want to `.shift()`**. For getting the value of our playMatrix at a position you can make use again of `getLocalPlayMatrixValue(row, col)`. The 3 possible values are: `0`, `1`, `2`.

        **Checkpoint:** At this point, our snake should grow, but basically only by 1 cell, so you should see a 2-celled snakey moving around, looking for some food that is not reappearing. :( You're both happy and sad now. 

        ### 8. Make food reappear

        * We're not done with modifying `moveSnake`. If you've correctly implemented the previous steps, you can now safely use `this.addFood()` when you decide not to shift the snake. (_i.e when your snake's next head position coincides with a position where you've got some food_)

        **Checkpoint:** Now you should have a happy snake, which will keep getting more food as it eats the previous food and keep growing while doing so. 

        * We've introduced a tiny problem here! If, by accident, we spawned our snake at the same position as we spawned our while randomly pressing `Reset` then our snake would not grow and no food would be added. We can take care or this by modifying `restartGame` a bit. Make good use of the existing: `clearPlayMatrix()` function or just clear it manually, if you feel like a challenge. _(For the second option, you will need the detour from Step 2 above)_

        ### 9. Implement game over

        * The snake will keep growing but... it doesn't stop at any point. We've got the very last step here. We have to implement the game over functionality. 

        _2 Main Issues:_
        * **(i) When do we consider the game to be over?** 
            
            * There is no set way of doing this. Some people might also include hitting the walls or some extra objects as a game stopper. Let's implement the most straightforward one, which everyone agrees on: **the snake bites its tail**

            * What does this mean in code terms? In our case, if the snake's head next position coincides with **any** position spanned by our snake already _(you can get a list of these with `this.getLocalSnake()`)_, then it kind of means the snake if going to bite its tail, so we might as well announce game over 

        * **(ii) What do we want to do when these conditions are satisfied?**
            
            * We should definitely stop the timer. 

            * Try alerting the user that they've lost? 

            * We might also want to give the player the option of going back to the `Start` button -> You can do that by calling the helper function `this.resetInitialState()`
            
            * Preferably break out of any potential loop we might be in.
            

        **Checkpoint:** You just have to make sure you've puzzled everything together nicely and you should now have a fully functional 8x8 snake game! Congratulations for sticking with it.

        ## **What's next?**
        ### _Snake Game functionality extension possibilities:_

        * Feel free to extend the game from an 8x8 matrix to a bigger matrix, or even a user-defined lengthed one. 

        * Keep a score count and display it at the end, along with the `Game Over` alert.

        * Add obstacles (_can model them with 3's on the matrix, etc_) 

        ### _Other games with `JavaScript` and `React`_
        In case you're found this nice.
        * https://react.rocks/tag/Game

        * https://developer.mozilla.org/en-US/docs/Games/Tutorials

        * https://medium.com/@VadimBrodsky/javascript-game-development-where-to-start-5bdc097cbd6e

        ### _Game development in general_ 
        In case you particularly liked thinking about the little edge cases and the snake movement, game development may be for you :) Below are some extra resources: 

        * http://www.gamefromscratch.com/post/2011/08/04/I-want-to-be-a-game-developer.aspx

        * https://github.com/petehouston/awesome-gamedev-series

        * More advanced: https://github.com/Kavex/GameDev-Resources
        ## **Hints**:
        #### 1 
        ```js
        getRandomInt(min, max){
            min = Math.ceil(min);
            max = Math.floor(max);
            return Math.floor(Math.random() * (max - min)) + min; //The maximum is exclusive and the minimum is inclusive
        }

        ...

            row: this.getRandomInt(0,8)
        ```
      """)
    )
  }
}
