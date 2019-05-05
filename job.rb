class Job

  attr_accessor :name, :dependency #access for them

  def initialize(jobs)
    if !jobs.empty? #check for job added or not
      if jobs.kind_of?(String) #make sure string on the input
        @name, @dependency = jobs.split(/ => /).map { |row| row.strip } #take datas in "x => y" format. the split shuld split them on "=>" the strip should remove any extra caracter like "\t\r\n" 
      end
    end
  end

  def depends_on? #check the the second varibel is exist or not for jobs without dependency
    if !@dependency
      false
    else
      true
    end
  end



end