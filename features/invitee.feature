Feature: An invitee responds to his invitation email
    As someone invited to an event
    I want to to use Ride-Bum to find a carpool or volunteer to drive a carpool

    Background:
        And "George" has created the "Graveyard pitstop" event
        And he has invited "Jeff" to the "Graveyard pitstop" event

    Scenario: An invitee responds to an email
    	When "Jeff" clicks on the link in the invitation email
	Then he should be on the "Graveyard pitstop" event page
	And he should see "Graveyard pitstop"

