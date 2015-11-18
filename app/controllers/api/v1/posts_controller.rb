class Api::V1::PostsController < BaseApiController
  before_action :set_group

  def create
    render json: @group, status: :ok
  end

  private
    def set_group
      @group = Group.find(params[:group_id])
    end
end
