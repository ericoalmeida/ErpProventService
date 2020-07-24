unit ReceiveFactory.View;

interface

uses ReceiveFactory.View.Interf, Base.View.Interf, Types.Views;

type
   TReceiveFactoryView = class(TInterfacedObject, iReceiveFactoryView)
   private
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iReceiveFactoryView;

      function showProgramOfListing(AValue: TTypeListingPrograms)
        : iBaseListView;
      function showProgramOfRegister(AValue: TTypeRegisterPrograms)
        : iBaseRegisterView;
      function showProgramOfSearch(AValue: TTypeSearchPrograms)
        : IBaseSearchView;

   end;

implementation

{ TReceiveFactoryView }

uses REC0001AView, REC0001BView, REC0001CView, PAY0001CView;

constructor TReceiveFactoryView.Create;
begin

end;

destructor TReceiveFactoryView.Destroy;
begin

   inherited;
end;

class function TReceiveFactoryView.New: iReceiveFactoryView;
begin
   Result := Self.Create;
end;

function TReceiveFactoryView.showProgramOfListing(AValue: TTypeListingPrograms)
  : iBaseListView;
begin
   case AValue of
      tpREC0001AView:
         Result := TFREC0001AView.New;
   end;
end;

function TReceiveFactoryView.showProgramOfRegister
  (AValue: TTypeRegisterPrograms): iBaseRegisterView;
begin
   case AValue of
      trREC0001BView:
         Result := TFREC0001BView.New;
   end;
end;

function TReceiveFactoryView.showProgramOfSearch(AValue: TTypeSearchPrograms)
  : IBaseSearchView;
begin
   case AValue of
      tsREC0001CView:
         Result := TFREC0001CView.New;
   end;
end;

end.
