module Banregio
  RSpec.describe MovementResponse do
    RAW_MOVEMENT = {
      "movimientoCuenta"=>"220916390017",
      "numeroMovimiento"=>"2680240086",
      "consecutivoMovimiento"=>"000001",
      "movimientoNatural"=>"1",
      "fechaVal"=>"2020-12-17",
      "descripcion"=>"AIF4544 SPEI, SANTANDER, 014022200085491084, briq.mx spei, 058-17/12/2020/17-027AIF4544, 1234567, PRUEBA SPEI BRIQ.MX, SPEI A CARGO (PORTABILIDAD DE NÓMINA)                                                                                              ",
      "referencia"=>"1234567|PRUEBA SPEI BRIQ.MX           ",
      "referenciaExterna"=>"058-17/12/2020/17-027AIF4544",
      "referenciaBanco"=>"40014     |SANTANDER|014022200085491084",
      "referenciaPersona"=>"RFC:                   |briq.mx spei",
      "transaccion"=>"PUC",
      "usuario"=>{"numero"=>"012873"},
      "tipoMovimiento"=>"400000",
      "medioTransaccion"=>"SUC",
      "fechaMovimiento"=>"2020-12-17T00:00:00.000",
      "giroMovimiento"=>"    ",
      "fechaSistema"=>"2020-12-17T09:05:00.000",
      "movimientoTipoDescripcion"=>"Cargo por SPEUA enviado",
      "cantidadMovimiento"=>"3.0000",
      "nombreComercioMovimiento"=>"                                      "}

    def response_with(raw_response)
      described_class.new(raw_response)
    end

    let(:raw_movement) { RAW_MOVEMENT }
    {
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
    }.each do |key, method_name|
      describe "##{method_name}" do
        it "reads the key #{key}" do
          value = raw_movement.dig(*key.split("."))
          response = response_with(raw_movement)
          expect(response.send(method_name)).to eq value
        end
      end
    end

    describe "#numero_de_referencia" do
      it "is the first value on the key 'referencia'" do
        response = response_with(raw_movement)
        expect(response.numero_de_referencia).to eq "1234567"
      end
    end

    describe "#concepto_de_pago_del_spei" do
      it "is the second value on the key 'referencia'" do
        response = response_with(raw_movement)
        expect(response.concepto_de_pago_del_spei).to eq "PRUEBA SPEI BRIQ.MX"
      end
    end

    describe "#clave_de_rastreo" do
      it "is the same as 'referencia externa'" do
        response = response_with(raw_movement)
        expect(response.clave_de_rastreo).to eq "058-17/12/2020/17-027AIF4544"
      end
    end

    describe "#id_institucion" do
      it "is the first value on 'referencia banco'" do
        response = response_with(raw_movement)
        expect(response.id_institucion).to eq "40014"
      end
    end

    describe "#nombre_institucion" do
      it "is the second value on 'referencia banco'" do
        response = response_with(raw_movement)
        expect(response.nombre_institucion).to eq "SANTANDER"
      end
    end

    describe "#cuenta_persona" do
      it "is the third value on 'referencia banco'" do
        response = response_with(raw_movement)
        expect(response.cuenta_persona).to eq "014022200085491084"
      end
    end

    describe "#rfc_persona" do
      describe "is the first value on 'referencia persona'" do
        example "empty" do
          response = response_with(raw_movement)
          expect(response.rfc_persona).to eq ""
        end

        example "with a value" do
          raw_movement = RAW_MOVEMENT.merge("referenciaPersona"=>"RFC: SERT880910MR8 |briq.mx spei")
          response = response_with(raw_movement)
          expect(response.rfc_persona).to eq "SERT880910MR8"
        end
      end
    end

    describe "#nombre_persona" do
      it "is the second value on 'referencia persona'" do
        response = response_with(raw_movement)
        expect(response.nombre_persona).to eq "briq.mx spei"
      end
    end
  end
end