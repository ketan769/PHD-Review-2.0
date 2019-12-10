class SearchesController < ApplicationController

    def search_params
        params.require(:user).permit(:uin, :first_name, :last_name, :review_year,:start_semester,:cumul_gpa,:advisor,:degree_plan_date,
        :prelim_date,:proposal_date,:final_exam_defence_date,:cv,:student_report,:cover)
    end

    
    def new
        check=Auth.where(:username =>session[:user]).select('DISTINCT ON (username) *').pluck(:role)
        if(check[0]=='S' or check[0]=='Student')
           redirect_to studet_path(check,:uin =>session[:user]) and return
        end
        session[:uin]=nil
        session[:review_year]=nil
        session[:first_name]=nil
        session[:last_name]=nil
    end


    def index
        check=Auth.where(:username =>session[:user]).select('DISTINCT ON (username) *').pluck(:role)
        if(check[0]=='S' or check[0]=='Student' )
            redirect_to studet_path(check,:uin =>session[:user]) and return
        end
        
        if params[:first_name]!=nil and params[:last_name]!=nil  
            params[:first_name]=params[:first_name].delete(' ')
            params[:first_name]=params[:first_name].upcase
            params[:last_name]=params[:last_name].delete(' ')
            params[:last_name]=params[:last_name].upcase
        end

        
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
        check=Auth.where(:username =>session[:user]).select('DISTINCT ON (username) *').pluck(:role)
        
        if(check[0]=='Faculty' or check[0]=='F' )
            temp=User.where(:advisor =>session[:user]).pluck(:uin)
            @temp=@temp.where(:user =>temp)
        end
        if @temp==[]
            flash[:notice] = "No record found"
            render '/searches/new'    
        else
            session[:uin]=params[:uin]
            session[:review_year]=params[:review_year]
            session[:first_name]=params[:first_name]
            session[:last_name]=params[:last_name]
            session[:duin]=@temp.pluck(:user_id)
            session[:dyear]=@temp.pluck(:year)
            flash.clear
            @tempk=""
            return @temp
        end
        
    end

    def show
      check=Auth.where(:username =>session[:user]).select('DISTINCT ON (username) *').pluck(:role)
      if(check[0]=='S' or check[0]=='Student' )
        redirect_to studet_path(check,:uin =>session[:user]) and return
      end
      if params[:uin] == nil
         params[:uin] = session[:pdf_user]
      end
      
      @detail=Review.rev_func(params[:uin]).select('DISTINCT ON (reviews.user_id,reviews.year) *').limit(1)
      @revs=Review.rev_func(params[:uin]).select('DISTINCT ON (reviews.user_id,reviews.year) *')
      temp=@detail.pluck(:user_id)
      temp2=User.where(:uin => temp[0]).pluck(:advisor)
      temp3=User.where(:uin => temp2[0]).pluck(:first_name)
      temp4=User.where(:uin => temp2[0]).pluck(:last_name)
      if temp3!=[] and temp4!=[]
        temp5=temp3[0]+' '+temp4[0]
        @tempad=temp5
      else 
          @tempad=""
      end
      session[:pdf_user]= params[:uin]
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
        @temp2=temp1
        session[:chk]=@temp2
    
    end
    
    def add_user
        flash.clear
        temp=Auth.where(:role =>"Faculty").pluck(:username)
        tempf=User.where(:uin => temp).pluck(:first_name)
        templ=User.where(:uin => temp).pluck(:last_name)
        temps=['No Selection']
        tempf.zip(templ).each do |i,j|
            temps.append(i+' '+j)
        end
        @temp21=temps
    end
    
    def user_create
        if params[:uin]=="" or params[:first_name]=="" or params[:last_name]=="" or params[:review_year]=="" or params[:email]=="" or  params[:password]==""  or  params[:c_password]==""   
            flash[:notice] = "No field can be empty"
            render '/searches/add_user' and return
        end
        
        if params[:password]!=params[:c_password]
            flash[:notice] = "Password and Confirm password Should Match"
            render '/searches/add_user' and return 
        end
        
        temp2=Review.rev_func(params[:uin])
        if temp2!=[]
            flash[:notice] = "User Already Exists"
            render '/searches/new' and return
        end
        params[:uin]=params[:uin].delete(' ')
        params[:first_name]=params[:first_name].delete(' ')
        params[:first_name]=params[:first_name].upcase
        params[:last_name]=params[:last_name].delete(' ')
        params[:email]=params[:email].delete(' ')
        params[:password]=params[:password].delete(' ')
        params[:c_password]=params[:c_password].delete(' ')
        params[:last_name]=params[:last_name].upcase
        temp=params[:advisor].match(/(\w+) (\w+)/)
        
        params[:advisor]=User.where(:first_name => temp[1] , :last_name => temp[2]).pluck(:uin)
        params[:advisor]=params[:advisor][0]
        Auth.create(:username => params[:uin],:role => params[:role],:password => params[:password],:email => params[:email])
        User.create(:uin => params[:uin],:first_name => params[:first_name],:last_name => params[:last_name],:review_year => params[:review_year],:advisor => params[:advisor])
        Review.create(:user_id => params[:uin],:year => params[:review_year])
        flash[:notice] = "User Created Successfully"
        render '/searches/new'  
    end
    
    def studet
      @detail=Review.rev_func(params[:uin]).select('DISTINCT ON (reviews.user_id,reviews.year) *').limit(1)
      @revs=Review.rev_func(params[:uin]).select('DISTINCT ON (reviews.user_id,reviews.year) *')
      temp=@detail.pluck(:user_id)
      temp2=User.where(:uin => temp[0]).pluck(:advisor)
      temp3=User.where(:uin => temp2[0]).pluck(:first_name)
      temp4=User.where(:uin => temp2[0]).pluck(:last_name)
      if temp3!=[] and temp4!=[]
        temp5=temp3[0]+' '+temp4[0]
        @tempad=temp5
      else 
          @tempad=""
      end
      session[:pdf_user]= params[:uin]
      
    end
    
    def doc_up
      @document1=User.find_by(:uin =>session[:pdf_user])
      @temp5=@document1.fielname   
      @temp6=@document1.fieldname
      @temp4=""
    end
    
    def savepd2
        User.savepdf2(params,session[:pdf_user])
        redirect_to '/doc_up'        
    end
    
    def savepd3
        Review.savepdf(params)
        flash[:notice] = "Decision Letter uploaded for #{params[:tempid]}"
        redirect_to '/searches'
    end
    
    def view_letter
       
      @document=Review.find_by(:user_id =>params[:uin_let],:year => params[:year_let])    
      if @document.decision_let == nil
          flash[:notice] = "Decision Not available"
          redirect_to "/searches/show" and return     
      end
      send_data(@document.decision_let,
                type: @document.content_type,
                filename: @document.filename,
                :disposition => 'inline')
    end
        
    def savepd
        User.savepdf(params,session[:pdf_user])
        redirect_to '/doc_up'        
    end

    
    def showpdf
      @document=User.find_by(:uin => session[:pdf_user])    
      send_data(@document.decision_let,
                type: @document.content_type,
                filename: @document.fielname)
    end
    
    def add_item
    end
    
    def separate_review
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
                                :cumul_gpa =>params[:cumul_gpa],:degree_plan_date =>params[:degree_plan_date],
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
        flash[:notice] = "Updated"
        redirect_to :controller => 'searches', :action => 'index'       
    end
end
