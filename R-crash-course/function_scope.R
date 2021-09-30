# Local scopes

# NB - Try `.Last.value` if the result appears to be missing

globally_scoped_variables_are_inherited <- function() {
    x = x^2  # This will be confusing
    # Right-hand side inherited x from global scope
    # --- call this global::x
    # Left-hand side creates a local variable 'x'
    # --- call this globally_scoped_variables_are_inherited::x
    # They are different values!
    # As a thought exercise:
    # -- Locally, what would x == x mean? Could a comparison to global::x even be made?
}

x = 2
local_values_can_mask_global_values <- function() {
    x = "$100"  # This is totally unrelated to the global 'x'!
}

better_to_pass_explicitly <- function(x) {
    x = x^2
    # x was computed locally
    # BUT this doesn't update the global value!
}

the_last_result_is_returned <- function(arg) {
    x = arg^2
    print("I'm glad this calculation is complete!")
    # `print` returned a value ... that's what got returned!
}

explicit_return_is_better_than_implicit <- function(arg) {
    x = arg^2
    print("I'm glad this calculation is complete - let me handle the result carefully!")
    # Explicitly define what should be returned
    return(x)
}

