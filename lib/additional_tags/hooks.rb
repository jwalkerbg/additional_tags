module AdditionalTags
  class AdditionalTagsHookListener < Redmine::Hook::ViewListener
    render_on :view_issues_bulk_edit_details_bottom,
              partial: 'issues/tags_form_details',
              locals: { tags_form: 'issues/tags_bulk_edit' }
    render_on :view_issues_context_menu_end, partial: 'context_menus/issues_tags'
    render_on :view_issues_form_details_bottom,
              partial: 'issues/tags_form_details',
              locals: { tags_form: 'issues/tags_form' }
    render_on :view_issues_show_details_bottom, partial: 'issues/tags'
    render_on :view_issues_sidebar_planning_bottom, partial: 'issues/tags_sidebar'
    render_on :view_layouts_base_html_head, partial: 'additional_tags/html_head'
    render_on :view_reports_issue_report_split_content_right, partial: 'tags_simple'
    render_on :view_wiki_form_bottom, partial: 'tags_form_bottom'
    render_on :view_wiki_show_bottom, partial: 'tags_show'
    render_on :view_wiki_show_sidebar_bottom, partial: 'tags_sidebar'

    def controller_issues_edit_before_save(context = {})
      tags_journal context[:issue], context[:params]
    end

    def controller_issues_bulk_edit_before_save(context = {})
      tags_journal context[:issue], context[:params]
    end

    private

    def tags_journal(issue, params)
      return unless params && params[:issue] && params[:issue][:tag_list]

      issue.tags_to_journal Issue.find_by(id: issue.id)&.tag_list&.to_s,
                            issue.tag_list.to_s
    end
  end
end
