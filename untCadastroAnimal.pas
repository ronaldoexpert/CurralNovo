unit untCadastroAnimal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtDlgs, JPEG;

type
  TfrmCadastroAnimal = class(TForm)
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    pnlCentro: TPanel;
    lblCodigo: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblProprietario: TLabel;
    btnPesquisar: TBitBtn;
    edtCodigo: TEdit;
    edtNome: TDBEdit;
    edtIdentificacao: TDBEdit;
    rdgTipo: TRadioGroup;
    btnPesquProprietario: TBitBtn;
    edtCodProprietario: TEdit;
    edtProprietario: TDBEdit;
    PageControl1: TPageControl;
    tbResenha: TTabSheet;
    imgFotoCria: TImage;
    btnPesqFoto: TBitBtn;
    edtAD: TDBEdit;
    edtAE: TDBEdit;
    edtCabeca: TDBEdit;
    edtOutras: TDBEdit;
    edtPD: TDBEdit;
    edtPE: TDBEdit;
    edtPelagem: TDBEdit;
    lblPelagem: TLabel;
    lblCabeca: TLabel;
    lblAE: TLabel;
    lblAD: TLabel;
    lblPE: TLabel;
    lblPD: TLabel;
    lblOutras: TLabel;
    qryAnimal: TFDQuery;
    dtsAnimal: TDataSource;
    qryProprietario: TFDQuery;
    dtsProprietario: TDataSource;
    edtCaminhoFoto: TEdit;
    OpenDialog1: TOpenDialog;
    procedure btnFecharClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnPesquProprietarioClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodProprietarioExit(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProprietarioKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesqFotoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    vID : String;
    fNovo : Boolean;
  public
    { Public declarations }
    procedure PesquisaAnimal(vStatus : boolean);
    procedure PesquisaProprietario(vStatus : boolean);
    procedure CarregaCampos;
  end;

var
  frmCadastroAnimal: TfrmCadastroAnimal;

implementation

{$R *.dfm}

uses untDM, untPesquisa, untFuncoes;

procedure TfrmCadastroAnimal.btnExcluirClick(Sender: TObject);
begin
  if fNovo = False then
  begin
    if qryAnimal.RecordCount > 0 then
    begin
      frmFuncoes.Botoes('Excluir', qryAnimal);
      imgFotoCria.Picture.LoadFromFile('fotos/imgPadrao.png');
    end;
  end;
end;

procedure TfrmCadastroAnimal.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCadastroAnimal.btnGravarClick(Sender: TObject);
begin
  if fNovo = True then
  begin
    qryAnimal.FieldByName('id').AsString := edtCodigo.Text;
  end;


  if rdgTipo.ItemIndex = 0 then
    qryAnimal.FieldByName('TIPO').AsString := 'V'
  else
    qryAnimal.FieldByName('TIPO').AsString := 'T';

  qryAnimal.FieldByName('proprietario').AsString := edtCodProprietario.Text;
  qryAnimal.FieldByName('foto').AsString := edtCaminhoFoto.Text;

  qryAnimal.Post;
  qryAnimal.ApplyUpdates(-1);
  btnNovo.Enabled := True;
  btnExcluir.Enabled := True;
  edtCodigo.Enabled := True;
  frmFuncoes.AutoIncre('ANIMAL', 'Gravar');
  ShowMessage('Cadastro realizado com sucesso.');
end;

procedure TfrmCadastroAnimal.btnNovoClick(Sender: TObject);
begin
  fNovo := True;
  qryAnimal.Insert;

  btnNovo.Enabled := False;
  btnGravar.Enabled := True;
  btnExcluir.Enabled := False;
  edtNome.SetFocus;
  edtCodigo.Enabled := False;
  imgFotoCria.Picture.LoadFromFile('fotos/imgPadrao.png');

  edtCodigo.Text := IntToStr(frmFuncoes.AutoIncre('ANIMAL', 'Novo'));
end;

procedure TfrmCadastroAnimal.btnPesqFotoClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    edtCaminhoFoto.Text := OpenDialog1.FileName;
    If not fileexists (edtCaminhoFoto.text) then
      imgFotoCria.picture := nil
    Else
      imgFotoCria.picture.loadfromfile(edtCaminhoFoto.text);
  end;
end;

procedure TfrmCadastroAnimal.btnPesquisarClick(Sender: TObject);
begin
  if fNovo = False then
    PesquisaAnimal(False);
end;

procedure TfrmCadastroAnimal.btnPesquProprietarioClick(Sender: TObject);
begin
  PesquisaProprietario(False);
end;

procedure TfrmCadastroAnimal.CarregaCampos;
begin
  edtNome.DataField := 'NOME';
  edtIdentificacao.DataField := 'IDENTIFICACAO';
  edtPelagem.DataField := 'PELAGEM';
  edtCabeca.DataField := 'CABECA';
  edtAD.DataField := 'AD';
  edtPD.DataField := 'PD';
  edtOutras.DataField := 'OUTRAS';
  edtAE.DataField := 'AE';
  edtPE.DataField := 'PE';
end;

procedure TfrmCadastroAnimal.edtCodigoExit(Sender: TObject);
begin
  if Trim(edtCodigo.Text) <> '' then
    PesquisaAnimal(True);
end;

procedure TfrmCadastroAnimal.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmCadastroAnimal.edtCodProprietarioExit(Sender: TObject);
begin
  if Trim(edtCodProprietario.Text) <> '' then
    PesquisaProprietario(True);
end;

procedure TfrmCadastroAnimal.edtCodProprietarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TfrmCadastroAnimal.FormActivate(Sender: TObject);
begin
  vID := '0';
  frmFuncoes.ExecutaSQL('Select * from ANIMAL where ID = ' + vID, 'Abrir', qryAnimal);
  CarregaCampos;
  edtCodigo.SetFocus;
  imgFotoCria.Picture.LoadFromFile('fotos/imgPadrao.png');
end;

procedure TfrmCadastroAnimal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmCadastroAnimal.PesquisaAnimal(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodigo.Text) <> '' then
    begin
      qryAnimal.Close;
      qryAnimal.SQL.Clear;
      qryAnimal.SQL.Add('Select * from ANIMAL where ID = ' + QuotedStr(edtCodigo.Text));
      qryAnimal.Open;

      if qryAnimal.RecordCount > 0 then
      begin
        qryAnimal.Edit;
        CarregaCampos;

        edtCodProprietario.Text := qryAnimal.FieldByName('proprietario').AsString;
        if Trim(edtCodProprietario.Text) <> '' then
          PesquisaProprietario(True);

        if qryAnimal.FieldByName('TIPO').AsString = 'V' then
          rdgTipo.ItemIndex := 0
        else
          rdgTipo.ItemIndex := 1;

        if qryAnimal.FieldByName('foto').AsString <> '' then
          imgFotoCria.picture.loadfromfile(qryAnimal.FieldByName('foto').AsString);
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'ANIMAL';
      frmPesquisa.vTela := 'CAD_ANIMAL';
      frmPesquisa.vComando := 'Select ID, NOME, IDENTIFICACAO, PROPRIETARIO from ANIMAL';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmCadastroAnimal.PesquisaProprietario(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodigo.Text) <> '' then
    begin
      qryProprietario.Close;
      qryProprietario.SQL.Clear;
      qryProprietario.SQL.Add('Select * from PRODUTOR where ID = ' + QuotedStr(edtCodProprietario.Text));
      qryProprietario.Open;

      if qryProprietario.RecordCount > 0 then
      begin
        edtProprietario.DataField := 'NOME';
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'PRODUTOR';
      frmPesquisa.vTela := 'CAD_ANIMAL';
      frmPesquisa.vComando := 'Select ID, NOME, INSCEST_RURAL from PRODUTOR';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

end.
