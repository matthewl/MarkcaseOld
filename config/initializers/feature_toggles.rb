require 'feature_toggle'

FT = FeatureToggle.new.tap do |ft|
  ft.for(:accepting_registrations) do
    Account.count < 50
  end

  ft.for(:importing_bookmarks) do |account_id:|
    Account.where(id: account_id, preview_features: true).exists?
  end
end
