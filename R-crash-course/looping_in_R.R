# Set up some demonstration functions
func1 <- function(arg1, arg2) {
    formatted_print(c("From function 1: ", arg1, " was ", arg2))
}
func2 <- function(arg1, arg2) {
    formatted_print(c("From function 2: ", arg1, " was ", arg2))
}

# Create a helper function - R's standard print statement can be cumbersome
formatted_print <- function(arg) {
    if(length(arg) > 1) {
        print(paste(arg, collapse = ''))
    } else {
        print(arg)
    }
}

run_if_else <- function() {
    # Use `if`/`then` to control how a function flows
    # And use `for` to iterate over a variable
    for(i in 1:10) {  # The `1:10` notation is both a range and a vector
        formatted_print(c("Looping over iteration: ", i))
        if(i %% 2 == 1) {
            # This is an odd number
            func1(i, "odd")
        } else if(i %% 2 == 0) {
            # This is an even number (or zero)
            func2(i, "even")
        } else {
            stop("This number wasn't even or odd. How did that happen?")
        }
    }
}

# Give this function a reasonable default value
fizz_buzz <- function(arg = 15) {
    # Fizz-buzz is an often-used programming execrcise. Given a sequence of numbers,
    # how succinctly can code be written to replace multiples of 3 with 'fizz',
    # multiples of 5 with 'buzz', and multiples of both with 'fizzbuzz'

    for(i in 1:arg) {
        # Make an empty string to start with
        result = ""
        # Set a 'new state' flag
        new_state = FALSE
        if(i %% 3 == 0) {
            result = paste0("fizz", result)
            new_state = TRUE
        }
        if(i %% 5 == 0) {
            result = paste0(result, "buzz")
            new_state = TRUE
        }
        # Rather than build composite conditionals (ie `if(i %% 3 == 0 & i %% 5 == 0) {blah} ),
        # build a string stepwise and track if the state of the result has changed
        if(!new_state) {
            # Use next to skip to the next iteration while skipping the output
            formatted_print(c(i, ": There's no fizz-buzz action :("))
            next
        }
        formatted_print(c(rep('-', 10), " ", i, ": ", result, " ", rep('-', 10)))
    }
}

show_squares <- function(arg) {
    # Use a `while` loop to iterate over the next 3 integers over a 
    # numeric argument. Use the integer portion and loop over three iterations
    # Add a type-checker using if/then and stopifnot()
    # --- Why add type-checking?
    if(!is.integer(arg)) {
        if(is.numeric(arg)) {
            arg = as.integer(arg)
        } else {
            # Perform some simple error handling and exit gracefully
            formatted_print(c(" ----> Received input arg '", arg, "'"))
            stop("`show_squares` requires a numeric input. Halting")
        }
    }
    # The value in arg should now be *guaranteed* to be an integer. Stop if not
    # NB - This doesn't affect the value of `arg` passed in to this function
    stopifnot(is.integer(arg))
    iterator = arg  # Clarify code by giving the variable a descriptive name
    iterator_stop = iterator + 3
    while(iterator < iterator_stop) {
        formatted_print(c("The square of ", iterator, " is ", iterator ^ 2))
        iterator = iterator + 1
    }
}

# NOTE: arg2 has been given a default value
# This is used to determine whether show_squares should be run
run_switch_case <- function(arg, arg2 = NULL) {
    # Use `switch` to guide the flow of execution
    switch(arg,
        # Note that functions can be returned just like variables!
        ifthen = run_if_else(),
        squares = ifelse(
            # Multiline entry is OK, and helps readability!
            !is.null(arg2),
            # Coerce a return value
            # -- Try uncommenting line 102 (and "commenting out" line 103) to see what happens...
            # show_squares(arg2),
            return(show_squares(arg2)),
            return("I cannot show squares of user entry without an extra argument!")
            ),
        test = print("Test of running switch statement confirmed!"),
        return("Unknown case, defaulting to no action")
        # NB - This statement can also be a 'stop', ie:
        # stop("Unknown case -- ABORTING")
        # Abort if the error is fatal, issue warnings if execution may proceed, etc.
        )
}