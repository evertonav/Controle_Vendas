unit View.FrmCadTipoGasto;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  View.FrmPadrao,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Layouts,
  FMX.Edit,
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  FMX.ListBox,
  View.FrmPadraoCadastro;

type
  TfrmCadTipoGasto = class(TfrmPadraoCadastro)
    lytTipoGasto: TLayout;
    edtTipoGasto: TEdit;
    lytImgTipoGasto: TLayout;
    rtcTipoGasto: TRectangle;
    imgTipoGasto: TImage;
    procedure edtTipoGastoChangeTracking(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadTipoGasto: TfrmCadTipoGasto;

implementation

Uses
  View.FrmPrincipal,
  Controller.Interfaces,
  Controller;

{$R *.fmx}

procedure TfrmCadTipoGasto.btnConfirmarClick(Sender: TObject);
begin
  frmCadTipoGasto.InserirComThread(
    procedure ()
    begin
      TController
        .Criar
          .TipoGasto
            .Entidade
              .Descricao(edtTipoGasto.Text)
            .ModelDAOTipoGasto
          .Inserir;;

      TThread.Synchronize(
        TThread.CurrentThread,
        procedure
        begin
          edtTipoGasto.Text := '';
        end);
    end,

    //OUTRO PAR�METRO DO M�TODO
    frmCadTipoGasto
  );
end;

procedure TfrmCadTipoGasto.edtTipoGastoChangeTracking(Sender: TObject);
begin
  frmCadTipoGasto.HabilitarBotao(edtTipoGasto.Text <> EmptyStr,
                                 frmCadTipoGasto);
end;

end.
