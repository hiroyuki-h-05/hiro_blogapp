class Apps::ProfilesController < Apps::ApplicationController

  def show
    @profile = current_user.profile
  end

  def edit

    # その1
    # if current_user.profile
    #   @profile = current_user.profile
    # else
    #   @profile = current_user.build_profile # has_oneの場合の記述(railsの規約)
    # end

    # その2
    # @profile = current_user.profile || curent_user.build_profile

    # その3(user.rbに定義したメソッドを使用)
    @profile = current_user.prepare_profile

  end

  def update

    @profile = current_user.prepare_profile
    @profile.assign_attributes(profile_params)

    if @profile.save
      redirect_to profile_path, notice: 'プロフィールを更新しました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end

  end


  private

  def profile_params
    params.require(:profile).permit(
      :nickname,
      :introduction,
      :gender,
      :birthday,
      :subscribed,
      :avatar
    )
  end

end