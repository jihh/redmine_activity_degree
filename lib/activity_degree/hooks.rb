module ActivityDegree
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_layouts_base_html_head, :partial => 'activity_degree/base_html_head'
    render_on :view_welcome_index_left, :partial => 'activity_degree/welcome_index_left'
    render_on :view_welcome_index_right, :partial => 'activity_degree/welcome_index_right'
  end
end