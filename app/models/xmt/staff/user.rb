module Xmt
  module Staff
    class User
      include ModelBase
      attr_accessor :password_confirmation

      field :username, type: String
      field :password, type: String
      field :name, type: String
      field :gender, type: String #:male, :female
      field :salt, type: String
      field :token, type: String
      field :tel, type: String
      field :email, type: String
      field :id_no, type: String
      field :hobbies, type: Array, default: []
      field :about
      field :title
      field :ftoken, type: String

      mount_uploader :avatar, SuploadUploader
      has_and_belongs_to_many :roles, class_name:'Xmt::Rbac::Role',inverse_of: nil
      has_and_belongs_to_many :groups, class_name:'Xmt::Rbac::Group',inverse_of: nil
      has_many :exam_results, :class_name => 'Xmt::Test::ExamResult', inverse_of: :user
      belongs_to :dept, :class_name => 'Xmt::Staff::Dept',required:false
      #has_one :avatar, as: :assetable, class_name: 'Ckeditor::Picture', validate: false, autosave: true

      #before_save { self.email = email && email.downcase }
      validates :username, presence: true, uniqueness: true, length: {maximum: 60}
      #validates :password, presence: true, confirmation: true, length: { minimum: 6 }
      #validates :email, length: { maximum: 60 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

      def self.find_by_token(token)
        begin
          user = Xmt::Staff::User.find_by(token: token)
        rescue
          user = Xmt::Staff::User.new
        end
        return user || Xmt::Staff::User.new
      end

      def self.find_by_principal(principal)
        begin
          user = Xmt::Staff::User.find_by(username: principal)
        rescue
          user = Xmt::Staff::User.new
        end
        return user || Xmt::Staff::User.new
      end

      def authenticate(credential = nil)
        self.password == encrypt(credential)
      end

      def encrypt(password)
        Digest::SHA1.hexdigest("--#{self.salt}--#{password}--")
      end

      def encrypt_password
        self.password ||= 'xmt~123'
        self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{self.username}--")
        self.password = encrypt(self.password)
      end

      # def remember(b)
      #   return self.token = SecureRandom.urlsafe_base64 if b
      #   self.token = nil
      # end

      # def auth_token
      #   Digest::SHA1.hexdigest(self.id.to_s)[4,18]
      #   auth_token = SecureRandom.urlsafe_base64
      # end

      set_callback(:create, :before) do |doc|
        doc.encrypt_password if :new_record?
      end

      set_callback(:update, :before) do |doc|
        doc.encrypt_password if doc.password_confirmation == doc.password
      end


    end
  end
end
