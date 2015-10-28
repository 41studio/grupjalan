class AddCommentsCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer, default: 0

    Post.all.each do |post|
      post.update(comments_count: post.comments.count)
    end
  end

  def down
    remove_column :posts, :comments_count
  end
end
