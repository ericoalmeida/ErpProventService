unit StateDuplicate.Controller;

interface

uses State.Controller.Interf, State.Model.Interf, TMNGSTATE.Entity.Model,
   System.SysUtils;

type
   TStateDuplicateController = class(TInterfacedObject,
     iStateDuplicateController)
   private
      FStateModel: IStateModel;

      FName: string;
      FInitials: string;
      FCountryId: string;

      function getStateId: Integer;
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iStateDuplicateController;

      function stateModel(AValue: IStateModel): iStateDuplicateController;

      function name(AValue: string): iStateDuplicateController;
      function initials(AValue: string): iStateDuplicateController;

      function countryId(AValue: string): iStateDuplicateController;

      procedure save;
   end;

implementation

{ TStateDuplicateController }

function TStateDuplicateController.countryId(AValue: string)
  : iStateDuplicateController;
begin
   Result := Self;
   FCountryId := AValue;
end;

constructor TStateDuplicateController.Create;
begin

end;

function TStateDuplicateController.name(AValue: string)
  : iStateDuplicateController;
begin
   Result := Self;
   FName := AValue;
end;

destructor TStateDuplicateController.Destroy;
begin

   inherited;
end;

function TStateDuplicateController.getStateId: Integer;
begin
   if FStateModel.DAO.Find.Count <> 0 then
   begin
      Result := FStateModel.DAO.FindWhere('', 'STATEID desc').Last.STATEID + 1;
   end
   else
   begin
      Result := 1;
   end;
end;

function TStateDuplicateController.initials(AValue: string)
  : iStateDuplicateController;
begin
   Result := Self;
   FInitials := AValue;
end;

class function TStateDuplicateController.New: iStateDuplicateController;
begin
   Result := Self.Create;
end;

procedure TStateDuplicateController.save;
begin
   FStateModel.Entity(TTMNGSTATE.Create);

   FStateModel.Entity.STATEID := getStateId;
   FStateModel.Entity.name := FName;
   FStateModel.Entity.countryId := FCountryId;
   FStateModel.Entity.initials := FInitials;
   FStateModel.Entity.CREATEDAT := Now;
   FStateModel.Entity.UPDATEDAT := Now;

   FStateModel.DAO.Insert(FStateModel.Entity);
end;

function TStateDuplicateController.stateModel(AValue: IStateModel)
  : iStateDuplicateController;
begin
   Result := Self;
   FStateModel := AValue;
end;

end.
