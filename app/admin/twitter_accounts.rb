ActiveAdmin.register TwitterAccount do

  scope :all, :default => true
  scope :publishers
  scope :consumers

  index do
    column "Image", :image_url do |account|
      image_tag(account.image_url, :height => 24, :width => 24) if account.image_url
    end
    column :username
    column "Twitter ID", :user_id
    column :can_publish
    column :real_name
    column :followers
    column "Actions" do |account|
      link_to("View", admin_twitter_account_path(account), :class => "member_link view_link") +
        link_to("Fetch Tweets", fetch_tweets_admin_twitter_account_path(account), :method => :post, :class => "member_link") +
        link_to("Update", update_data_admin_twitter_account_path(account), :method => :post, :class => "member_link")
    end
  end

  config.sort_order = "followers_desc"

  member_action :fetch_tweets, :method => :post do
    account = TwitterAccount.find(params[:id])
    account.fetch_tweets
    redirect_to url_for(:action => :show), :notice => "Fetched tweets of #{account.real_name} from Twitter."
  end

  member_action :update_data, :method => :post do
    account = TwitterAccount.find(params[:id])
    account.update_user_data
    redirect_to url_for(:action => :show), :notice => "Updated user data of #{account.real_name} from Twitter."
  end
end