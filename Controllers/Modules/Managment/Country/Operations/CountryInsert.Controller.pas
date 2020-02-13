unit CountryInsert.Controller;

interface

uses Country.Controller.Interf, Country.Model.Interf, TGERPAIS.Entity.Model;

type
  TCountryInsertController = class(TInterfacedObject, iCountryInsertController)
  private
    FCountryModel: ICountryModel;
    FDescription: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iCountryInsertController;

    function countryModel(AValue: ICountryModel): iCountryInsertController;
    function description(AValue: string): iCountryInsertController;

    procedure save;
  end;

implementation

{ TCountryInsertController }

constructor TCountryInsertController.Create;
begin

end;

function TCountryInsertController.description(AValue: string): iCountryInsertController;
begin
  Result := Self;
  FDescription := AValue;
end;

destructor TCountryInsertController.Destroy;
begin

  inherited;
end;

class function TCountryInsertController.New: iCountryInsertController;
begin
  Result := Self.Create;
end;

procedure TCountryInsertController.save;
begin
  FCountryModel.Entity(TTGERPAIS.Create);

  FCountryModel.Entity.DESCRICAO := FDescription;

  FCountryModel.DAO.Insert(FCountryModel.Entity);
end;

function TCountryInsertController.countryModel(AValue: ICountryModel): iCountryInsertController;
begin
  Result := Self;
  FCountryModel := AValue;
end;

end.
