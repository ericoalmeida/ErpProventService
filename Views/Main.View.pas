unit Main.View;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
   cxLookAndFeelPainters, dxRibbonSkins, dxSkinsCore, dxSkinBlack, dxSkinBlue,
   dxSkinBlueprint,
   dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
   dxSkinDevExpressDarkStyle,
   dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
   dxSkiniMaginary,
   dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
   dxSkinMetropolis,
   dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
   dxSkinOffice2007Blue,
   dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
   dxSkinOffice2010Black,
   dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
   dxSkinOffice2013LightGray,
   dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
   dxSkinPumpkin, dxSkinSeven,
   dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
   dxSkinSpringTime, dxSkinStardust,
   dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinTheBezier,
   dxSkinsDefaultPainters, dxSkinValentine,
   dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
   dxSkinVisualStudio2013Light, dxSkinVS2010,
   dxSkinWhiteprint, dxSkinXmas2008Blue, dxRibbonCustomizationForm, dxBar,
   dxBarApplicationMenu,
   dxRibbon, cxClasses, dxStatusBar, dxRibbonStatusBar, dxGDIPlusClasses,
   Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, cxImageList, cxContainer,
   cxEdit, cxTextEdit, cxMemo;

type
   TFMainView = class(TForm)
      TbAdministration: TdxRibbonTab;
      RbMainMenu: TdxRibbon;
      StStatus: TdxRibbonStatusBar;
      BrManager: TdxBarManager;
      ApMainMenu: TdxBarApplicationMenu;
      ImLogo: TImage;
      BmCadastros: TdxBar;
      BtClient: TdxBarLargeButton;
      BtServices: TdxBarLargeButton;
      BtMachine: TdxBarLargeButton;
      BmRotinas: TdxBar;
      BtServicesProvision: TdxBarLargeButton;
      BtCost: TdxBarLargeButton;
      BmRelatorios: TdxBar;
      BtReportServicesProvision: TdxBarLargeButton;
      BtReportCost: TdxBarLargeButton;
      TmMainMenu: TTimer;
      BtTypeCost: TdxBarLargeButton;
      TbGeral: TdxRibbonTab;
      BtEmpresas: TdxBarLargeButton;
      BtUsuarios: TdxBarLargeButton;
      BtDistrict: TdxBarLargeButton;
      BtCity: TdxBarLargeButton;
      BtStates: TdxBarLargeButton;
      BtCountry: TdxBarLargeButton;
      BtFinanceOpr: TdxBarLargeButton;
      BtCashBook: TdxBarLargeButton;
      BtReportCashBook: TdxBarLargeButton;
      dxBarLargeButton2: TdxBarLargeButton;
      BtSinapiProduct: TdxBarLargeButton;
      bmMainTools: TdxBar;
      dxBarButton1: TdxBarButton;
      dxBarButton2: TdxBarButton;
      BmGeral: TdxBar;
      TbConstrutoras: TdxRibbonTab;
      TbConstrutorasCad: TdxBar;
      BtOrcamento: TdxBarLargeButton;
      BtCotacao: TdxBarLargeButton;
      BtOperators: TdxBarLargeButton;
      dxBarLargeButton3: TdxBarLargeButton;
      procedure TmMainMenuTimer(Sender: TObject);
      procedure BtEmpresasClick(Sender: TObject);
      procedure BtCountryClick(Sender: TObject);
      procedure BtStatesClick(Sender: TObject);
      procedure BtCityClick(Sender: TObject);
      procedure BtDistrictClick(Sender: TObject);
      procedure BtUsuariosClick(Sender: TObject);
      procedure BtTypeCostClick(Sender: TObject);
      procedure BtMachineClick(Sender: TObject);
      procedure BtServicesClick(Sender: TObject);
      procedure BtSinapiProductClick(Sender: TObject);
      procedure BtClientClick(Sender: TObject);
      procedure dxBarLargeButton2Click(Sender: TObject);
      procedure BtOperatorsClick(Sender: TObject);
      procedure BtServicesProvisionClick(Sender: TObject);
      procedure BtOrcamentoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
   private
      procedure loadLogoFasipe;
   public
      { Public declarations }
   end;

var
   FMainView: TFMainView;

implementation

{$R *.dfm}

uses Facade.Controller, Facade.View, Types.Views, Facade.Model;

procedure TFMainView.BtEmpresasClick(Sender: TObject);
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfListing
     (tpMNG0005AView).&end;
end;

procedure TFMainView.BtMachineClick(Sender: TObject);
begin
   TFacadeView.New.modulesFacadeView.assetsFactoryView.showProgramOfListing
     (tpASS0002AView).&end;
end;

procedure TFMainView.BtOperatorsClick(Sender: TObject);
begin
   TFacadeView.New.modulesFacadeView.orderOfServiceFactory.showProgramOfListing
     (tpORD0002AView).&end;
end;

procedure TFMainView.BtOrcamentoClick(Sender: TObject);
begin
   TFacadeView.New.modulesFacadeView.orderOfServiceFactory.showProgramOfListing
     (tpBDG0001AView).&end;
end;

procedure TFMainView.BtDistrictClick(Sender: TObject);
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfListing
     (tpMNG0001AView).&end;
end;

procedure TFMainView.BtCityClick(Sender: TObject);
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfListing
     (tpMNG0004AView).&end;
end;

procedure TFMainView.BtServicesClick(Sender: TObject);
begin
   TFacadeView.New.modulesFacadeView.orderOfServiceFactory.showProgramOfListing
     (tpORD0001AView).&end;
end;

procedure TFMainView.BtServicesProvisionClick(Sender: TObject);
begin
   TFacadeView.New.modulesFacadeView.orderOfServiceFactory.showProgramOfListing
     (tpORD0003AView).&end;
end;

procedure TFMainView.BtSinapiProductClick(Sender: TObject);
begin
   TFacadeView.New.modulesFacadeView.stockFactory.showProgramOfListing
     (tpSTO0001AView).&end;
end;

procedure TFMainView.BtStatesClick(Sender: TObject);
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfListing
     (tpMNG0003AView).&end;
end;

procedure TFMainView.BtTypeCostClick(Sender: TObject);
begin
   TFacadeView.New.modulesFacadeView.assetsFactoryView.showProgramOfListing
     (tpASS0001AView).&end;
end;

procedure TFMainView.BtUsuariosClick(Sender: TObject);
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfListing
     (tpMNG0006AView).&end;
end;

procedure TFMainView.dxBarLargeButton2Click(Sender: TObject);
begin
   TFacadeView.New.modulesFacadeView.payFactory.showProgramOfListing
     (tpPAY0001AView).&end;
end;

procedure TFMainView.FormShow(Sender: TObject);
begin
  loadLogoFasipe;
end;

procedure TFMainView.loadLogoFasipe;
begin
  ImLogo.Picture.LoadFromFile(
    TFacadeModel
     .New
      .SettingsFactoryModel
       .connection
        .logo );
end;

procedure TFMainView.BtClientClick(Sender: TObject);
begin
   TFacadeView.New.modulesFacadeView.receiveFactory.showProgramOfListing
     (tpREC0001AView).&end;
end;

procedure TFMainView.BtCountryClick(Sender: TObject);
begin
   TFacadeView.New.modulesFacadeView.ManagmentFactoryView.showProgramOfListing
     (tpMNG0002AView).&end;
end;

procedure TFMainView.TmMainMenuTimer(Sender: TObject);
begin
   if Self.MDIChildCount <= 0 then
      RbMainMenu.ShowTabGroups := True
   else
      RbMainMenu.ShowTabGroups := False
end;

end.
