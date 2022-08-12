module AdminUsers
  class CategoriesController < AdminUsers::ApplicationController
    def index
      render :index, locals: { categories: Category.order(title: :asc).includes(:rewards) }
    end

    def edit
      render :edit, locals: { category: category }
    end

    def new
      render :new, locals: { category: Category.new }
    end

    def create
      record = Category.new(category_params)

      if record.save
        redirect_to admin_users_categories_path, notice: 'Category was successfully created'
      else
        render :new, locals: { category: record }
      end
    end

    def update
      if category.update(category_params)
        redirect_to admin_users_categories_path, notice: 'Category was successfully updated.'
      else
        render :edit, locals: { category: category }
      end
    end

    def destroy
      if category.destroy
        redirect_to admin_users_categories_path, notice: 'Category was successfully destroyed.'
      else
        redirect_back fallback_location: admin_users_categories_path,
                      notice: 'This category has related rewards and cannot be destroyed'
      end
    end

    private

    def category
      @category ||= Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:id, :title)
    end
  end
end
