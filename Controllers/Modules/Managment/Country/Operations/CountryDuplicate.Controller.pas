unit CountryDuplicate.Controller;

interface

uses Country.Controller.Interf, Country.Model.Interf, TGERPAIS.Entity.Model;

type
  TCountryDuplicateController = class(TInterfacedObject, iCountryDuplicateController)
  private
    FCountryModel: ICountryModel;
    FDescription: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iCountryDuplicateController;

    function countryModel(AValue: ICountryModel): iCountryDuplicateController;

    function description(AValue: string): iCountryDuplicateController;

    procedure save;
  end;

implementation

{ TCountryDuplicateController }

constructor TCountryDuplicateController.Create;
begin

end;

function TCountryDuplicateController.description(AValue: string): iCountryDuplicateController;
begin
 Result := Self;
 FDescription := AValue;
end;

destructor TCountryDuplicateController.Destroy;
begin

  inherited;
end;

class function TCountryDuplicateController.New: iCountryDuplicateController;
begin
  Result := Self.Create;
end;

procedure TCountryDuplicateController.save;
begin
  FCountryModel.Entity(TTGERPAIS.Create);

  FCountryModel.Entity.DESCRICAO := FDescription;

  FCountryModel.DAO.Insert(FCountryModel.Entity);
end;

function TCountryDuplicateController.countryModel(AValue: ICountryModel): iCountryDuplicateController;
begin
  Result := Self;
  FCountryModel := AValue;
end;

end.
