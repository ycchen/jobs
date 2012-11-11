class JobsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :update, :destroy]
  before_filter :find_my_job, :only =>[:edit, :update, :destroy, :open, :close]
  def index
    if params[:user_id]
      # @jobs = User.find(params[:user_id]).jobs.order("created_at desc")
      @jobs = Kaminari.paginate_array(User.find(params[:user_id]).jobs.order("created_at desc")).page(params[:page]).per(15)
      # @jobs = Job.where("user_id=#{params[:user_id]}")
    elsif params[:search]
      # @jobs = Job.search(params[:search])
      @jobs = Kaminari.paginate_array(Job.search(params[:search])).page(params[:page]).per(15)
    else
      @jobs = Job.page(params[:page]).per(15)
    end

    respond_to do |format|
      format.html
      format.json { render json: @jobs}
    end
    
  end

  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @job}
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(params[:job])
    if @job.save
      redirect_to @job, :notice => "Successfully created job."
    else
      render :action => 'new'
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(params[:job])
      redirect_to @job, :notice  => "Successfully updated job."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_url, :notice => "Successfully destroyed job."
  end

  def open
    @job.open
    @job.save!

    redirect_to job_path(@job)
  end

  def close
    @job.close
    @job.save!

    redirect_to job_path(params[:id])
  end

  private
  def find_my_job
    @job = current_user.jobs.find(params[:id])
  end
end
