
# Explanation


## Architecture

I've decided to implement state architecture based on reactive streams using combine and MVVM pattern and using Swinject for DI.

Here in application we have State object which has input and output. Any component that needs to get data from the state must get the state singleton from DI container and subscribe to the output, and send messages to the input for mutating the state.
All businnes logic implemented in Service that own the state, it can receive actions, do some work, combinig reactive streams from another states if neccesery and return updated state.

This architecture is easy to test and maintain. Also it can be easily moved to a separate module.
