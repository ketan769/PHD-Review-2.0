class SearchesController < ApplicationController
    def search_params
        params.require(:user).permit(:uin, :first_name, :last_name, :review_year,:start_semester,:cumul_gpa,:advisor,:degree_plan_date,
        :prelim_date,:proposal_date,:final_exam_defence_date,:cv,:student_report)
    end
    
    def new
        check=Auth.where(:username =>session[:user]).select('DISTINCT ON (username) *').pluck(:role)
        if(check[0]=='S')
            redirect_to search_path(check,:uin =>session[:user])
        end
        session[:uin]=nil
        session[:review_year]=nil
        session[:first_name]=nil
        session[:last_name]=nil
        
    end
    def index
        if session[:uin]!=nil
            params[:uin]=session[:uin]
        end
        if session[:review_year]!=nil
            params[:review_year]=session[:review_year]
        end
        if session[:first_name]!=nil
            params[:first_name]=session[:first_name]
        end
        if session[:last_name]!=nil
            params[:last_name]=session[:last_name]
        end
        if params[:uin]!=""
            @temp=Review.rev_func(params[:uin]).select('DISTINCT ON (reviews.user_id,reviews.year) *')
        else
            temp=User.pluck(:uin)
            @temp=Review.rev_func(temp).select('DISTINCT ON (reviews.user_id,reviews.year) *')
        end
        
        if params[:first_name]!=""
            temp=User.where(:first_name =>params[:first_name]).pluck(:uin)
            @temp=@temp.where(:user_id =>temp)
        end
        if params[:last_name]!=""
             temp=User.where(:last_name =>params[:last_name]).pluck(:uin)
             @temp=@temp.where(:user =>temp)
        end
        if params[:review_year]!=""
            @temp=@temp.where(:year =>params[:review_year])
        end
        if @temp==[]
            flash[:notice] = "No record found"
            render '/searches/new'    
        else
            # temp_uin=@temp.pluck(:uin).uniq
            # temp_year=@temp.pluck(:year).uniq
            session[:uin]=params[:uin]
            session[:review_year]=params[:review_year]
            session[:first_name]=params[:first_name]
            session[:last_name]=params[:last_name]
            session[:duin]=@temp.pluck(:user_id)
            session[:dyear]=@temp.pluck(:year)
            return @temp
        end
    end

    def show
      @detail=Review.rev_func(params[:uin]).select('DISTINCT ON (reviews.user_id,reviews.year) *').limit(1)
    end
    
    def date
        temp=params[:chk]
        temp1=[]
        temp.each do |i|
            if i=="on"
                temp1[-1]="on"
            else
                temp1.append(i) 
            end
        end
        session[:chk]=temp1
    end
    
    def add_user
        flash.clear
    end
    
    def user_create
        if params[:password]!=params[:c_password]
            flash[:notice] = "Password and Confirm password Should Match"
            render '/searches/add_user'  
        end
        temp2=Review.rev_func(params[:uin])
        if temp2!=[]
            flash[:notice] = "User Already Exists"
            render '/searches/add_user' 
        end
        Auth.create(:username => params[:uin],:role => params[:role],:password => params[:password],:email => params[:email])
        User.create(:uin => params[:uin],:first_name => params[:first_name],:last_name => params[:last_name],:review_year => params[:review_year])
        Review.create(:user_id => params[:uin],:year => params[:review_year])
        flash[:notice] = "User Created Successfully"
        render '/searches/new'  
    end
    
    def add_item
    end
    
    def item_create
        temp1=Review.rev_func(params[:uin]).where(:year => params[:review_year]).select('DISTINCT ON (reviews.user_id,reviews.year) *')
        if temp1==[]
            Review.create(:user_id => params[:uin] ,:year => params[:review_year])
            flash[:notice] = "Line Item Added"
            redirect_to :controller => 'searches', :action => 'index' 
        else
            flash[:notice] = "Line Item Already Exists"
            redirect_to :controller => 'searches', :action => 'index'
        end
    end
    def det_update
      
      @temp=User.find(params[:uin])
      @temp.update_attributes!(:first_name =>params[:first_name],:last_name =>params[:last_name],:start_semester => params[:start_semester],
                                :cumul_gpa =>params[:cumul_gpa],:advisor => params[:advisor],:degree_plan_date =>params[:degree_plan_date],
                                :prelim_date => params[:prelim_date],:proposal_date => params[:proposal_date] , :final_exam_defence_date =>params[:final_exam_defence_date])
      flash[:notice] = "Updated"
      redirect_to :controller => 'searches', :action => 'index'        
    end
    def date_update
        tempd1=session[:duin]
        session[:duin]=nil
        tempd2=session[:dyear]
        session[:dyear]=nil
        tempd3=session[:chk]
        
        k=0
        
        tempd1.zip(tempd2).each do |i,j|
            if tempd3[k]=='off'
                k=k+1
                next
            else
                byebug
                @rev=Review.find_by(:user_id =>i ,:year => j)
                @rev.update_attributes(:review_official_student_deadline => params[:rosd_date],:review_student_input_date =>params[:rsid_date],
                                        :review_faculty_input_date =>params[:rfid_date],:review_release_date => params[:rrd_date],:ip_open_date =>params[:ipod_date],
                                        :ip_official_student_deadline => params[:ipsd_date],:ip_student_input_date => params[:ipsid_date],
                                        :ip_faculty_input_date => params[:ipfd_date],:ip_release_date => params[:iprd_date],:dp_open_date => params[:dpo_date],
                                        :dp_official_student_deadline => params[:dpos_date],:dp_student_input_date => params[:dpsi_date],:dp_faculty_input_date => params[:dpfi_date],
                                         :dp_release_date =>params[:dprd_date])
                k=k+1
            end
        end
        
        redirect_to :controller => 'searches', :action => 'index'       
    end
end
