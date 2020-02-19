unit DistrictInsert.Controller;

interface

uses District.Controller.Interf, Districts.Model.Interf,
  TGERBAIRRO.Entity.Model, System.SysUtils;

type
  TDistrictInsertController = class(TInterfacedObject,
    iDistrictInsertController)
  private
    FDistrictModel: iDistrictModel;

    FDescription: string;
    FCityId: string;
    FZipCode: string;

    function getDistrictId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iDistrictInsertController;

    function districtModel(AValue: iDistrictModel): iDistrictInsertController;

    function description(AValue: string): iDistrictInsertController;
    function cityId(AValue: string): iDistrictInsertController;
    function zipCode(AValue: string): iDistrictInsertController;

    procedure save;
  end;

implementation

{ TDistrictInsertController }

function TDistrictInsertController.cityId(AValue: string): iDistrictInsertController;
begin
  Result := Self;
  FCityId := AValue;
end;

constructor TDistrictInsertController.Create;
begin

end;

function TDistrictInsertController.description(AValue: string)
  : iDistrictInsertController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TDistrictInsertController.Destroy;
begin

  inherited;
end;

function TDistrictInsertController.districtModel(AValue: iDistrictModel)
  : iDistrictInsertController;
begin
  Result := Self;
  FDistrictModel := AValue;
end;

function TDistrictInsertController.getDistrictId: Integer;
begin
  if FDistrictModel.DAO.Find.Count <> 0 then  begin
    Result := FDistrictModel.DAO.FindWhere('', 'DISTRICTID desc').Last.DISTRICTID + 1;
  end else begin
    Result := 1;
  end;
end;

class function TDistrictInsertController.New: iDistrictInsertController;
begin
  Result := Self.Create;
end;

procedure TDistrictInsertController.save;
begin
  FDistrictModel.Entity(TTMNGDISTRICT.Create);

  FDistrictModel.Entity.DISTRICTID  := getDistrictId;
  FDistrictModel.Entity.DESCRIPTION := FDescription;
  FDistrictModel.Entity.CITYID      := FCityId;
  FDistrictModel.Entity.ZIPCODE     := FZipCode;
  FDistrictModel.Entity.CREATEDAT   := Now;
  FDistrictModel.Entity.UPDATEDAT   := Now;

  FDistrictModel.DAO.Insert(FDistrictModel.Entity);
end;

function TDistrictInsertController.zipCode(AValue: string): iDistrictInsertController;
begin
  Result := Self;
  FZipCode := AValue;
end;

end.
