 As followed the TDD the first step is. At first I was writing a test for the no job scenario. I used RSpec for test

First step:

 I was creating a Job class with filter for empty or not String, manage the dedicated input format as ("x => y")


Secons step:

 I was creating a Order class with @jobs string. add method going to manage the input and load the inuput into the @jobs

Thrid step:

 I was creating the job order method. Create a new array with inject method 

Fourth step:

 Dependancy check in the Job class and manage this case in the job_order method. The key is swap the depandancy and job order with insert method. 

Fifth step:

  Create the SelfDependencyError class and make it raise when the job.name and job.dependancy are same.

Sixth step:

  Create the CircularDependencyError class and setup a element counter. Make it rise if 
  more element loaded into the array than can be.
