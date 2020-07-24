unit CountryDuplicate.Controller;

interface

uses Country.Controller.Interf, Country.Model.Interf, TMNGCOUNTRY.Entity.Model,
   System.SysUtils;

type
   TCountryDuplicateController = class(TInterfacedObject,
     iCountryDuplicateController)
   private
      FCountryModel: ICountryModel;
      FName: string;

      function getCountryId: Integer;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iCountryDuplicateController;

      function countryModel(AValue: ICountryModel): iCountryDuplicateController;

      function name(AValue: string): iCountryDuplicateController;

      procedure save;
   end;

implementation

{ TCountryDuplicateController }

constructor TCountryDuplicateController.Create;
begin

end;

function TCountryDuplicateController.name(AValue: string)
  : iCountryDuplicateController;
begin
   Result := Self;
   FName := AValue;
end;

destructor TCountryDuplicateController.Destroy;
begin

   inherited;
end;

function TCountryDuplicateController.getCountryId: Integer;
begin
   if FCountryModel.DAO.Find.Count <> 0 then
   begin
      Result := FCountryModel.DAO.FindWhere('', 'COUNTRYID desc')
        .Last.COUNTRYID + 1;
   end
   else
   begin
      Result := 1;
   end;
end;

class function TCountryDuplicateController.New: iCountryDuplicateController;
begin
   Result := Self.Create;
end;

procedure TCountryDuplicateController.save;
begin
   FCountryModel.Entity(TTMNGCOUNTRY.Create);

   FCountryModel.Entity.COUNTRYID := getCountryId;
   FCountryModel.Entity.name := FName;
   FCountryModel.Entity.CREATEDAT := Now;
   FCountryModel.Entity.UPDATEDAT := Now;

   FCountryModel.DAO.Insert(FCountryModel.Entity);
end;

function TCountryDuplicateController.countryModel(AValue: ICountryModel)
  : iCountryDuplicateController;
begin
   Result := Self;
   FCountryModel := AValue;
end;

end.
