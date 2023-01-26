module Banregio
  module MovementResponse
    def self.new(raw_response)
      Response.new(raw_response)
    end

    class Response
      attr_reader :raw_movement

      KEY_METHOD_RELATIONS = {
        "movimientoCuenta"=>"movimiento_cuenta",
        "numeroMovimiento"=>"numero_movimiento",
        "consecutivoMovimiento"=>"consecutivo_movimiento",
        "movimientoNatural"=>"movimiento_natural",
        "fechaVal"=>"fecha_val",
        "descripcion"=>"descripcion",
        "referencia"=>"referencia",
        "referenciaExterna"=>"referencia_externa",
        "referenciaBanco"=>"referencia_banco",
        "referenciaPersona"=>"referencia_persona",
        "transaccion"=>"transaccion",
        "usuario.numero"=>"usuario_numero",
        "tipoMovimiento"=>"tipo_movimiento",
        "medioTransaccion"=>"medio_transaccion",
        "fechaMovimiento"=>"fecha_movimiento",
        "giroMovimiento"=>"giro_movimiento",
        "fechaSistema"=>"fecha_sistema",
        "movimientoTipoDescripcion"=>"movimiento_tipo_descripcion",
        "cantidadMovimiento"=>"cantidad_movimiento",
        "nombreComercioMovimiento"=>"nombre_comercio_movimiento"
      }

      def initialize(raw_movement)
        @raw_movement = raw_movement
      end

      def inspect
        "<#{self.class.to_s} clave_de_rastreo=#{clave_de_rastreo}>"
      end

      def ==(other)
        self.class == other.class && raw_movement == other.raw_movement
      end

      KEY_METHOD_RELATIONS.each do |key, method_name|
        define_method method_name do
          raw_movement.dig(*key.split("."))
        end
      end

      def numero_de_referencia
        _referencia.numero
      end

      def concepto_de_pago_del_spei
        _referencia.concepto_de_pago_del_spei
      end

      def clave_de_rastreo
        referencia_externa
      end

      def id_institucion
        _institucion.id
      end

      def nombre_institucion
        _institucion.nombre
      end

      def cuenta_persona
        _persona.cuenta
      end

      def rfc_persona
        _persona.rfc.sub("RFC:", "").strip
      end

      def nombre_persona
        _persona.nombre
      end

      private

      def _persona
        @persona ||= Persona.from_response(self)
      end

      def _institucion
        @institucion ||= Institucion.from_response(self)
      end

      def _referencia
        @referencia ||= Referencia.from_response(self)
      end
    end

    class Referencia < Struct.new(:numero, :concepto_de_pago_del_spei)
      def self.from_response(response)
        new(*response.referencia.split("|").map(&:strip))
      end
    end

    class ReferenciaBanco < Struct.new(:institucion_id, :institucion_nombre, :cuenta)
      def self.from_response(response)
        new(*response.referencia_banco.split("|").map(&:strip))
      end
    end

    class ReferenciaPersona < Struct.new(:rfc, :nombre)
      def self.from_response(response)
        new(*response.referencia_persona.split("|").map(&:strip))
      end
    end

    class Institucion < Struct.new(:id, :nombre)
      def self.from_response(response)
        referencia_banco = ReferenciaBanco.from_response(response)
        new(referencia_banco.institucion_id, referencia_banco.institucion_nombre)
      end
    end

    class Persona < Struct.new(:cuenta, :nombre, :rfc)
      def self.from_response(response)
        referencia_persona = ReferenciaPersona.from_response(response)
        referencia_banco = ReferenciaBanco.from_response(response)
        new(referencia_banco.cuenta, referencia_persona.nombre, referencia_persona.rfc)
      end
    end
  end
end
