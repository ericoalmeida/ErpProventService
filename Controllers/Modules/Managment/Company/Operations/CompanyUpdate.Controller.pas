unit CompanyUpdate.Controller;

interface

uses Company.Controller.Interf, Company.Model.Interf, TMNGCOMPANY.Entity.Model,
   System.SysUtils;

type
   TCompanyUpdateController = class(TInterfacedObject, iCompanyUpdateController)
   private
      FCompanyModel: ICompanyModel;
      FSelectedRecord: TTMNGCOMPANY;

      FName: string;
      FFancyName: string;
      FCPFCNPJ: string;
      FRGIE: string;
      FAddress: string;
      FDistrictId: string;
      FPhoneNumber: string;
      FEmail: string;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iCompanyUpdateController;

      function companyModel(AValue: ICompanyModel): iCompanyUpdateController;
      function selectedRecord(AValue: TTMNGCOMPANY): iCompanyUpdateController;

      function name(AValue: string): iCompanyUpdateController;
      function fancyName(AValue: string): iCompanyUpdateController;
      function cpfcnpj(AValue: string): iCompanyUpdateController;
      function rgie(AValue: string): iCompanyUpdateController;
      function address(AValue: string): iCompanyUpdateController;
      function districtId(AValue: string): iCompanyUpdateController;
      function phoneNumber(AValue: string): iCompanyUpdateController;
      function email(AValue: string): iCompanyUpdateController;

      procedure save;
   end;

implementation

{ TCompanyUpdateController }

function TCompanyUpdateController.address(AValue: string)
  : iCompanyUpdateController;
begin
   Result := Self;
   FAddress := AValue;
end;

function TCompanyUpdateController.companyModel(AValue: ICompanyModel)
  : iCompanyUpdateController;
begin
   Result := Self;
   FCompanyModel := AValue;
end;

function TCompanyUpdateController.cpfcnpj(AValue: string)
  : iCompanyUpdateController;
begin
   Result := Self;
   FCPFCNPJ := AValue;
end;

constructor TCompanyUpdateController.Create;
begin

end;

destructor TCompanyUpdateController.Destroy;
begin

   inherited;
end;

function TCompanyUpdateController.districtId(AValue: string)
  : iCompanyUpdateController;
begin
   Result := Self;
   FDistrictId := AValue;
end;

function TCompanyUpdateController.email(AValue: string)
  : iCompanyUpdateController;
begin
   Result := Self;
   FEmail := AValue;
end;

function TCompanyUpdateController.fancyName(AValue: string)
  : iCompanyUpdateController;
begin
   Result := Self;
   FFancyName := AValue;
end;

function TCompanyUpdateController.name(AValue: string)
  : iCompanyUpdateController;
begin
   Result := Self;
   FName := AValue;
end;

class function TCompanyUpdateController.New: iCompanyUpdateController;
begin
   Result := Self.Create;
end;

function TCompanyUpdateController.phoneNumber(AValue: string)
  : iCompanyUpdateController;
begin
   Result := Self;
   FPhoneNumber := AValue;
end;

function TCompanyUpdateController.rgie(AValue: string)
  : iCompanyUpdateController;
begin
   Result := Self;
   FRGIE := AValue;
end;

procedure TCompanyUpdateController.save;
begin
   FCompanyModel.DAO.Modify(FSelectedRecord);

   FSelectedRecord.name := FName;
   FSelectedRecord.fancyName := FFancyName;
   FSelectedRecord.cpfcnpj := FCPFCNPJ;
   FSelectedRecord.rgie := FRGIE;
   FSelectedRecord.address := FAddress;
   FSelectedRecord.districtId := FDistrictId;
   FSelectedRecord.phoneNumber := FPhoneNumber;
   FSelectedRecord.email := FEmail;
   FSelectedRecord.UPDATEDAT := Now;

   FCompanyModel.DAO.Update(FSelectedRecord);
end;

function TCompanyUpdateController.selectedRecord(AValue: TTMNGCOMPANY)
  : iCompanyUpdateController;
begin
   Result := Self;
   FSelectedRecord := AValue;
end;

end.
