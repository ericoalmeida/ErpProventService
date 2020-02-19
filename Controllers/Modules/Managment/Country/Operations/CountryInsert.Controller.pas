unit CountryInsert.Controller;

interface

uses Country.Controller.Interf, Country.Model.Interf, TGERPAIS.Entity.Model, System.SysUtils;

type
  TCountryInsertController = class(TInterfacedObject, iCountryInsertController)
  private
    FCountryModel: ICountryModel;
    FName: string;

    function getCountryId: integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iCountryInsertController;

    function countryModel(AValue: ICountryModel): iCountryInsertController;
    function name(AValue: string): iCountryInsertController;

    procedure save;
  end;

implementation

{ TCountryInsertController }

constructor TCountryInsertController.Create;
begin

end;

function TCountryInsertController.name(AValue: string): iCountryInsertController;
begin
  Result := Self;
  FName := AValue;
end;

destructor TCountryInsertController.Destroy;
begin

  inherited;
end;

function TCountryInsertController.getCountryId: integer;
begin
  if FCountryModel.DAO.Find.Count <> 0 then begin
    Result := FCountryModel.DAO.FindWhere('', 'COUNTRYID desc').Last.COUNTRYID + 1;
  end else begin
    Result := 1;
  end;
end;

class function TCountryInsertController.New: iCountryInsertController;
begin
  Result := Self.Create;
end;

procedure TCountryInsertController.save;
begin
  FCountryModel.Entity(TTMNGCOUNTRY.Create);

  FCountryModel.Entity.COUNTRYID := getCountryId;
  FCountryModel.Entity.NAME      := FName;
  FCountryModel.Entity.CREATEDAT := Now;
  FCountryModel.Entity.UPDATEDAT := Now;

  FCountryModel.DAO.Insert(FCountryModel.Entity);
end;

function TCountryInsertController.countryModel(AValue: ICountryModel): iCountryInsertController;
begin
  Result := Self;
  FCountryModel := AValue;
end;

end.
