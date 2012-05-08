Feature: Person signs up as an event planner
    If someone wants to use Ride Bum to manage their event's carpools
    They need to create an account
    And log in

   Scenario:
	When a person goes to the home page
	Then he sees information about Ride Bum
	When he clicks on "Sign up" 
	And he fills out the new user form
	And he sees "Listing events"
	And he sees "You have signed up successfully."
