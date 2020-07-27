unit BudgetDelete.Controller;

interface

uses Budget.Controller.Interf, Budget.Model.Interf,
   TORDBUDGET.Entity.Model,
   System.SysUtils, Base.View.Interf;

type
   TBudgetDeleteController = class(TInterfacedObject, iBudgetDeleteController)
   private
      FMessageConfirm: iBaseMessageView;

      FBudgetModel: IBudgetModel;
      FSelectedRecord: TTORDBUDGET;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iBudgetDeleteController;

      function budgetModel(AValue: IBudgetModel): iBudgetDeleteController;
      function selectedRecord(AValue: TTORDBUDGET): iBudgetDeleteController;

      procedure save;
   end;

implementation

{ TBudgetDeleteController }

uses Facade.View, Types.Views;

constructor TBudgetDeleteController.Create;
begin
   FMessageConfirm := TFacadeView.New.messagesFactoryView.typeMessage
     (tmConfirmation);
end;

destructor TBudgetDeleteController.Destroy;
begin

   inherited;
end;

function TBudgetDeleteController.budgetModel(AValue: IBudgetModel)
  : iBudgetDeleteController;
begin
   Result := Self;
   FBudgetModel := AValue;
end;

class function TBudgetDeleteController.New: iBudgetDeleteController;
begin
   Result := Self.Create;
end;

procedure TBudgetDeleteController.save;
begin
   if FMessageConfirm.messages(Format('Deseja excluir o orçamento %d ?',
     [FSelectedRecord.BUDGETID])).&end then
   begin

      try
         FBudgetModel.DAO.Delete(FSelectedRecord);

      except
         on E: Exception do
            raise Exception.Create
              (Format('O Oçamento %s não pode ser excluído!',
              [FSelectedRecord.DESCRIPTION]));
      end;

   end;
end;

function TBudgetDeleteController.selectedRecord(AValue: TTORDBUDGET)
  : iBudgetDeleteController;
begin
   Result := Self;
   FSelectedRecord := AValue;
end;

end.
