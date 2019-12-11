class ReviewsController < ApplicationController
  
    def review_params
        params.require(:review).permit(:user,:review_year,:review_score, :comments_for_student, :comments_for_faculty, :notes)
    end
    def index
        if(session[:user]==nil)
            redirect_to "/login" and return
        end
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
        if session[:role]!=nil
            params[:role]=session[:role]
        end
        if params[:uin]!=""
            @temp=Review.rev_func(params[:uin]).select('DISTINCT ON (reviews.user_id,reviews.year) *')
            check=Auth.where(:username =>params[:uin]).select('DISTINCT ON (username) *').pluck(:role)
            if check[0] == "F"
                @temp = null
            end
        else
            temp=User.pluck(:uin)
            check=Auth.where(:username =>temp).select('DISTINCT ON (username) *').pluck(:role)
        
            @temp=Review.rev_func(temp).select('DISTINCT ON (reviews.user_id,reviews.year) *')
        end
        if params[:first_name]!=""
            temp=User.where(:first_name =>params[:first_name]).pluck(:uin)
            check=Auth.where(:username =>temp).select('DISTINCT ON (username) *').pluck(:role)
        
            @temp=@temp.where(:user_id =>temp)
        end
        if params[:last_name]!=""
             temp=User.where(:last_name =>params[:last_name]).pluck(:uin)
             check=Auth.where(:username =>temp).select('DISTINCT ON (username) *').pluck(:role)
        
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
        
        if(params[:role]=="2" )
            temp=Auth.where(:role =>'Faculty').select('DISTINCT ON (username) *').pluck(:username)
            @temp=@temp.where(:user =>temp)
        end
      
        if(params[:role]=="1")
            temp=Auth.where(:role =>'Student').select('DISTINCT ON (username) *').pluck(:username)
            @temp=@temp.where(:user =>temp)
        end
        if(params[:role]=="3")
            temp=Auth.where(:role =>'Admin').select('DISTINCT ON (username) *').pluck(:username)
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
            session[:role]=params[:role]
            session[:duin]=@temp.pluck(:user_id)
            session[:dyear]=@temp.pluck(:year)
            session[:page]="review"
            flash.clear
            @tempj=""
            return @temp
        end
        
    end
    
    def savepd3
        if(session[:user]==nil)
            redirect_to "/login" and return
        end
        Review.savepdf(params)
        flash[:notice] = "Decision Letter uploaded for #{params[:tempid]}"
        redirect_to '/reviews'
    end
    
    def new
        if(session[:user]==nil)
            redirect_to "/login" and return
        end
        @review = Review.new
    end
    
    def show
      if(session[:user]==nil)
            redirect_to "/login" and return
      end 
      id = params[:id] # retrieve review ID from URI route
      @review = Review.find(id) # look up review by ID
    end
    
    def create
      if(session[:user]==nil)
            redirect_to "/login" and return
      end
      @review = Review.create!(review_params)
      flash[:notice] = "review was successfully updated."
      redirect_to '/reviews' and return
    end
    
    def edit
      if(session[:user]==nil)
            redirect_to "/login" and return
      end
      @review = Review.find params[:id]
    end
    
    def update
      if(session[:user]==nil)
            redirect_to "/login" and return
      end
      @review = Review.find params[:id]
      @review.update_attributes!(review_params)
      temp3=User.where(:uin => session[:user]).pluck(:first_name)
      temp4=User.where(:uin => session[:user]).pluck(:last_name)
      if temp3!=[] and temp4!=[]
        temp5=temp3[0]+' '+temp4[0]
      else 
        temp5=""
      end  
      @review.update_attributes!(:reviewer => temp5)
      flash[:notice] = "Review was updated successfully."
      redirect_to review_path(@review) and return
    end
    
    def view_dec_letter
      if(session[:user]==nil)
            redirect_to "/login" and return
      end
      @review=Review.find_by(:user_id =>params[:uin_let],:year => params[:year_let])    
      if @review.decision_let == nil
          flash[:notice] = "Decision Letter not available"
          redirect_to review_path(@review) and return     
      end
      send_data(@review.decision_let,
                type: @review.content_type,
                filename: @review.filename,
                :disposition => 'inline')
    end
    
    def destroy
      if(session[:user]==nil)
            redirect_to "/login" and return
      end
      @review = Review.find(params[:id])
      @review.destroy
      flash[:notice] = "Review '#{@review.user_id}' deleted."
      redirect_to reviews_path
    end
      
    def set_user
      if(session[:user]==nil)
            redirect_to "/login" and return
      end
      @user = User.find(params[:uin])
    end
end
