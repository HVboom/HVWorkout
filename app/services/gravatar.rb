class Gravatar
  # https://en.gravatar.com/site/implement/images/

  EMAIL =           :email
  HOST =            'https://secure.gravatar.com/avatar/'
  IMAGE_TYPE =      '.png'
  GUEST =           'guest@hvboom.ch'
  RATING =          'g'
  DEFAULT =         'mp'
  SIZE =            '128'
  ALLOWED_OPTIONS = [:size]

  class << self
    def url(user_or_email = GUEST, options = {})
      base_url(user_or_email) + '?' + sanitize_options(options).to_query
    end


    private

    def base_url(user_or_email)
      HOST + gravatar_id(email(user_or_email)) + IMAGE_TYPE
    end

    def email(user_or_email)
      GUEST if user_or_email.blank?

      if user_or_email.respond_to?(EMAIL)
        user_or_email.send(EMAIL)
      else
        user_or_email.to_s
      end
    end

    def gravatar_id(email)
      Digest::MD5::hexdigest(email.strip.downcase)
    end

    def sanitize_options(options)
      {
        rating:  RATING,
        default: DEFAULT,
        size:    SIZE
      }.merge(options.extract!(ALLOWED_OPTIONS))
    end
  end
end

