# frozen_string_literal: true

module Stupidedi
  module Refinements

    refine String do
      # True if the string is `empty?` or contains all whitespace
      #
      # @example
      #   "abc".blank?    #=> false
      #   "   ".blank?    #=> true
      #   "".blank?       #=> true
      #
      def blank?
        self !~ /\S/
      end unless method_defined?(:blank?)

      def present?
        self =~ /\S/
      end unless method_defined?(:present?)
    end

    refine NilClass do
      # Always `true`. Note this overrides {Object#blank?} which returns false.
      #
      # @example
      #   nil.blank?    #=> true
      #
      def blank?
        true
      end unless method_defined?(:blank?)

      def present?
        false
      end unless method_defined?(:present?)
    end

    refine Object do
      # Always `false`. Note that {NilClass#blank?} is overridden to return `true`
      #
      # @example
      #   false.blank?    #=> false
      #   100.blank?      #=> false
      #
      def blank?
        false
      end unless method_defined?(:blank?)

      def present?
        true
      end unless method_defined?(:present?)
    end

  end
end
