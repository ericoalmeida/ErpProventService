unit OperatorsDuplicate.Controller;

interface

uses Operators.Controller.Interf, Operators.Model.Interf,
   TORDOPERATOR.Entity.Model,
   System.SysUtils;

type
   TOperatorDuplicateController = class(TInterfacedObject,
     iOperatorDuplicateController)
   private
      FOperatorModel: IOperatorModel;

      FCompanyId: string;
      FName: string;
      FStatus: Integer;
      FUserId: string;

      function getOperatorId: Integer;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iOperatorDuplicateController;

      function operatorModel(AValue: IOperatorModel)
        : iOperatorDuplicateController;

      function companyId(AValue: string): iOperatorDuplicateController;
      function name(AValue: string): iOperatorDuplicateController;
      function status(AValue: Integer): iOperatorDuplicateController;
      function userId(AValue: string): iOperatorDuplicateController;

      procedure save;
   end;

implementation

{ TOperatorDuplicateController }

function TOperatorDuplicateController.companyId(AValue: string)
  : iOperatorDuplicateController;
begin
   Result := Self;
   FCompanyId := AValue;
end;

constructor TOperatorDuplicateController.Create;
begin

end;

destructor TOperatorDuplicateController.Destroy;
begin

   inherited;
end;

class function TOperatorDuplicateController.New: iOperatorDuplicateController;
begin
   Result := Self.Create;
end;

function TOperatorDuplicateController.getOperatorId: Integer;
begin
   if FOperatorModel.DAO.Find.Count <> 0 then
   begin
      Result := FOperatorModel.DAO.FindWhere('', 'OPERATORID desc')
        .Last.OPERATORID + 1;
   end
   else
   begin
      Result := 1;
   end;
end;

function TOperatorDuplicateController.name(AValue: string)
  : iOperatorDuplicateController;
begin
   Result := Self;
   FName := AValue;
end;

procedure TOperatorDuplicateController.save;
begin
   FOperatorModel.Entity(TTORDOPERATOR.Create);

   FOperatorModel.Entity.companyId := FCompanyId;
   FOperatorModel.Entity.OPERATORID := getOperatorId;
   FOperatorModel.Entity.name := FName;
   FOperatorModel.Entity.status := FStatus;
   FOperatorModel.Entity.userId := FUserId;
   FOperatorModel.Entity.CREATEDAT := Now;
   FOperatorModel.Entity.UPDATEDAT := Now;

   FOperatorModel.DAO.Insert(FOperatorModel.Entity);
end;

function TOperatorDuplicateController.status(AValue: Integer)
  : iOperatorDuplicateController;
begin
   Result := Self;
   FStatus := AValue;
end;

function TOperatorDuplicateController.userId(AValue: string)
  : iOperatorDuplicateController;
begin
   Result := Self;
   FUserId := AValue;
end;

function TOperatorDuplicateController.operatorModel(AValue: IOperatorModel)
  : iOperatorDuplicateController;
begin
   Result := Self;
   FOperatorModel := AValue;
end;

end.
