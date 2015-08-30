class StudentAttributesController < ApplicationController
    def get_attribute_by_user_and_subcategory
        respond_to do |format|
            format.json {
                @student_attribute = StudentAttribute.find_by_requirement_subcategory_id_and_user_id(params[:payload][:subcategory], @current_user.id)
                if @student_attribute
                    render :json => @student_attribute
                else
                    render :nothing => true, :status => 200, :content_type => 'text/html'
                end
            }
        end
    end

    def user_attributes

        respond_to do |format|
            format.json{
                puts params[:payload]

                @student_attributes = StudentAttribute.where(:requirement_category_id => params[:payload][:category_id], :user_id => params[:payload][:user_id])

                render :json => @student_attributes
            }
        end
    end

end
