# frozen_string_literal: true

module GravatarHelper
  # https://mixandgo.com/learn/the-beginners-guide-to-rails-helpers

  def user_gravatar_tag(user)
    image_tag "#{Gravatar.url(user)}", alt: '', class: 'hvworkout__user-img'
  end

  def guest_gravatar_tag
    image_tag "#{Gravatar.url()}", alt: '', class: 'hvworkout__user-img'
  end

  def profile_gravatar_tag(user)
    content_tag :div, class: 'hvworkout__profile-gravatar' do
      link_to 'https://secure.gravatar.com/', target: '_blank', rel: 'noopener noreferrer' do
        (image_tag "#{Gravatar.url(user)}", alt: '', class: 'hvworkout__profile-gravatar-img') +
        (content_tag :div, class: 'hvworkout__profile-gravatar-link' do
          (content_tag :i, '', class: 'fas fa-edit').html_safe +
          (content_tag :span, "#{t('edit', scope: [:gravatar])}", class: 'sr-only') + " #{t('home', scope: [:gravatar])}"
        end)
      end
    end
  end
end
