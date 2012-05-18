# == Schema Information
# Schema version: 20120513044545
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  username               :string(255)
#  phone                  :string(255)
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#

require 'spec_helper'

describe User do
  it "should have many events" do
    User.new.should respond_to(:events)
  end

  it "should not allow encrypted_password to be changed by mass_assignment" do
    expect do
      User.new(encrypted_password: "password")
    end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end

  it "should allow token authentication" do
    User.new.should respond_to(:authentication_token)
  end

end
