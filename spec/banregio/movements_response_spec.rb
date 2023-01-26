module Banregio
  RSpec.describe MovementsResponse do
    let(:raw_movement) do
      {"movimientoCuenta"=>"220916390017",
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
    end
    
    let(:raw_response) do
      {"header"=>{"sequence"=>"0e121ee0-4180-11eb-a3d6-0050568f5029"},
       "body"=>{"response"=>{"code"=>"200", "description"=>[raw_movement]}}}
    end

    describe ".new" do
      it "is built from the raw response" do
        response = described_class.new(raw_response)
        expect(response).to eq MovementsResponse.new(raw_response)
      end
    end

    describe "#all" do
      it "returns a list of movements" do
        response = described_class.new(raw_response)
        expect(response.all).to eq [MovementResponse.new(raw_movement)]
      end
    end
  end
end
