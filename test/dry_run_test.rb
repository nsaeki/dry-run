require 'minitest/autorun'
require 'dry_run'

module DryRun
  class A
    def foo
      raise NotImplementedError
    end
  end

  class DryRunTest < Minitest::Test
    module Refine
      refine A do
        extend DryRun
        dry_run :foo, nil, true
      end
    end

    def setup
      DryRun.dry_run_state = :dry_run
    end

    def teardown
      DryRun.dry_run_state = nil
    end

    def test_undefined_method
      assert_raises(NoMethodError) do
        Module.new do
          refine A do
            extend DryRun
            dry_run :bar
          end
        end
      end
    end

    def test_method_not_refined
      assert_raises(NotImplementedError) { A.new.foo }
    end

    using Refine

    def test_method_refined
      result = nil
      assert_output(/DRY RUN/) { result = A.new.foo }
      assert_equal true, result
    end
  end
end
