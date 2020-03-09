unit OperatorsUpdate.Controller;

interface

uses Operators.Controller.Interf, Operators.Model.Interf,
  TORDOPERATOR.Entity.Model,
  System.SysUtils;

type
  TOperatorUpdateController = class(TInterfacedObject,
    iOperatorUpdateController)
  private
    FOperatorModel: IOperatorModel;
    FSelectedRecord: TTORDOPERATOR;

    FCompanyId: string;
    FName: string;
    FStatus: Integer;
    FUserId: string;
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iOperatorUpdateController;

    function operatorModel(AValue: IOperatorModel): iOperatorUpdateController;
    function selectedRecord(AValue: TTORDOPERATOR): iOperatorUpdateController;

    function companyId(AValue: string): iOperatorUpdateController;
    function name(AValue: string): iOperatorUpdateController;
    function status(AValue: integer): iOperatorUpdateController;
    function userId(AValue: string): iOperatorUpdateController;

    procedure save;
  end;

implementation

{ TOperatorUpdateController }

function TOperatorUpdateController.operatorModel(AValue: IOperatorModel)
  : iOperatorUpdateController;
begin
  Result := Self;
  FOperatorModel := AValue;
end;

function TOperatorUpdateController.companyId(AValue: string): iOperatorUpdateController;
begin
  Result := Self;
  FCompanyId := AValue;
end;

constructor TOperatorUpdateController.Create;
begin

end;

destructor TOperatorUpdateController.Destroy;
begin

  inherited;
end;

function TOperatorUpdateController.name(AValue: string): iOperatorUpdateController;
begin
  Result := Self;
  FName := AValue;
end;

class function TOperatorUpdateController.New: iOperatorUpdateController;
begin
  Result := Self.Create;
end;

procedure TOperatorUpdateController.save;
begin
  FOperatorModel.DAO.Modify(FSelectedRecord);

  FSelectedRecord.COMPANYID := FCompanyId;
  FSelectedRecord.NAME  := FName;
  FSelectedRecord.STATUS := FStatus;
  FSelectedRecord.USERID := FUserId;
  FSelectedRecord.UPDATEDAT := Now;

  FOperatorModel.DAO.Update(FSelectedRecord);
end;

function TOperatorUpdateController.selectedRecord(AValue: TTORDOPERATOR)
  : iOperatorUpdateController;
begin
  Result := Self;
  FSelectedRecord := AValue;
end;

function TOperatorUpdateController.status(AValue: integer): iOperatorUpdateController;
begin
  Result := Self;
  FStatus := AValue;
end;

function TOperatorUpdateController.userId(AValue: string): iOperatorUpdateController;
begin
  Result := Self;
  FUserId := AValue;
end;

end.
