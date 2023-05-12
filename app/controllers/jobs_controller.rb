class JobsController < ApplicationController
  def index
    jobs = Job.all
  end

  def import
    file = params[:file]
    jobs = SmarterCSV.process(file.path)
    Job.create!(jobs)
    redirect_to root_path, notice: "Imported successfully"
  end
  

end
