class JobsController < ApplicationController
  def index
    if params[:search].present?
      @jobs = Job.search do
        fulltext params[:search] do
          boost_fields name: 10
        end
        order_by(:score, :desc)
      end.results
    end
    # list cities, job,industry
    @top_jobs = Job.latest_jobs
    @top_cities = City.top_cities
    @top_industries = Industry.top_industries
  end

  def city_jobs
    @city_name = params[:city_name]
    
      @jobs = Job.search do fulltext "\"#{params[:city_name]}\"" 
      paginate page: 1, per_page: Job.count
      end.results
      @job_count = @jobs.total_count
      @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(10)
    render 'joblist'
  end
  # def city_jobs
  #   city_name = params[:city_name]
  #   @city_display = city_name
  #   if city_name == 'Khác'
  #     @search = Job.search do
  #       fulltext "\"#{city_name}\"" do
  #         fields(:city_name)
  #       end
  #       paginate page: 1, per_page: Job.count
  #     end
  #   else
  #     @search = Job.search do 
  #       fulltext "\"#{city_name}\"" 
  #       paginate page: 1, per_page: Job.count
  #     end
  #   end
    
  #   @job_count = @search.results.count
  #   @jobs = @search.results
  #   # binding.pry
  #   render 'joblist'
  # end
  # def city_jobs
  #   city_name = params[:city_name]
  #   @city_display = city_name
  
  #   if city_name.start_with?('"') && city_name.end_with?('"') && city_name.length > 2
  #     quoted_search_query = city_name[1..-2] # Lấy chuỗi con không bao gồm dấu nháy kép ở đầu và cuối
  #     @search = Job.search do
  #       fulltext "\"#{quoted_search_query}\"" do
  #         fields(:name, :description, :company_name, :benefit, :company_address, :company_district, :work_place,:industry_name, :city_name, :company_district, :requirement).boost(2.0)
  #       end
  #       paginate :page => params[:page], :per_page => 20
  #     end
  #   else
  #     @search = Job.search do 
  #       fulltext city_name do
  #         fields(:name, :description, :company_name, :benefit, :company_address, :company_district, :work_place,:industry_name, :city_name, :company_district, :requirement)
  #       end
  #       paginate :page => params[:page], :per_page => 20
  #     end
  #   end
  
  #   @jobs = @search.results
  #   render 'jobs/jobs_list_of_city_industry'
  # end
  # def city_jobs
  #   @city_name = params[:city_name]
  
  #   if @city_name.start_with?('"') && @city_name.end_with?('"') && @city_name.length > 2
  #     quoted_search_query = @city_name[1..-2] # Remove the double quotes at the beginning and end
  #     @jobs = Job.search do
  #       fulltext "\"#{quoted_search_query}\"" do
  #         fields(:name, :description, :company_name, :benefit, :company_address, :company_district, :work_place, :industry_name, :city_name, :requirement).boost(2.0)
  #       end
  #       paginate page: params[:page], per_page: 20
  #     end.results
  #   else
  #     @jobs = Job.search do
  #       fulltext @city_name do
  #         fields(:name, :description, :company_name, :benefit, :company_address, :company_district, :work_place, :industry_name, :city_name, :requirement).boost(1.0)
  #       end
  #       paginate page: params[:page], per_page: 20
  #     end.results
  #   end
  
  #   @job_count = @jobs.total_count
  #   @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(10)
  #   render 'joblist'
  # end
end  
