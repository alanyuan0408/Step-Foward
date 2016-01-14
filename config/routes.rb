Rails.application.routes.draw do
    devise_for :users
    # The priority is based upon order of creation: first created -> highest priority.
    # See how all your routes lay out with "rake routes".

    # You can have the root of your site routed with "root"
    # root 'welcome#index'
    resources :users, only: [:create, :update, :destroy, :show]
    resources :projects, only: [:create, :update, :destroy, :show]
    resources :requirement_categories, only: [:create, :update, :destroy]
    resources :requirement_subcategories, only: [:create, :update, :destroy, :show]
    resources :project_applications, only: [:create, :update, :destroy, :show]
    resources :references, only: [:create]
    resources :ratings, only: [:create]
    resources :student_attributes, only: [:create, :destroy, :show, :update]

    root to: "application#introduction"

    #User Routes
    post "/current_user" => 'users#get_current_user'
    post "/students" => 'users#students'
    post "/flip_professor_direction" => 'users#grab_professors'
    post "/get_professor_containing_keyword" => 'users#get_professor_containing_keyword'
    post "/filter_students" => 'users#filter_students'
    post "/user_information" => 'users#information'

    #Requirement Categories Routes
    post '/flip_direction' => 'requirement_categories#flip_direction'
    post '/get_categories' => 'requirement_categories#getcategories'
    post '/get_subcategories' => 'requirement_categories#subcategories'
    post '/flip_student_settings' => 'requirement_categories#flip_students'
    post '/get_category' => 'requirement_categories#getcategory'

    #Student Attributes Routes
    post '/get_attribute_by_user_and_subcategory' => 'student_attributes#get_attribute_by_user_and_subcategory'
    post "get_student_attributes_of_student" => 'student_attributes#get_student_attributes_of_student'

    #Projects Routes
    post '/flip_project_direction' => 'projects#grab_project'
    post "/get_projects_of_user" => 'projects#get_projects_of_user'
    post "/flip_in_progress_direction" => 'projects#grab_in_progress_project'
    post "/flip_completed_direction" => 'projects#grab_completed_project'
    post "/get_in_progress_projects_of_current_user" => 'projects#get_in_progress_projects_of_current_user'
    post "/get_completed_projects_of_current_user" => 'projects#get_completed_projects_of_current_user'
    post "/set_project_completed" => 'projects#set_project_completed'
    post "/filter_projects" => 'projects#filter_projects'
    post "/project_page_number" => 'projects#pages'

    #Project Application Routes
    post "/get_applications_of_user" => 'project_applications#get_applications_of_user'
    post "/get_applications_of_project" => 'project_applications#get_applications_of_project'
    post "/process_offer" => 'project_applications#process_offer'
    post "/get_require_administrator_approval_applications" =>  'project_applications#get_require_administrator_approval_applications'
    post "/get_project_assignments" => 'project_applications#get_project_assignments'
    post "/upload_resume" => 'project_applications#upload_resume'
    post "/flip_applications_of_user" => 'project_applications#flip_applications_of_user'

    #Project Requirement Routes
    post "/get_requirements_of_project" => 'project_requirements#get_requirements_of_project'

    #Requirement SubCategories Routes
    post "/get_all_subcategories" => 'requirement_subcategories#show_all'
    post "/get_all_attributes" => 'student_attributes#user_attributes'
    post "/student_attribute_requirement_subcategories_with_keyword" => 'requirement_subcategories#student_attribute_requirement_subcategories_with_keyword'
    post "/non_student_attribute_requirement_subcategories_with_keyword" => 'requirement_subcategories#non_student_attribute_requirement_subcategories_with_keyword'
    post "get_student_attribute_subcategories_of_project" => 'requirement_subcategories#get_student_attribute_subcategories_of_project'
    post "get_non_student_attribute_subcategories_of_project" => 'requirement_subcategories#get_non_student_attribute_subcategories_of_project'
    post "/requirement_suggestion" => "requirement_subcategories#get_subcategories_containing_keyword"

    #References Routes
    post "/get_by_project" => 'references#get_by_project'
    post "/get_reference_requests_of_professor" => 'references#get_reference_requests_of_professor'
    post "/process_reference_approval" => 'references#process_reference_approval'
    post "/add_professor_reference_text" => 'references#add_professor_reference_text'
    post "/get_by_project_application" => 'references#get_by_project_application'
    post "/get_student_approved_by_project_application" => 'references#get_student_approved_by_project_application'

    #Ratings Routes
    post "/get_ratings_of_student" => 'ratings#get_ratings_of_student'



    #URL Routing Path
    get "/*path" => redirect("/?goto=%{path}")
end