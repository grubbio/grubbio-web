module ApplicationHelper
  def flash_alert_messages!
    return "" unless flash[:alert]

    html = <<-HTML
    <div id="flash_alert" class="notification important fade in">
      <!--header class="notify-header">
        <h4 class="notify-heading">Alert</h4>
      </header -->
      <section class="notify-content">
        <p>#{flash[:alert]}</p>
      </section>
      <a class="close" data-dismiss="alert" href="#">&times;</a>
    </div>
    HTML

    html.html_safe
  end

  def flash_error_messages!
    return "" unless flash[:error]

    html = <<-HTML
    <div id="flash_error" class="notification danger fade in">
      <!-- header class="notify-header">
        <h4 class="notify-heading">Error:</h4>
      </header -->
      <section class="notify-content">
        <p>#{flash[:error]}</p>
      </section>
      <a class="close" data-dismiss="alert" href="#">&times;</a>
    </div>
    HTML

    html.html_safe
  end

  def flash_notice_messages!
    return "" unless flash[:notice]

    html = <<-HTML
    <div id="flash_notice" class="notification success fade in">
      <!-- header class="notify-header">
        <h5 class="notify-heading">Notice:</h5>
      </header -->
      <section class="notify-content">
        <p>#{flash[:notice]}</p>
      </section>
      <a class="close" data-dismiss="alert" href="#">&times;</a>
    </div>
    HTML

    html.html_safe
  end

  def flash_warning_messages!
    return "" unless flash[:warning]

    html = <<-HTML
    <div id="flash_notice" class="notification warning fade in">
      <!-- header class="notify-header">
        <h5 class="notify-heading">Notice:</h5>
      </header -->
      <section class="notify-content">
        <p>#{flash[:warning]}</p>
      </section>
      <a class="close" data-dismiss="alert" href="#">&times;</a>
    </div>
    HTML

    html.html_safe
  end
end
