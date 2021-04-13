module ApplicationHelper
  def download_link(link)
    l = link.split(/upload/)
    l[0] + 'upload/fl_attachment' + l[1]
  end
end
