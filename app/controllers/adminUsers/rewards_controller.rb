require 'csv'
module AdminUsers
  class RewardsController < AdminUsers::ApplicationController
    def index
      render :index, locals: { rewards: Reward.order(created_at: :desc).with_attached_photo.includes(:category) }
    end

    def edit
      render :edit, locals: { reward: reward }
    end

    def show
      render :show, locals: { reward: reward }
    end

    def new
      render :new, locals: { reward: Reward.new }
    end

    def create
      record = Reward.new(reward_params)

      if record.save
        redirect_to admin_users_reward_path(record), notice: 'Reward was successfully created'
      else
        render :new, locals: { reward: record }
      end
    end

    def update
      if reward.update(reward_params)
        redirect_to admin_users_rewards_path, notice: 'Reward was successfully updated.'
      else
        render :edit, locals: { reward: reward }
      end
    end

    def destroy
      unless reward.destroy
        redirect_back fallback_location: admin_users_rewards_path,
                      alert: 'Something went wrong'
      end

      redirect_to admin_users_rewards_path, notice: 'Reward was successfully destroyed.'
    end

    def upload_csv
      render :upload_csv
    end

    def import_rewards
      rewards_importer = RewardsImporter.new(params[:file])

      unless rewards_importer.import
        redirect_back fallback_location: upload_csv_admin_users_rewards_path,
                      alert: rewards_importer.errors.join(' / ')
        return
      end

      redirect_to admin_users_rewards_path, notice: 'Rewards imported successfully'
    end

    private

    def reward
      @reward ||= Reward.find(params[:id])
    end

    def reward_params
      params.require(:reward).permit(:id, :title, :description, :price, :category_id, :photo)
    end
  end
end
