unit PersonDuplicate.Controller;

interface

uses Person.Controller.Interf, Person.Model.Interf, TMNGPERSON.Entity.Model,
   System.SysUtils;

type
   TPersonDuplicateController = class(TInterfacedObject,
     iPersonDuplicateController)
   private
      FPersonModel: IPersonModel;

      FCompanyId: string;
      FPersonType: Integer;
      FName: string;
      FFancyName: string;
      FCPFCNPJ: string;
      FRGIE: string;
      FAddress: string;
      FDistrictId: string;
      FPhoneNumber: string;
      FEmail: string;
      FStatus: Integer;
      FUserId: string;

      function getPersonId: Integer;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iPersonDuplicateController;

      function personModel(AValue: IPersonModel): iPersonDuplicateController;

      function companyId(AValue: string): iPersonDuplicateController;
      function personType(AValue: Integer): iPersonDuplicateController;
      function name(AValue: string): iPersonDuplicateController;
      function fancyName(AValue: string): iPersonDuplicateController;
      function CPFCNPJ(AValue: string): iPersonDuplicateController;
      function RGIE(AValue: string): iPersonDuplicateController;
      function address(AValue: string): iPersonDuplicateController;
      function districtId(AValue: string): iPersonDuplicateController;
      function phoneNumber(AValue: string): iPersonDuplicateController;
      function email(AValue: string): iPersonDuplicateController;
      function status(AValue: Integer): iPersonDuplicateController;
      function userId(AValue: string): iPersonDuplicateController;

      procedure save;
   end;

implementation

{ TPersonDuplicateController }

function TPersonDuplicateController.address(AValue: string)
  : iPersonDuplicateController;
begin
   Result := Self;
   FAddress := AValue;
end;

function TPersonDuplicateController.companyId(AValue: string)
  : iPersonDuplicateController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

function TPersonDuplicateController.CPFCNPJ(AValue: string)
  : iPersonDuplicateController;
begin
   Result := Self;
   FCPFCNPJ := AValue;
end;

constructor TPersonDuplicateController.Create;
begin

end;

destructor TPersonDuplicateController.Destroy;
begin

   inherited;
end;

function TPersonDuplicateController.districtId(AValue: string)
  : iPersonDuplicateController;
begin
   Result := Self;
   FDistrictId := AValue;
end;

function TPersonDuplicateController.email(AValue: string)
  : iPersonDuplicateController;
begin
   Result := Self;
   FEmail := AValue;
end;

function TPersonDuplicateController.fancyName(AValue: string)
  : iPersonDuplicateController;
begin
   Result := Self;
   FFancyName := AValue;
end;

class function TPersonDuplicateController.New: iPersonDuplicateController;
begin
   Result := Self.Create;
end;

function TPersonDuplicateController.getPersonId: Integer;
begin
   if FPersonModel.DAO.Find.Count <> 0 then
   begin
      Result := FPersonModel.DAO.FindWhere(Format('COMPANYID = %s',
        [QuotedStr(FCompanyId)]), 'PERSONID desc').Last.PERSONID + 1;
   end
   else
   begin
      Result := 1;
   end;
end;

function TPersonDuplicateController.name(AValue: string)
  : iPersonDuplicateController;
begin
   Result := Self;
   FName := AValue;
end;

procedure TPersonDuplicateController.save;
begin
   FPersonModel.Entity(TTMNGPERSON.Create);

   FPersonModel.Entity.companyId := FCompanyId;
   FPersonModel.Entity.PERSONID := getPersonId;
   FPersonModel.Entity.personType := FPersonType;
   FPersonModel.Entity.name := FName;
   FPersonModel.Entity.fancyName := FFancyName;
   FPersonModel.Entity.CPFCNPJ := FCPFCNPJ;
   FPersonModel.Entity.RGIE := FRGIE;
   FPersonModel.Entity.address := FAddress;
   FPersonModel.Entity.districtId := FDistrictId;
   FPersonModel.Entity.phoneNumber := FPhoneNumber;
   FPersonModel.Entity.email := FEmail;
   FPersonModel.Entity.status := FStatus;
   FPersonModel.Entity.userId := FUserId;
   FPersonModel.Entity.CREATEDAT := Now;
   FPersonModel.Entity.UPDATEDAT := Now;

   FPersonModel.DAO.Insert(FPersonModel.Entity);
end;

function TPersonDuplicateController.status(AValue: Integer)
  : iPersonDuplicateController;
begin
   Result := Self;
   FStatus := AValue;
end;

function TPersonDuplicateController.userId(AValue: string)
  : iPersonDuplicateController;
begin
   Result := Self;
   FUserId := AValue;
end;

function TPersonDuplicateController.personModel(AValue: IPersonModel)
  : iPersonDuplicateController;
begin
   Result := Self;
   FPersonModel := AValue;
end;

function TPersonDuplicateController.personType(AValue: Integer)
  : iPersonDuplicateController;
begin
   Result := Self;
   FPersonType := AValue;
end;

function TPersonDuplicateController.phoneNumber(AValue: string)
  : iPersonDuplicateController;
begin
   Result := Self;
   FPhoneNumber := AValue;
end;

function TPersonDuplicateController.RGIE(AValue: string)
  : iPersonDuplicateController;
begin
   Result := Self;
   FRGIE := AValue;
end;

end.
