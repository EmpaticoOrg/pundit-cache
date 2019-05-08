require 'test_helper'

module Pundit
  class CacheTest < Minitest::Test
    ApplicationPolicy = Struct.new(:user, :record) do
      extend Pundit::Cache
    end

    User = Struct.new(:id) do
      def to_global_id
        "gid://myapp/User/#{id.to_s}"
      end
    end

    Record = Struct.new(:id) do
      def to_global_id
        "gid://myapp/Record/#{id.to_s}"
      end
    end

    class LuckyPolicy < ApplicationPolicy
      def lucky?
        rand(2) == 1
      end
      cache :lucky?
    end

    class UserPolicy < ApplicationPolicy
      def even?
        user && user.id.even?
      end
      cache :even?
    end

    class RecordPolicy < ApplicationPolicy
      def odd?
        record && record.id.odd?
      end
      cache :odd?
    end

    def test_caching
      user = User.new(1)
      record = Record.new(9)

      assert_equal 1, 100.times.map{ LuckyPolicy.new(user, record).lucky? }.uniq.length
    end

    def test_varying_user
      refute UserPolicy.new(User.new(1), Record.new(9)).even?
      assert UserPolicy.new(User.new(2), Record.new(9)).even?
    end

    def test_varying_record
      assert RecordPolicy.new(User.new(1), Record.new(7)).odd?
      refute RecordPolicy.new(User.new(1), Record.new(8)).odd?
    end
  end
end
