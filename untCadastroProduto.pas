unit untCadastroProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.Mask, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

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
    chkSituacao: TDBCheckBox;
    edtUnidade: TDBEdit;
    lblUnidade: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnNovoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    vID : String;
    fNovo : Boolean;
    procedure PesquisaBD(vStatus : boolean);
    procedure CarregaCampos;
  end;

var
  frmCadastroProduto: TfrmCadastroProduto;

implementation

{$R *.dfm}

uses untFuncoes, untPesquisa, untPrincipal, untDM;

procedure TfrmCadastroProduto.btnCancelarClick(Sender: TObject);
begin
  if edtCodigo.Text <> '' then
  begin
    if fNovo = False then
    begin
      dm.qryProduto.UndoLastChange(True);
      CarregaCampos;
    end
    else
    begin
      edtCodigo.Enabled := true;
      edtCodigo.Clear;
      CarregaCampos;
      btnNovo.Enabled := True;
      btnGravar.Enabled := True;
      btnExcluir.Enabled := True;
      fNovo := False;
    end;
  end;
end;

procedure TfrmCadastroProduto.btnExcluirClick(Sender: TObject);
begin
  if fNovo = False then
  begin
    if DM.qryProduto.RecordCount > 0 then
    begin
      frmFuncoes.Botoes('Excluir', DM.qryProduto);
      edtCodigo.Clear;
      edtCodigo.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroProduto.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCadastroProduto.btnGravarClick(Sender: TObject);
begin
  if fNovo = True then
  begin
    dm.qryProduto.FieldByName('id').AsString := edtCodigo.Text;
  end;

  dm.qryProduto.FieldByName('alteracao').AsDateTime := Date+time;
  dm.qryProduto.FieldByName('usuario').AsInteger := frmPrincipal.vUsuario;
  dm.qryProduto.FieldByName('CODEMPRESA').AsInteger := frmPrincipal.vEmpresa;        //Versao 1.4 - 14/10/2018

  btnNovo.Enabled := True;
  btnExcluir.Enabled := True;
  edtCodigo.Enabled := True;

  try
    frmFuncoes.Botoes('Gravar', dm.qryProduto);
    frmFuncoes.AutoIncre('PRODUTO', 'Gravar');
    PesquisaBD(True);
    fNovo := False;

    if fNovo = True then                       //Versao 1.2.0 - 04/07/2018
      frmFuncoes.GravaLog('Adição de cadastro de Produto. Codigo: ' + edtCodigo.Text, IntToStr(frmPrincipal.vUsuario))     //Versao 1.2.0 - 04/07/2018
    else
      frmFuncoes.GravaLog('Alteração de cadastro de Produto. Codigo: ' + edtCodigo.Text, IntToStr(frmPrincipal.vUsuario));   //Versao 1.2.0 - 04/07/2018
  Except on E: Exception do
    ShowMessage('Erro na gravação. >>>> ' + E.Message);
  end;
end;

procedure TfrmCadastroProduto.btnNovoClick(Sender: TObject);
begin
  fNovo := True;
  dm.qryProduto.Insert;

  btnNovo.Enabled := False;
  btnGravar.Enabled := True;
  btnExcluir.Enabled := False;
  edtCodigo.Enabled := False;
  edtDescricao.SetFocus;
  chkSituacao.Checked := True;
  chkSituacao.Field.Value := 'Ativo';
  edtVlrUnit.Field.Value := 0;
  edtEstoque.Field.Value := 0;

  edtCodigo.Text := IntToStr(frmFuncoes.AutoIncre('PRODUTO', 'Novo'));
end;

procedure TfrmCadastroProduto.btnPesquisarClick(Sender: TObject);
begin
  if fNovo = False then
    PesquisaBD(False);
end;

procedure TfrmCadastroProduto.CarregaCampos;
begin
  edtDescricao.DataField := 'DESCRICAO';
  edtVlrUnit.DataField := 'VALOR';
  edtUnidade.DataField := 'UNIDADE';
  edtEstoque.DataField := 'ESTOQUE';
  chkSituacao.DataField := 'SITUACAO';

  TFMTBCDField(dm.qryProduto.FieldByName('valor')).DisplayFormat := '###,####,###,##0.00';
end;

procedure TfrmCadastroProduto.edtCodigoExit(Sender: TObject);
begin
  if fNovo = False then
  begin
    if Trim(edtCodigo.Text) <> '' then
      PesquisaBD(True);
  end;
end;

procedure TfrmCadastroProduto.edtCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesquisarClick(Self);
end;

procedure TfrmCadastroProduto.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmCadastroProduto.FormActivate(Sender: TObject);
begin
  vID := '0';
  frmFuncoes.ExecutaSQL('Select * from PRODUTO where ID = ' + vID, 'Abrir', DM.qryProduto);
  CarregaCampos;
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroProduto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmCadastroProduto.PesquisaBD(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodigo.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from PRODUTO where ID = ' + QuotedStr(edtCodigo.Text), 'Abrir', dm.qryProduto);

      if dm.qryProduto.RecordCount > 0 then
      begin
        dm.qryProduto.Edit;
        CarregaCampos;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodigo.SetFocus;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'PRODUTO';
      frmPesquisa.vComando := 'Select ID, DESCRICAO, UNIDADE, VALOR, ESTOQUE from PRODUTO';
      frmPesquisa.vTela := 'CAD_PRODUTO';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

end.
