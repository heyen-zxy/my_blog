module ApplicationHelper

  def markdown(text)
    options = {
        :autolink => true,
        :space_after_headers => true,
        :fenced_code_blocks => true,
        :no_intra_emphasis => true,
        :hard_wrap => true,
        :strikethrough =>true
    }
    markdown = Redcarpet::Markdown.new(HTMLWithCodeRay,options)
    markdown.render(text).html_safe
  end


  class HTMLWithCodeRay < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, :ruby).div(:line_numbers => :table)
    end
  end


  def get_admin_nav
    case params[:controller].downcase
      when 'admins/blogs'
        '博客'
      when 'admins/contacts'
        '联系'
      when 'admins/categories'
        '分类'
      when 'admins/tags'
        '标签'
    end
  end

  def get_nav
    if params[:controller].downcase == 'blogs'
      case params[:action]
        when 'about'
        '关于我'
        when 'contact'
          '联系'
        else
          '博客'
      end

    end
  end

  def nav_to(title, url, active=false, opts={})
    content_tag :li, class: active ? 'active' : nil do
      content_tag :a, content_tag(:i, nil, opts) + content_tag(:span, title), href: url
    end
  end



end
