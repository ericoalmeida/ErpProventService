unit DistrictDuplicate.Controller;

interface

uses District.Controller.Interf, Districts.Model.Interf,
  TMNGDISTRICT.Entity.Model, System.SysUtils;

type
  TDistrictDuplicateController = class(TInterfacedObject,
    iDistrictDuplicateController)
  private
    FDistrictModel: iDistrictModel;

    FDescription: string;
    FCity: string;
    FZipCode: string;

    function getDistrictId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iDistrictDuplicateController;

    function districtModel(AValue: iDistrictModel)
      : iDistrictDuplicateController;

    function description(AValue: string): iDistrictDuplicateController;
    function cityId(AValue: string): iDistrictDuplicateController;
    function zipCode(AValue: string): iDistrictDuplicateController;

    procedure save;
  end;

implementation

{ TDistrictDuplicateController }

function TDistrictDuplicateController.cityId(AValue: string)
  : iDistrictDuplicateController;
begin
  Result := Self;
  FCity := AValue;
end;

constructor TDistrictDuplicateController.Create;
begin

end;

function TDistrictDuplicateController.description(AValue: string)
  : iDistrictDuplicateController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TDistrictDuplicateController.Destroy;
begin

  inherited;
end;

function TDistrictDuplicateController.getDistrictId: Integer;
begin
  if FDistrictModel.DAO.Find.Count <> 0 then
  begin
    Result := FDistrictModel.DAO.FindWhere('', 'DISTRICTID desc')
      .Last.DISTRICTID + 1;
  end
  else
  begin
    Result := 1;
  end;
end;

function TDistrictDuplicateController.districtModel(AValue: iDistrictModel)
  : iDistrictDuplicateController;
begin
  Result := Self;
  FDistrictModel := AValue;
end;

class function TDistrictDuplicateController.New: iDistrictDuplicateController;
begin
  Result := Self.Create;
end;

procedure TDistrictDuplicateController.save;
begin
  FDistrictModel.Entity(TTMNGDISTRICT.Create);

  FDistrictModel.Entity.DISTRICTID  := getDistrictId;
  FDistrictModel.Entity.DESCRIPTION := FDescription;
  FDistrictModel.Entity.CITYID      := FCity;
  FDistrictModel.Entity.ZIPCODE     := FZipCode;
  FDistrictModel.Entity.CREATEDAT   := Now;
  FDistrictModel.Entity.UPDATEDAT   := Now;

  FDistrictModel.DAO.Insert(FDistrictModel.Entity);
end;

function TDistrictDuplicateController.zipCode(AValue: string)
  : iDistrictDuplicateController;
begin
  Result := Self;
  FZipCode := AValue;
end;

end.
