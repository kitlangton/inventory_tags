module Tags
  class ExcelImportsController < ApplicationController
    before_action :authorize_tag

    def new
    end

    def confirm
      uploaded_file = params[:import][:excel_doc].path
      @tags = ExcelTagsParser.new(uploaded_file).parse.create_tags
    end

    def create
      success, @tags = CreateTags.new.call(params)
      if success
        flash[:success] = 'Your tags have been created successfully!'
        if @tags.any? { |t| t.color.try(:complete) == false }
          redirect_to confirm_colors_url
        else
          redirect_to tags_url
        end
      else
        render :confirm
      end
    end

    def save_excel
      success = UpdateColors.new.call(params)[0]
      if success
        flash[:success] = 'Colors have been assigned successfully!.'
        redirect_to colors_url
      else
        redirect_to confirm_colors_path
      end
    end

    def authorize_tag
      authorize Tag, :create?
    end
  end
end
