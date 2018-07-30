class FormSelect < Settingslogic
  source "#{Rails.root}/config/select.yml"
  namespace Rails.env
end