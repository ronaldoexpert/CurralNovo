unit untCadastroProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmCadastroProduto = class(TForm)
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    pnlCentro: TPanel;
    lblDescricao: TLabel;
    lblValorUnit: TLabel;
    lblCodigo: TLabel;
    btnPesquisar: TBitBtn;
    edtDescricao: TDBEdit;
    edtCodigo: TEdit;
    lblEstoque: TLabel;
    edtEstoque: TDBEdit;
    edtVlrUnit: TDBEdit;
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroProduto: TfrmCadastroProduto;

implementation

{$R *.dfm}

procedure TfrmCadastroProduto.btnFecharClick(Sender: TObject);
begin
  close;
end;

end.
