Docs::Engine.routes.draw do
  scope "docs" do
    Docs.route(self)
  end
end