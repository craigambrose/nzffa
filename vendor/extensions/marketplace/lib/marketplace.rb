module Marketplace
  include Radiant::Taggable
  desc 'Tags to load marketplace into the current page'

  tag 'adverts' do |tag|
    %{<div id="adverts"></div>
      <script type="text/javascript">$('#adverts').load('#{adverts_path}')</script>}
  end

  tag 'my_adverts' do |tag|
    %{<div id="adverts"></div>
      <script type="text/javascript">$('#adverts').load('#{my_adverts_adverts_path}')</script>}
  end

  tag 'edit_company_listing' do |tag|
    %{<div id="adverts"></div>
      <script type="text/javascript">$('#adverts').load('#{edit_company_listing_adverts_path}')</script>}
  end

  tag 'new_advert' do |tag|
    %{<div id="adverts"></div>
      <script type="text/javascript">$('#adverts').load('#{new_advert_path}')</script>}
  end

  tag 'company_signup' do |tag|
    %{<div id="adverts"></div>
      <script type="text/javascript">$('#adverts').load('#{signup_adverts_path}')</script>}
  end

  tag 'newsletter_signup' do |tag|
    %{<div id="adverts"></div>
      <script type="text/javascript">$('#adverts').load('#{newsletter_signup_adverts_path}')</script>}
  end

end
