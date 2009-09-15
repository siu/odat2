# encoding: UTF-8
class Help::JobsController < Help::HelpSectionController
  # GET /jobs
  # GET /jobs.xml
  def index
    @jobs = Job.paginate(:page => params[:page])
  end

end
