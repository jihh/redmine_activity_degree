module ActivityDegree
  module WelcomeHelperPatch
    extend ActiveSupport::Concern

    def week_range
      @week_range ||= (Date.today - 6.days) .. Date.today
    end

    def created_issues_counter
      @created_issue_counter ||= Issue.where("DATE(#{Issue.table_name}.created_on) BETWEEN ? AND ?", week_range.first, week_range.last).group("DATE(#{Issue.table_name}.created_on)").count
    end

    def closed_issues_counter
      @closed_issue_counter ||= Issue.where("DATE(#{Issue.table_name}.closed_on) BETWEEN ? AND ?", week_range.first, week_range.last).group("DATE(#{Issue.table_name}.closed_on)").count
    end

    def updated_issues_counter
      @updated_issues_counter ||= Journal.where(:journalized_type => 'Issue').where("DATE(#{Journal.table_name}.created_on) BETWEEN ? AND ?", week_range.first, week_range.last).group("DATE(#{Journal.table_name}.created_on)").count
    end

    def top_active_projects
      unless @top_active_projects
        hash = Journal.joins(:issue).
            where("DATE(#{Journal.table_name}.created_on) BETWEEN ? AND ?", week_range.first, week_range.last).
            group("#{Issue.table_name}.project_id").count
        Issue.where("DATE(#{Issue.table_name}.created_on) BETWEEN ? AND ?", week_range.first, week_range.last).
            group("#{Issue.table_name}.project_id").count.each do |project_id, counter|
          hash[project_id] ||= 0
          hash[project_id] += counter
        end
        @top_active_projects = hash.transform_keys { |key| Project.find(key) }.to_a.sort_by! { |r| r.last }.reverse[0..9]
      end
      @top_active_projects
    end
  end
end

if WelcomeHelper.included_modules.exclude? ActivityDegree::WelcomeHelperPatch
  WelcomeHelper.send :include, ActivityDegree::WelcomeHelperPatch
end