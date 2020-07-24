unit Utils.Controller;

interface

uses Utils.Controller.Interf;

type
   TUtilsController = class(TInterfacedObject, iUtilsController)
   private
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iUtilsController;

      function iff(AExpression: boolean; AWhenBeTrue: Integer;
        AWhenBeFalse: Integer): Integer; overload;

      function iff(AExpression: boolean; AWhenBeTrue: TDateTime;
        AWhenBeFalse: TDateTime): TDateTime; overload;

      function iff(AExpression: boolean; AWhenBeTrue: string;
        AWhenBeFalse: string): string; overload;
   end;

implementation

{ TUtilsController }

constructor TUtilsController.Create;
begin

end;

destructor TUtilsController.Destroy;
begin

   inherited;
end;

function TUtilsController.iff(AExpression: boolean;
  AWhenBeTrue, AWhenBeFalse: Integer): Integer;
begin
   if AExpression then
      Result := AWhenBeTrue
   else
      Result := AWhenBeFalse;
end;

function TUtilsController.iff(AExpression: boolean;
  AWhenBeTrue, AWhenBeFalse: TDateTime): TDateTime;
begin
   if AExpression then
      Result := AWhenBeTrue
   else
      Result := AWhenBeFalse;
end;

function TUtilsController.iff(AExpression: boolean;
  AWhenBeTrue, AWhenBeFalse: string): string;
begin
   if AExpression then
      Result := AWhenBeTrue
   else
      Result := AWhenBeFalse;
end;

class function TUtilsController.New: iUtilsController;
begin
   Result := Self.Create;
end;

end.
