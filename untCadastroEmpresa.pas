unit untCadastroEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmCadastroEmpresa = class(TForm)
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    pnlCentro: TPanel;
    lblRazaoSocial: TLabel;
    lblCodigo: TLabel;
    lblCNPJ: TLabel;
    btnPesquisar: TBitBtn;
    edtRazaoSocial: TDBEdit;
    edtCodigo: TEdit;
    chkSituacao: TDBCheckBox;
    edtCNPJ: TDBEdit;
    qryEmpresa: TFDQuery;
    dtsEmpresa: TDataSource;
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
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
  frmCadastroEmpresa: TfrmCadastroEmpresa;

implementation

{$R *.dfm}

uses untDM, untFuncoes, untPesquisa;

procedure TfrmCadastroEmpresa.btnCancelarClick(Sender: TObject);
begin
  if edtCodigo.Text <> '' then
  begin
    if fNovo = False then
    begin
      qryEmpresa.UndoLastChange(True);
      qryEmpresa.Edit;
      CarregaCampos;
      fNovo := False;
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

procedure TfrmCadastroEmpresa.btnExcluirClick(Sender: TObject);
begin
  if fNovo = False then
  begin
    if qryEmpresa.RecordCount > 0 then
    begin
      frmFuncoes.Botoes('EMPRESA', DM.qryProduto);
      edtCodigo.Clear;
      edtCodigo.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroEmpresa.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroEmpresa.btnGravarClick(Sender: TObject);
begin
  if fNovo = True then
  begin
    qryEmpresa.FieldByName('id').AsString := edtCodigo.Text;
    frmFuncoes.AutoIncre('EMPRESA', 'Gravar');
  end;

  btnNovo.Enabled := True;
  btnExcluir.Enabled := True;
  edtCodigo.Enabled := True;

  try
    frmFuncoes.Botoes('Gravar', qryEmpresa);
    PesquisaBD(True);
    fNovo := False;

  Except on E: Exception do
    ShowMessage('Erro na gravação. >>>> ' + E.Message);
  end;
end;

procedure TfrmCadastroEmpresa.btnNovoClick(Sender: TObject);
begin
  fNovo := True;
  qryEmpresa.Insert;

  btnNovo.Enabled := False;
  btnGravar.Enabled := True;
  btnExcluir.Enabled := False;
  edtCodigo.Enabled := False;
  edtRazaoSocial.SetFocus;
  chkSituacao.Checked := True;
  chkSituacao.Field.Value := 'Ativo';

  edtCodigo.Text := IntToStr(frmFuncoes.AutoIncre('EMPRESA', 'Novo'));
end;

procedure TfrmCadastroEmpresa.btnPesquisarClick(Sender: TObject);
begin
  if fNovo = False then
    PesquisaBD(False);
end;

procedure TfrmCadastroEmpresa.CarregaCampos;
begin
  edtRazaoSocial.DataField := 'RAZAO_SOCIAL';
  edtCNPJ.DataField := 'CNPJ';
  chkSituacao.DataField := 'SITUACAO';

  qryEmpresa.FieldByName('CNPJ').EditMask := '99.999.999/9999-99';
end;

procedure TfrmCadastroEmpresa.edtCodigoExit(Sender: TObject);
begin
  if fNovo = False then
  begin
    if Trim(edtCodigo.Text) <> '' then
      PesquisaBD(True);
  end;
end;

procedure TfrmCadastroEmpresa.edtCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesquisarClick(Self);
end;

procedure TfrmCadastroEmpresa.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmCadastroEmpresa.FormActivate(Sender: TObject);
begin
  vID := '0';
  frmFuncoes.ExecutaSQL('Select * from EMPRESA where ID = ' + vID, 'Abrir', qryEmpresa);
  CarregaCampos;
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroEmpresa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmCadastroEmpresa.PesquisaBD(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodigo.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from EMPRESA where ID = ' + QuotedStr(edtCodigo.Text), 'Abrir', qryEmpresa);

      if qryEmpresa.RecordCount > 0 then
      begin
        qryEmpresa.Edit;
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
      frmPesquisa.vTabela := 'EMPRESA';
      frmPesquisa.vComando := 'Select ID, RAZAO_SOCIAL, CNPJ from EMPRESA';
      frmPesquisa.vTela := 'CAD_EMPRESA';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

end.
