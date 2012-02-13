Feature: Sign in with various authentication providers
  In order to control my events and invitations
  As an event planner
  I need to create an account on the site and sign into it 

  Based on information from: 
  	http://asciicasts.com/episodes/241-simple-omniauth
  	http://asciicasts.com/episodes/304-omniauth-identity

  Scenario: Sign up with a local account
    Given a non-logged-in user
    When he goes to the home page
    And he clicks on "Create an account"
    Then he registers with name "John Doe" and email "jdoe@example.com"
    # And then it doesn't really show what happens
  


