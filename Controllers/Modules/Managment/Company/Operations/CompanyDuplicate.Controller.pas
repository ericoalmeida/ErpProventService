unit CompanyDuplicate.Controller;

interface

uses Company.Controller.Interf, Company.Model.Interf,
  TMNGCOMPANY.Entity.Model, System.SysUtils;

type
  TCompanyDuplicateController = class(TInterfacedObject,
    iCompanyDuplicateController)
  private
    FCompanyModel: ICompanyModel;

    FName: string;
    FFancyName: string;
    FCPFCNPJ: string;
    FRGIE: string;
    FAddress: string;
    FDistrictId: string;
    FPhoneNumber: string;
    FEmail: string;

    function getCompanyId: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iCompanyDuplicateController;

    function companyModel(AValue: ICompanyModel)
      : iCompanyDuplicateController;

    function name(AValue: string): iCompanyDuplicateController;
    function fancyName(AValue: string): iCompanyDuplicateController;
    function cpfcnpj(AValue: string): iCompanyDuplicateController;
    function rgie(AValue: string): iCompanyDuplicateController;
    function address(AValue: string): iCompanyDuplicateController;
    function districtId(AValue: string): iCompanyDuplicateController;
    function phoneNumber(AValue: string): iCompanyDuplicateController;
    function email(AValue: string): iCompanyDuplicateController;

    procedure save;
  end;

implementation

{ TCompanyDuplicateController }

function TCompanyDuplicateController.cpfcnpj(AValue: string): iCompanyDuplicateController;
begin
 Result := Self;
 FCPFCNPJ := AValue;
end;

constructor TCompanyDuplicateController.Create;
begin

end;

destructor TCompanyDuplicateController.Destroy;
begin

  inherited;
end;

function TCompanyDuplicateController.address(AValue: string): iCompanyDuplicateController;
begin
 Result := Self;
 FAddress := AValue;
end;

function TCompanyDuplicateController.districtId(AValue: string): iCompanyDuplicateController;
begin
 Result := Self;
 FDistrictId := AValue;
end;

function TCompanyDuplicateController.email(AValue: string): iCompanyDuplicateController;
begin
 Result := Self;
 FEmail := AValue;
end;

function TCompanyDuplicateController.fancyName(AValue: string): iCompanyDuplicateController;
begin
 Result := Self;
 FFancyName := AValue;
end;

function TCompanyDuplicateController.getCompanyId: Integer;
begin
  if FCompanyModel.DAO.Find.Count <> 0 then  begin
    Result := FCompanyModel.DAO.FindWhere('', 'COMPANYID desc').Last.COMPANYID + 1;
  end else begin
    Result := 1;
  end;
end;

function TCompanyDuplicateController.name(AValue: string): iCompanyDuplicateController;
begin
 Result := Self;
 FName := AValue;
end;

function TCompanyDuplicateController.companyModel(AValue: ICompanyModel)
  : iCompanyDuplicateController;
begin
  Result := Self;
  FCompanyModel := AValue;
end;

class function TCompanyDuplicateController.New: iCompanyDuplicateController;
begin
  Result := Self.Create;
end;

function TCompanyDuplicateController.phoneNumber(AValue: string): iCompanyDuplicateController;
begin
 Result := Self;
 FPhoneNumber := AValue;
end;

function TCompanyDuplicateController.rgie(AValue: string): iCompanyDuplicateController;
begin
 Result := Self;
 FRGIE := AValue;
end;

procedure TCompanyDuplicateController.save;
begin
  FCompanyModel.Entity(TTMNGCOMPANY.Create);

  FCompanyModel.Entity.COMPANYID   := getCompanyId;
  FCompanyModel.Entity.NAME        := FName;
  FCompanyModel.Entity.FANCYNAME   := FFancyName;
  FCompanyModel.Entity.CPFCNPJ     := FCPFCNPJ;
  FCompanyModel.Entity.RGIE        := FRGIE;
  FCompanyModel.Entity.ADDRESS     := FAddress;
  FCompanyModel.Entity.DISTRICTID  := FDistrictId;
  FCompanyModel.Entity.PHONENUMBER := FPhoneNumber;
  FCompanyModel.Entity.EMAIL       := FEmail;
  FCompanyModel.Entity.CREATEDAT   := Now;
  FCompanyModel.Entity.UPDATEDAT   := Now;

  FCompanyModel.DAO.Insert(FCompanyModel.Entity);
end;


end.
