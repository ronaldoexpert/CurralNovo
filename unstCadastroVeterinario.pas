unit unstCadastroVeterinario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmCadastroVeterinario = class(TForm)
    pnlCentro: TPanel;
    lblCodigo: TLabel;
    Label1: TLabel;
    lblCPF: TLabel;
    btnPesquisar: TBitBtn;
    edtCodigo: TEdit;
    edtNome: TDBEdit;
    edtCPF: TDBEdit;
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    grpEndereco: TGroupBox;
    edtCEP: TDBEdit;
    Label2: TLabel;
    edtLogradouro: TDBEdit;
    Label3: TLabel;
    edtNumero: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtComplemento: TDBEdit;
    edtUF: TDBEdit;
    Label6: TLabel;
    edtCidade: TDBEdit;
    Label7: TLabel;
    edtBairro: TDBEdit;
    Label8: TLabel;
    edtTelI: TDBEdit;
    Label9: TLabel;
    edtTelII: TDBEdit;
    Label10: TLabel;
    edtTelIII: TDBEdit;
    Label11: TLabel;
    edtEmail: TDBEdit;
    Label12: TLabel;
    pnlDadosVet: TPanel;
    edtCrmv: TDBEdit;
    lblCrmv: TLabel;
    lblUFCRMV: TLabel;
    edtUFCRMV: TDBEdit;
    pnlDadosProdutor: TPanel;
    edtCNPJ: TDBEdit;
    lblCNPJ: TLabel;
    edtInscRural: TDBEdit;
    lblInscRural: TLabel;
    edtInsEstadual: TDBEdit;
    lblInscEstadual: TLabel;
    rdTipoPessoa: TRadioGroup;
    chkSituacao: TDBCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure rdTipoPessoaClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    vID, vTipoCadastro : String;
    fNovo : Boolean;
    procedure PesquisaBD(vStatus : boolean);
    procedure CarregaCampos;
    procedure PossicionaElementos;
  end;

var
  frmCadastroVeterinario: TfrmCadastroVeterinario;

implementation

{$R *.dfm}

uses untDM, untPesquisa, untFuncoes, untPrincipal;

procedure TfrmCadastroVeterinario.btnExcluirClick(Sender: TObject);
begin
  if fNovo = False then
  begin
    if DM.qryCadastro.RecordCount > 0 then
    begin
      frmFuncoes.Botoes('Excluir', DM.qryCadastro);
    end;
  end
end;

procedure TfrmCadastroVeterinario.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCadastroVeterinario.btnGravarClick(Sender: TObject);
begin
  if fNovo = True then
  begin
    dm.qryCadastro.FieldByName('id').AsString := edtCodigo.Text;
  end;

  if vTipoCadastro = 'Proprietario' then
  begin
    if rdTipoPessoa.ItemIndex = 0 then
      dm.qryCadastro.FieldByName('TIPO').AsString := 'F'
    else
      dm.qryCadastro.FieldByName('TIPO').AsString := 'J';
  end;

  dm.qryCadastro.FieldByName('alteracao').AsDateTime := Date+time;
  dm.qryCadastro.FieldByName('usuario').AsInteger := frmPrincipal.vUsuario;

  dm.qryCadastro.Post;
  dm.qryCadastro.ApplyUpdates(-1);
  btnNovo.Enabled := True;
  btnExcluir.Enabled := True;
  edtCodigo.Enabled := True;

  if vTipoCadastro = 'Veterinario' then
    frmFuncoes.AutoIncre('VETERINARIO', 'Gravar')
  else
    frmFuncoes.AutoIncre('PRODUTOR', 'Gravar');
  ShowMessage('Cadastro realizado com sucesso.');
end;

procedure TfrmCadastroVeterinario.btnNovoClick(Sender: TObject);
begin
  fNovo := True;
  dm.qryCadastro.Insert;

  btnNovo.Enabled := False;
  btnGravar.Enabled := True;
  btnExcluir.Enabled := False;
  edtNome.SetFocus;
  edtCodigo.Enabled := False;

  if vTipoCadastro = 'Veterinario' then
    edtCodigo.Text := IntToStr(frmFuncoes.AutoIncre('VETERINARIO', 'Novo'))
  else
    edtCodigo.Text := IntToStr(frmFuncoes.AutoIncre('PRODUTOR', 'Novo'));
end;


procedure TfrmCadastroVeterinario.btnPesquisarClick(Sender: TObject);
begin
  if fNovo = False then
    PesquisaBD(False);
end;

Procedure TfrmCadastroVeterinario.CarregaCampos;
begin
  edtNome.DataField := 'NOME';
  edtCPF.DataField := 'CPF';
  edtCEP.DataField := 'CEP';
  edtLogradouro.DataField := 'LOGRADOURO';
  edtNumero.DataField := 'NUMERO';
  edtComplemento.DataField := 'COMPLEMENTO';
  edtUF.DataField := 'UF';
  edtCidade.DataField := 'CIDADE';
  edtBairro.DataField := 'BAIRRO';
  edtTelI.DataField := 'TELI';
  edtTelII.DataField := 'TELII';
  edtTelIII.DataField := 'TELIII';
  edtEmail.DataField := 'EMAIL';
  chkSituacao.DataField := 'SITUACAO';

  if vTipoCadastro = 'Veterinario' then
  begin
    edtCrmv.DataField := 'CRMV';
    edtUFCRMV.DataField := 'UF_CRMV';
    rdTipoPessoa.Visible := False;
  end
  else if vTipoCadastro = 'Proprietario' then
  begin
    edtInscRural.DataField := 'INSC_RURAL';
    edtCNPJ.DataField := 'CNPJ';
    edtInsEstadual.DataField := 'INSCEST';

    dm.qryCadastro.FieldByName('CNPJ').EditMask := '##.###.###/####-##';
    rdTipoPessoa.Visible := True;
  end;

  dm.qryCadastro.FieldByName('CEP').EditMask := '##.###-###';
  dm.qryCadastro.FieldByName('CPF').EditMask := '###.###.###-##';
  dm.qryCadastro.FieldByName('TELI').EditMask := '(##) #####-####';
  dm.qryCadastro.FieldByName('TELII').EditMask := '(##) #####-####';
  dm.qryCadastro.FieldByName('TELIII').EditMask := '(##) ####-####';
end;

procedure TfrmCadastroVeterinario.edtCodigoExit(Sender: TObject);
begin
  if Trim(edtCodigo.Text) <> '' then
    PesquisaBD(True);
end;

procedure TfrmCadastroVeterinario.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmCadastroVeterinario.FormActivate(Sender: TObject);
begin
  Caption := 'Cadastro de ' + vTipoCadastro;
  Height := 420;
  vID := '0';
  if vTipoCadastro = 'Veterinario' then
    frmFuncoes.ExecutaSQL('Select * from VETERINARIO where ID = ' + vID, 'Abrir', DM.qryCadastro)
  else
    frmFuncoes.ExecutaSQL('Select * from PRODUTOR where ID = ' + vID, 'Abrir', DM.qryCadastro);

  CarregaCampos;
  edtCodigo.SetFocus;
  PossicionaElementos;
end;

procedure TfrmCadastroVeterinario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmCadastroVeterinario.PesquisaBD(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodigo.Text) <> '' then
    begin
      if vTipoCadastro = 'Veterinario' then
        frmFuncoes.ExecutaSQL('Select * from VETERINARIO where ID = ' + QuotedStr(edtCodigo.Text), 'Abrir', dm.qryCadastro)
      else
        frmFuncoes.ExecutaSQL('Select * from PRODUTOR where ID = ' + QuotedStr(edtCodigo.Text), 'Abrir', dm.qryCadastro);

      if dm.qryCadastro.RecordCount > 0 then
      begin
        dm.qryCadastro.Edit;
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
      if vTipoCadastro = 'Veterinario' then
      begin
        frmPesquisa.vTabela := 'VETERINARIO';
        frmPesquisa.vComando := 'Select ID, NOME from VETERINARIO';
      end
      else
      begin
        frmPesquisa.vTabela := 'PRODUTOR';
        frmPesquisa.vComando := 'Select ID, NOME from PRODUTOR';
      end;
      frmPesquisa.vTela := 'CADASTRO';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmCadastroVeterinario.PossicionaElementos;
begin
  if vTipoCadastro = 'Veterinario' then
  begin
    pnlDadosVet.Visible := True;
    pnlDadosProdutor.Visible := False;
    edtCPF.Visible := True;
    lblCPF.Visible := True;
    Height := 390;
  end
  else
  begin
    pnlDadosVet.Visible := False;
    pnlDadosProdutor.Visible := True;

    if rdTipoPessoa.ItemIndex = 0 then
    begin
      edtCPF.Visible := True;
      lblCPF.Visible := True;
      lblCNPJ.Visible := False;
      edtCNPJ.Visible := False;
      lblInscEstadual.Visible := False;
      edtInsEstadual.Visible := False;
    end
    else
    begin
      edtCPF.Visible := False;
      lblCPF.Visible := False;
      lblCNPJ.Visible := true;
      edtCNPJ.Visible := true;
      lblInscEstadual.Visible := True;
      edtInsEstadual.Visible := True;
    end;

  end;
end;

procedure TfrmCadastroVeterinario.rdTipoPessoaClick(Sender: TObject);
begin
  if rdTipoPessoa.ItemIndex = 0 then
  begin
    edtCPF.Visible := True;
    lblCPF.Visible := True;
    lblCNPJ.Visible := False;
    edtCNPJ.Visible := False;
    lblInscEstadual.Visible := False;
    edtInsEstadual.Visible := False;
    edtCPF.SetFocus;
    edtCNPJ.Clear;
    edtInsEstadual.Clear
  end
  else
  begin
    edtCPF.Visible := False;
    lblCPF.Visible := False;
    lblCNPJ.Visible := true;
    edtCNPJ.Visible := true;
    lblInscEstadual.Visible := True;
    edtInsEstadual.Visible := True;
    edtCNPJ.SetFocus;
    edtCPF.Clear;
  end;
end;

end.
