unit CityUpdate.Controller;

interface

uses City.Controller.Interf, City.Model.Interf, TMNGCITY.Entity.Model,
  System.SysUtils;

type
  TCityUpdateController = class(TInterfacedObject, iCityUpdateController)
  private
    FCityModel: ICityModel;
    FSelectedRecord: TTMNGCITY;

    FName: string;
    FZipCode: string;
    FIBGECode: Integer;
    FStateId: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iCityUpdateController;

    function cityModel(AValue: ICityModel): iCityUpdateController;
    function selectedRecord(AValue: TTMNGCITY): iCityUpdateController;

    function name(AValue: string): iCityUpdateController;
    function zipCode(AValue: string): iCityUpdateController;
    function ibgeCode(AValue: string): iCityUpdateController;
    function stateId(AValue: string): iCityUpdateController;

    procedure save;
  end;

implementation

{ TCityUpdateController }

function TCityUpdateController.cityModel(AValue: ICityModel)
  : iCityUpdateController;
begin
  Result := Self;
  FCityModel := AValue;
end;

constructor TCityUpdateController.Create;
begin

end;

destructor TCityUpdateController.Destroy;
begin

  inherited;
end;

function TCityUpdateController.ibgeCode(AValue: string): iCityUpdateController;
begin
  Result := Self;
  FIBGECode := StrToInt(AValue);
end;

function TCityUpdateController.name(AValue: string): iCityUpdateController;
begin
  Result := Self;
  FName := AValue;
end;

class function TCityUpdateController.New: iCityUpdateController;
begin
  Result := Self.Create;
end;

procedure TCityUpdateController.save;
begin
  FCityModel.DAO.Modify(FSelectedRecord);

  FSelectedRecord.NAME      := FName;
  FSelectedRecord.ZIPCODE   := FZipCode;
  FSelectedRecord.IBGECODE  := FIBGECode;
  FSelectedRecord.STATEID   := FStateId;
  FSelectedRecord.UPDATEDAT := Now;

  FCityModel.DAO.Update(FSelectedRecord);
end;

function TCityUpdateController.selectedRecord(AValue: TTMNGCITY)
  : iCityUpdateController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

function TCityUpdateController.stateId(AValue: string): iCityUpdateController;
begin
  Result := Self;
  FStateId := AValue;
end;

function TCityUpdateController.zipCode(AValue: string): iCityUpdateController;
begin
  Result := Self;
  FZipCode := AValue;
end;

end.
