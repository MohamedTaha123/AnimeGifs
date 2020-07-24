#Rails.application.config.session_store :active_record_store, :key => '_my_app_session'
Rails.application.config.session_store :cookie_store, expire_after: 14.days