unit DistrictUpdate.Controller;

interface

uses District.Controller.Interf, TMNGDISTRICT.Entity.Model,
   Districts.Model.Interf, System.SysUtils;

type
   TDistrictUpdateController = class(TInterfacedObject,
     iDistrictUpdateController)
   private
      FDistrictModel: iDistrictModel;
      FSelectedRecord: TTMNGDISTRICT;

      FDescricao: string;
      FCityId: string;
      FZipCode: string;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iDistrictUpdateController;

      function districtModel(AValue: iDistrictModel): iDistrictUpdateController;
      function selectedDistrict(AValue: TTMNGDISTRICT)
        : iDistrictUpdateController;

      function description(AValue: string): iDistrictUpdateController;
      function cityId(AValue: string): iDistrictUpdateController;
      function zipCode(AValue: string): iDistrictUpdateController;

      procedure save;
   end;

implementation

{ TDistrictUpdateController }

function TDistrictUpdateController.cityId(AValue: string)
  : iDistrictUpdateController;
begin
   Result := Self;
   FCityId := AValue;
end;

constructor TDistrictUpdateController.Create;
begin

end;

function TDistrictUpdateController.description(AValue: string)
  : iDistrictUpdateController;
begin
   Result := Self;
   FDescricao := AValue;
end;

destructor TDistrictUpdateController.Destroy;
begin

   inherited;
end;

function TDistrictUpdateController.districtModel(AValue: iDistrictModel)
  : iDistrictUpdateController;
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

   FSelectedRecord.description := FDescricao;
   FSelectedRecord.cityId := FCityId;
   FSelectedRecord.zipCode := FZipCode;
   FSelectedRecord.UPDATEDAT := Now;

   FDistrictModel.DAO.Update(FSelectedRecord);
end;

function TDistrictUpdateController.selectedDistrict(AValue: TTMNGDISTRICT)
  : iDistrictUpdateController;
begin
   Result := Self;
   FSelectedRecord := AValue;
end;

function TDistrictUpdateController.zipCode(AValue: string)
  : iDistrictUpdateController;
begin
   Result := Self;
   FZipCode := AValue;
end;

end.
