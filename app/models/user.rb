class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_create :create_activation_digest
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, presence: true,
  length: { maximum: 50 }
  validates :email, presence: true,
  length: {maximum: 255},
  format: {with: VALID_EMAIL_REGEX},
  uniqueness: { case_sensitive: false }


  #/////////////////////////////
  has_secure_password
  validates :password, presence: true,
    length: { minimum: 6 }, allow_nil: true

   scope :normal_user, -> {where(status: 'normal')}
   scope :off_user, -> {where(status: 'off')}
   scope :ill_user, -> {where(status: 'sick')}

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST:
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost:cost)
    #code
  end
  def self.new_token
    SecureRandom.urlsafe_base64
  end
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
    #code
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token),
    reset_sent_at: Time.zone.now)
  end
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
    #code
  end

    def self.line
      where(line: true)
    end
    def self.grill
      where(grill: true)
    end
    def self.cashier
      where(cashier: true)
    end
    def self.baking
      where(baking: true)
    end
    def self.coldpress
      where(coldpress: true)
    end
    def self.juice
      where(juice: true)
    end
  private
    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
      #code
    end

end
