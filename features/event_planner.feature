Feature: Person signs up as an event planner
    If someone wants to use Ride Bum to manage their event's carpools
    They need to create an account
    And log in

   Scenario: Sign up new event planner
	When a person goes to the home page
	Then he sees information about Ride Bum
	When he clicks on "Sign up" 
	And he fills out the new user form
	And he sees "Listing events"
	And he sees "You have signed up successfully."

   Scenario: Sign in existing event planner
        Given "Tewan" is an event planner
	And he is not logged in
	When he goes to the home page
	Then he sees information about Ride Bum
	When he fills in "user_login" with "Tewan"
	And he fills in "user_password" with "abc123"
	And he clicks on "Log in" 
	Then he sees "Listing events"
	And he sees "Signed in successfully."

   Scenario: Sign in existing event planner
        Given "Tewan" is an event planner
	And he is not logged in
	When he goes to the home page
	Then he sees information about Ride Bum
	When he fills in "user_login" with "Tewan"
	And he fills in "user_password" with "abc123"
	And he clicks on "Log in" 
	Then he sees "Listing events"
	And he sees "Signed in successfully."

   Scenario: Try to sign in with a bad password
        Given "Tewan" is an event planner
	And he is not logged in
	When he goes to the home page
	Then he sees information about Ride Bum
	When he fills in "user_login" with "Tewan"
	And he fills in "user_password" with "badpass"
	And he clicks on "Log in" 
	Then he sees "Sign in"
	And he sees "Invalid login or password."

   Scenario: Describe event planners dashboard
        Given "Tewan" is logged in as an event planner
        And he has created the "Graveyard pitstop" event
        And there is a "Boring" event
	And he is on his dashboard page
	Then he should see "Graveyard pitstop"
	But he should not see "Boring"

  
