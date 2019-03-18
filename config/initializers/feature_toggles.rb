require 'feature_toggle'

FT = FeatureToggle.new.tap do |ft|
  ft.for(:accepting_registrations) do
    Account.count < 50
  end
end
