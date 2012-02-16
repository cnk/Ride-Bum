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
    Then he sees "Signed in!"
  
  Scenario: Sign in with a local account
    Given there is a local user with email "jdoe@example.com"
    And he is not logged in
    When he goes to the home page
    And he clicks on "Sign In" 
    Then he fills in email "jdoe@example.com" and password "password"  
    Then he sees "Signed in!"

   Scenario: Twitter link appears on the front page
      Given a non-logged-in user
      And he is not logged in
      When he goes to the home page
      And he clicks on "Twitter"
      Then he sees "Signed in!"
      
   
