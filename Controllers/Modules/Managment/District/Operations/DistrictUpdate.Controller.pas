unit DistrictUpdate.Controller;

interface

uses District.Controller.Interf, TGERBAIRRO.Entity.Model,
  Districts.Model.Interf, System.SysUtils;

type
  TDistrictUpdateController = class(TInterfacedObject,
    iDistrictUpdateController)
  private
    FDistrictModel: iDistrictModel;
    FSelectedRecord: TTGERBAIRRO;

    FDescricao: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iDistrictUpdateController;

    function districtModel(AValue: iDistrictModel): iDistrictUpdateController;
    function selectedDistrict(AValue: TTGERBAIRRO): iDistrictUpdateController;

    function description(AValue: string): iDistrictUpdateController;
    procedure save;
  end;

implementation

{ TDistrictUpdateController }

constructor TDistrictUpdateController.Create;
begin

end;

function TDistrictUpdateController.description(AValue: string): iDistrictUpdateController;
begin
  Result := Self;
  FDescricao := AValue;
end;

destructor TDistrictUpdateController.Destroy;
begin

  inherited;
end;

function TDistrictUpdateController.districtModel(AValue: iDistrictModel): iDistrictUpdateController;
begin
  Result := Self;
  FDistrictModel := AValue;
end;

class function TDistrictUpdateController.New: iDistrictUpdateController;
begin
  Result := Self.Create;
end;

procedure TDistrictUpdateController.save;
begin
    FDistrictModel.DAO.Modify(FSelectedRecord);

    FSelectedRecord.DESCRICAO := FDescricao;

    FDistrictModel.DAO.Update(FSelectedRecord);
end;

function TDistrictUpdateController.selectedDistrict(AValue: TTGERBAIRRO): iDistrictUpdateController;
begin
 Result := Self;
 FSelectedRecord := AValue;
end;

end.
