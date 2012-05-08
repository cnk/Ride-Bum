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
