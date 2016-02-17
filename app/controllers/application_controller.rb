#include MongodbLogger::Base

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :authenticate_user!
  before_filter :before_filter
  
  def before_filter
    set_meta_tags site: 'My Great SEO Title'
    set_meta_tags title: 'General Title'
    set_meta_tags description: "All text about keywords, other keywords"
    set_meta_tags author: [ "Dmytro Shteflyuk", "John Doe" ]
    set_meta_tags twitter: {
      card: "Check Check",
      site: "@silverash"
    }
    set_meta_tags og: {
      title:    'Two structured image properties',
      type:     'website',
      url:      'view-source:http://examples.opengraphprotocol.us/image-array.html',
      image:    [{
        _: 'http://examples.opengraphprotocol.us/media/images/75.png',
        width: 75,
        height: 75,
      },
      {
        _: 'http://examples.opengraphprotocol.us/media/images/50.png',
        width: 50,
        height: 50,
      }]
    }
    set_meta_tags foo: {
      bar: "lorem",
      baz: {
        qux: "ipsum"
      }
    }
    set_meta_tags publisher: "http://yourgplusprofile.com/profile/url"
    set_meta_tags author: "http://yourgplusprofile.com/profile/url"
    
    set_meta_tags icon: '/favicon.ico'
    set_meta_tags icon: '/favicon.png', type: 'image/png'
    set_meta_tags icon: [
      { href: '/images/icons/icon_96.png', sizes: '32x32 96x96', type: 'image/png' },
      { href: '/images/icons/icon_itouch_precomp_32.png', rel: 'apple-touch-icon-precomposed', sizes: '32x32', type: 'image/png' },
    ]
    
    set_meta_tags nofollow: true
    set_meta_tags noindex: true
    
    #puts Bitly.client.shorten('http://www.google.com')
  end
end
