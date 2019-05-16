#the test bit overcomplicated the context tag not necessary but can be usefull it the program going to be more complicate.


require_relative File.expand_path("../lib/job.rb")
require_relative File.expand_path("../lib/order.rb")
require_relative File.expand_path("../lib/errors.rb")


RSpec.describe "For ruby exercise" do
  

  #shuld be pass as retrun empty if no job added 
  context 'no job added - no name added' do
    it 'should be return empty' do
      empty_job = Job.new("") #job created without name (no job)
      expect(empty_job.name.to_s).to be_empty
    end
  end


  context 'a simple job added' do
    it 'should be returned the job what has been added' do
      new_job = Order.new #new order created
      new_job.add("a =>") #add element
      new_job.job_order
      filtered_order =  new_job.job_order.join(",").delete(" =>,")
      expect(filtered_order.include?("a")).to be true #the created element should be inlcluded
      expect(filtered_order.length).to eq(1) #only that element can be included
    end
  end


  #should be return in dedicated order - no dependancy
  context 'no dependancy' do
    it 'should be return in same order like the input' do
      new_job = Order.new #new order created
      new_job.add("a => 
                  b =>
                  c =>
                  ") #add elements
      new_job.job_order
      filtered_order =  new_job.job_order.join(",").delete(" =>,") #remove the extra caracters if added
      #expected order:
      expect(filtered_order[0]).to eq('a')
      expect(filtered_order[1]).to eq('b')
      expect(filtered_order[2]).to eq('c')

    end
  end


  #should be return in the correct order - c before b
  context 'one job has dependency' do
    it 'job c should be done befor b' do
      new_job = Order.new #new order created
      new_job.add("a =>
                   b => c
                   c =>     
                  ") #add elements
      new_job.job_order
      filtered_order =  new_job.job_order.join(",").delete(" =>,") #remove the extra caracters if added
      #expected order:
      expect(filtered_order[0]).to eq('a')
      expect(filtered_order[1]).to eq('c')
      expect(filtered_order[2]).to eq('b')
    end
  end



  #should be return in the correct order f -> c -> b -> e -> a -> d
  context 'dependency chain' do
    it 'should be returned in the following job order f -> c -> b -> e -> a-> d' do 
      new_job = Order.new #new order created
      new_job.add("a =>
                   b => c
                   c => f
                   d => a
                   e => b
                   f =>
                  ") #add elements
      filtered_order =  new_job.job_order.join(",").delete(" =>,") #remove the extra caracters if added
     # p filtered_order
      #the oreder of the jobs
      expect(filtered_order.index('f') < filtered_order.index('c')).to be true
      expect(filtered_order.index('c') < filtered_order.index('b')).to be true
      expect(filtered_order.index('b') < filtered_order.index('e')).to be true
      expect(filtered_order.index('a') < filtered_order.index('d')).to be true
      expect(filtered_order.split("").uniq.length).to eq(6) #all of the 6 job should be included the uniq for remove the duplication as the first always going to stay the order should be perfect
    end
  end



  #should raise with a error if the the jobs has self dependancy
  context 'self-dependancy' do
    it 'should be raise with a SelfDependencyError' do
      new_job = Order.new #new order created
      new_job.add("a =>
                   b =>
                   c => c
                  ")#add elements
      expect { raise SelfDependencyError, "jobs can’t depend on themselves"}.
      to raise_error("jobs can’t depend on themselves") #should raise with an errore and the message should be: "jobs can’t depend on themselves" 
    end
  end


  #should raise with a error if the job order has inifinte loop
  context 'circular_dependency' do
    it 'should raise with a CircularDependencyError' do
      new_job = Order.new #new order created
      new_job.add("a =>
                  b => c
                  c => f
                  d => a
                  e =>
                  f => b
                 ")#add elements
      expect { raise CircularDependencyError, "jobs can’t have circular dependencies"}.
      to raise_error("jobs can’t have circular dependencies") #should raise with an errore and the message should be: "jobs can’t depend on themselves"
    end
  end



end