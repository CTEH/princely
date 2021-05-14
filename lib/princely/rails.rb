require 'princely/pdf_helper'

if Mime::Type.lookup_by_extension(:pdf) != 'application/pdf'
  Mime::Type.register 'application/pdf', :pdf
end

if defined?(Rails)
  if Rails::VERSION::MAJOR >= 6
    ActiveSupport.on_load(:action_controller_base) do
      ActionController::Base.send(:prepend, Princely::PdfHelper)
    end
  elsif Rails::VERSION::MAJOR >= 5
    ActionController::Base.send(:prepend, Princely::PdfHelper)
  else
    ActionController::Base.send(:include, Princely::PdfHelper)
  end

  if Rails::VERSION::MAJOR >= 6
    ActiveSupport.on_load(:action_controller_base) do
      ActionController::Base.send(:include, Princely::AssetSupport)
    end
  elsif (Rails::VERSION::MAJOR == 3 && Rails::VERSION::MINOR > 0) ||
   (Rails::VERSION::MAJOR >= 4)
    ActionController::Base.send(:include, Princely::AssetSupport)
  end
end
