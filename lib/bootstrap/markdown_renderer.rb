module Bootstrap
  class MarkdownRenderer < Redcarpet::Render::HTML
    def table(header, body)
      %{<table class="table table-bordered">
          #{header}
          #{body}
        </table>}
    end
  end
end