# -- encoding: utf-8 --
require 'activity_degree'
Redmine::Plugin.register :redmine_activity_degree do
  name 'Redmine Activity Degree plugin'
  author 'Haihan Ji'
  description '这个插件提供了若干显示活跃状态的图表'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  settings :default => {
               'display_weekly_issue_stack' => '0',
               'display_top_active_projects' => '0'
           }, :partial => 'settings/activity_degree'
end
