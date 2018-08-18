module Xmt
  module Core
    class Dict
      include ModelBase

      field :title
      field :sign, type: String
      field :typ

      class << self
        def types
          where(typ: nil)
        end

        def dicts(typ)
          @dict_typs ||= {}
          @dict_typs[typ.to_sym] ||= where(typ: typ).to_a
          @dict_typs[typ.to_sym]
        end

        def dict(sign, typ)
          dicts(typ).detect {|d| d.sign.to_s == sign.to_s}
        end

        def title(sign, typ)
          dict(sign, typ).try(:title)
        end

        def dicts_options(typ)
          typs = dicts(typ);
          opts ||= []
          if !typs.empty?
            typs.each do |typ|
              opts << [typ.title, typ.sign]
            end
          end
          opts
        end
      end

    end
  end
end