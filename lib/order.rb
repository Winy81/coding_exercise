class Order

  def initialize
    @jobs = [] #the initilaize method has a empty array
  end


  def add(job_dep)
    job_dep.split("\n").each do |row| # brake the string on the enter (/n)
      job = Job.new(row) # takes the rows and convert into an array 
      @jobs << (job) unless @jobs.include?(job) # pushes job instances to an array @jobs
    end
  end

  
  def job_order
    @jobs.inject([]) do |order, job| #inject method creates a simple array with names and dependancies
    job_counter = order << (job.name) #count how many jobs in the scenario, keep the variable untouched for the circular error
    order << (job.name) if order.include?(job.name) == false #the filter refuse add same job twice into the array
    

      if job.depends_on?
      
       raise SelfDependencyError.new("jobs can’t depend on themselves") if job.dependency == job.name #raises error if the job dependancy is the jo itself
         position = order.index(job.name) #mark the name of the index
         order.insert(position, job.dependency).uniq # push the dependancy value before the job index - uniq method remove the duplication what may have. always the first going to stay, thats why the order should be fine.
      end

      raise CircularDependencyError.new("jobs can’t have circular dependencies") if order.length > (job_counter.length)*2 #the order lenght can't be longer than the original list of job twice as every job can have one dependancy
        order 
    
    end

  end

end

