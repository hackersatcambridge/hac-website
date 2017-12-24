import HaCTML

// swiftlint:disable line_length

struct IndividualWorkshopPage {
  var node: Node {
    return Page(
      title: "Hackers at Cambridge",
      content: Fragment(
        hero, // A big beautiful header
        description, // Who, What, Why
        content // The content of the workshop
      )
    ).node
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
        Content goes here

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

        ...
      """)
    )
  }
}
