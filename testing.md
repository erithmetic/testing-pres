!SLIDE

# Test-Driven Development

!SLIDE

# Software Engineering

!SLIDE

# Cowboy Coder
 1. Write code
 1. Click some links
 1. Deploy

!SLIDE

# Cowboy Coder
 * Code breaks easily
 * Expensive to change

!SLIDE

# Enterprise Coder (Waterfall)
 1. Gather specifications
 1. Write detailed design documents
 1. Code according to design
 1. Click some links
 1. Deploy

!SLIDE

# Enterprise Coder (Waterfall)
 * Code can break just as easily
   * Failure rate is comparable
 * Expensive to change

!SLIDE

# Which One is Software Engineering?
 * Engineering: the set of practices that work

!SLIDE

# What Works?
 * 1960s: NASA Project Mercury
   * Planned and wrote tests before each micro-increment
 * 1968 NATO Software Engineering Conference
> A sofware system can best be designed if 
> the testing is interlaced with the 
> designing instead of being used after 
> the design.

!SLIDE

# Test-Driven Development
 1. Write automated tests
 1. Run tests, ensuring they fail
 1. Write code
 1. Run tests, fix code
 1. Tests pass
 1. Deploy

!SLIDE

# Test-Driven Development
 * Fewer bugs
 * Easy to change

!SLIDE

# Testing vs Test-Driven Development

!SLIDE

# How Does it Work?

!SLIDE

# Two Different Kinds of Tests

!SLIDE

# Integration Test
 * "Black box" test
 * Test an interface with the user or with other apps
 * Test the interaction of the application's sub-modules

!SLIDE

# Integration Test - Example

    When I go to the examples page
    And I click the automobile example
    Then I should see an emission value 
                     within 10kgs of 68

!SLIDE

# Unit Test
 * Test smallest possible units of code
   * Usually, this means functions

!SLIDE

# Requirement
 * Need to calculate emissions for an automobile
   * An electric car has 0 emissions
   * Otherwise, multiply amount of fuel used by the emission factor for gasoline

!SLIDE

@@@ ruby
    describe 'auto_emission_from_fuel' do
      it 'should return 0 for electricity' do
        auto_emission_from_fuel(:electricity, 0).should == 0
      end
      it 'should return 0 if no gasoline consumed' do
        auto_emission_from_fuel(:gasoline, 0).should == 0
      end
      it 'should return 127.4 for 2 litres of gas' do
        auto_emission_from_fuel(:gasoline, 2).should == 127.4
      end
    end
@@@

!SLIDE

@@@ ruby
    def auto_emission_from_fuel(fuel_type, fuel_consumed)
      if fuel_type == :electricity
        0.0
      else
        fuel_consumed * 63.7
      end
    end
@@@

!SLIDE

    auto_emission_from_fuel
      should return 0 for electricity
      should return 0 if no gasoline consumed
      should return 127.4 for 2 litres of gas
    
    Finished in 0.00262 seconds
    3 examples, 0 failures

!SLIDE

# New Requirement
 * Need to calculate emissions for a diesel car

!SLIDE
@@@ ruby
    describe 'auto_emission_from_fuel' do
      it 'should return 0 for electricity' do
        auto_emission_from_fuel(:electricity, 0).should == 0
      end
      it 'should return 0 if no gasoline consumed' do
        auto_emission_from_fuel(:gasoline, 0).should == 0
      end
      it 'should return 127.4 for 2 litres of gas' do
        auto_emission_from_fuel(:gasoline, 2).should == 127.4
      end
      it 'should return 0 if no diesel consumed' do
        auto_emission_from_fuel(:diesel, 0).should == 0
      end
      it 'should return 98.2 for 2 litres of diesel' do
        auto_emission_from_fuel(:diesel, 2).should == 98.2
      end
    end
@@@
!SLIDE
    auto_emission_from_fuel
      should return 0 for electricity
      should return 0 if no gasoline consumed
      should return 127.4 for 2 litres of gas
      should return 0 if no diesel consumed
      should return 98.2 for 2 litres of diesel (FAILED)

    Failures:
      1) auto_emission_from_fuel should return 98.2 for 
           2 litres of diesel
         expected: 98.2,
              got: 127.4 (using ==)

    Finished in 0.02052 seconds
    5 examples, 1 failure
!SLIDE

@@@ ruby
    def auto_emission_from_fuel(fuel_type, fuel_consumed)
      if fuel_type == :electricity
        0.0
      elsif fuel_type == :diesel
        fuel_consumed * 49.1
      else
        fuel_consumed * 63.7
      end
    end
@@@

!SLIDE

    auto_emission_from_fuel
      should return 0 for electricity
      should return 0 if no gasoline consumed
      should return 127.4 for 2 litres of gas
      should return 0 if no diesel consumed
      should return 98.2 for 2 litres of diesel

    Finished in 0.01593 seconds
    5 examples, 0 failures

!SLIDE

# What's Happening?
 * Testing correctness of the code
 * Defining a *contract*
   * between the user and the application
   * between the different parts of the code

!SLIDE

# What Could Possibly Go Wrong?
 * Double or more the amount of code
 * You could spend an infinite amount of time covering all possible cases
 * A code change can end up breaking too many tests

!SLIDE

# Solutions to TDD Hangups
 * TDD pushes you to write code that is easy to test
   * Follow that prodding
   * Code that is limited in scope
     * Small methods
     * Minimize the effects of a change
   * Code that is decoupled
     * "Tell, don't ask"
     * Apply the idea to test writing
 * Tests should cover most possibilities, but stay as unspecific as possible

!SLIDE

# Example of Decoupling
@@@ ruby
    class Car
      has_one :engine

      def go
        engine.ignite unless engine.running?
        move_forward
      end
    end
@@@

!SLIDE

@@@ ruby
    describe 'Car#go' do
      it 'should start the engine if it is not running' do
        car.engine.should_receive :ignite
        car.engine.running = false
        car.go
      end
    end
@@@

!SLIDE

@@@ ruby
    def go
      start unless running?
      move_forward
    end
    
    def start
      engine.ignite
    end
    def running?
      engine.running?
    end
@@@

!SLIDE

# Not So Great

!SLIDE

@@@ ruby
    describe 'Car#go' do
      it 'should start the engine if it is not running' do
        car.should_receive :start
        car.stub!(:running?).and_return false
        car.go
      end
    end
@@@

!SLIDE

# Limits to TDD
 * Very difficult to test HTML layouts, color schemes, graphical interfaces

!SLIDE

# Thanks!

!SLIDE
