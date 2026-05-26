ActiveAdmin.register Post do
  menu parent: "Content", priority: 1
  permit_params :title, :slug, :summary, :body, :status, :category,
                :published_at, :author_id

  controller do
    defaults finder: :find_by_slug!
  end

  filter :title
  filter :status, as: :select, collection: %w[draft published archived]
  filter :category
  filter :author

  index do
    selectable_column
    column :title
    column :slug
    column :status
    column :author
    column :published_at
    actions
  end

  form do |f|
    f.inputs "Post" do
      f.input :title
      f.input :slug, hint: "Auto-generated from the title if left blank"
      f.input :summary
      f.input :body, as: :text, input_html: { rows: 16 },
              hint: "HTML allowed. (Trix WYSIWYG editor lands in Phase 2.)"
      f.input :status, as: :select, collection: %w[draft published archived]
      f.input :category
      f.input :published_at, as: :datepicker
      f.input :author, collection: AdminUser.all
    end
    f.actions
  end

  # Newly-created posts default to the current admin as author.
  before_create do |post|
    post.author ||= current_admin_user
  end
end
