{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
unit untCadastroCria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Imaging.pngimage, UCrpeClasses,
  UCrpe32;

type
  TfrmCadastroCria = class(TForm)
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    pnlCentro: TPanel;
    lblCodigo: TLabel;
    btnPesquisar: TBitBtn;
    edtCodigo: TEdit;
    edtNome: TDBEdit;
    edtIdentificacao: TDBEdit;
    rdgTipo: TRadioGroup;
    edtCodProprietario: TEdit;
    btnPesquProprietario: TBitBtn;
    edtProprietario: TDBEdit;
    edtNascimento: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    lblProprietario: TLabel;
    Label3: TLabel;
    imgFotoCria: TImage;
    btnPesqFoto: TBitBtn;
    edtPelagem: TDBEdit;
    edtCabeca: TDBEdit;
    edtAD: TDBEdit;
    edtAE: TDBEdit;
    edtPD: TDBEdit;
    edtPE: TDBEdit;
    edtOutras: TDBEdit;
    PageControl1: TPageControl;
    tbResenha: TTabSheet;
    tbGenealogia: TTabSheet;
    imgFotoMae: TImage;
    imgFotoPai: TImage;
    lblCabeca: TLabel;
    lblPelagem: TLabel;
    lblAD: TLabel;
    lblAE: TLabel;
    lblPE: TLabel;
    lblPD: TLabel;
    lblOutras: TLabel;
    OpenDialog1: TOpenDialog;
    edtCaminhoFoto: TEdit;
    btnPesquisaMae: TBitBtn;
    btnPesquisaPai: TBitBtn;
    edtCodMae: TEdit;
    edtCodPai: TEdit;
    edtNomeMae: TEdit;
    edtNomePai: TEdit;
    chkSituacao: TDBCheckBox;
    btnLimpaFoto: TBitBtn;
    Crpe1: TCrpe;
    procedure btnFecharClick(Sender: TObject);
    procedure btnPesqFotoClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnPesquProprietarioClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPesquisaMaeClick(Sender: TObject);
    procedure btnPesquisaPaiClick(Sender: TObject);
    procedure edtCodMaeExit(Sender: TObject);
    procedure edtCodPaiExit(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProprietarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProprietarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodProprietarioExit(Sender: TObject);
    procedure btnLimpaFotoClick(Sender: TObject);
  private
    { Private declarations }
    fNovo : Boolean;
    vID : String;
    procedure CarregaFotosPadrao;
    procedure LimpaCampos;
    function ValidaCampos : Boolean;
  public
    { Public declarations }
    procedure CarregaCampos;
    procedure PesquisaAnimal(vStatus : boolean);
    procedure PesquisaProprietario(vStatus : boolean);
    procedure PesquisaMae(vStatus : boolean);
    procedure PesquisaPai(vStatus : boolean);
  end;

var
  frmCadastroCria: TfrmCadastroCria;

implementation

{$R *.dfm}

uses untPesquisa, untDM, untFuncoes, untPrincipal;

procedure TfrmCadastroCria.btnExcluirClick(Sender: TObject);
begin
  if fNovo = False then
  begin
    if dm.qryCria.RecordCount > 0 then
    begin
      frmFuncoes.Botoes('Excluir', dm.qryCria);
      CarregaFotosPadrao;
    end;
  end;
end;

procedure TfrmCadastroCria.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCadastroCria.btnGravarClick(Sender: TObject);
begin
  if ValidaCampos then
  begin
    if fNovo = True then
    begin
      dm.qryCria.FieldByName('id').AsString := edtCodigo.Text;
    end;

    if rdgTipo.ItemIndex = 0 then
      dm.qryCria.FieldByName('SEXO').AsString := 'F'
    else
      dm.qryCria.FieldByName('SEXO').AsString := 'M';

    dm.qryCria.FieldByName('proprietario').AsString := edtCodProprietario.Text;
    dm.qryCria.FieldByName('foto').AsString := edtCaminhoFoto.Text;
    dm.qryCria.FieldByName('mae').AsString := edtCodMae.Text;
    dm.qryCria.FieldByName('pai').AsString := edtCodPai.Text;
    dm.qryCria.FieldByName('fotomae').AsString := '';
    dm.qryCria.FieldByName('fotopai').AsString := '';
    dm.qryCria.FieldByName('alteracao').AsDateTime := Date + Time;
    dm.qryCria.FieldByName('usuario').AsInteger := frmPrincipal.vUsuario;

    dm.qryCria.ApplyUpdates(-1);
    btnNovo.Enabled := True;
    btnExcluir.Enabled := True;
    edtCodigo.Enabled := True;
    fNovo := False;
    frmFuncoes.AutoIncre('CRIA', 'Gravar');
    ShowMessage('Cadastro realizado com sucesso.');
  end;
end;

procedure TfrmCadastroCria.btnLimpaFotoClick(Sender: TObject);
begin
  if FileExists('fotos/imgPadrao.png') then
  begin
    edtCaminhoFoto.Text := 'fotos/imgPadrao.png';
    imgFotoCria.Picture.LoadFromFile('fotos/imgPadrao.png');
  end;
end;

procedure TfrmCadastroCria.btnNovoClick(Sender: TObject);
begin
  LimpaCampos;
  fNovo := True;
  dm.qryCria.Insert;
  dm.qryCria.FieldByName('situacao').AsString := 'Ativo';
  btnNovo.Enabled := False;
  btnGravar.Enabled := True;
  btnExcluir.Enabled := False;
  edtNome.SetFocus;
  edtCodigo.Enabled := False;
  CarregaFotosPadrao;

  edtCodigo.Text := IntToStr(frmFuncoes.AutoIncre('CRIA', 'Novo'));
end;

procedure TfrmCadastroCria.btnPesqFotoClick(Sender: TObject);
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

procedure TfrmCadastroCria.btnPesquisaMaeClick(Sender: TObject);
begin
  PesquisaMae(False);
end;

procedure TfrmCadastroCria.btnPesquisaPaiClick(Sender: TObject);
begin
  PesquisaPai(False);
end;

procedure TfrmCadastroCria.btnPesquisarClick(Sender: TObject);
begin
  PesquisaAnimal(false);
end;

procedure TfrmCadastroCria.btnPesquProprietarioClick(Sender: TObject);
begin
  PesquisaProprietario(false);
end;

procedure TfrmCadastroCria.CarregaCampos;
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
  edtNascimento.DataField := 'DATA_NASCIMENTO';
  chkSituacao.DataField := 'SITUACAO';

  dm.qryCria.FieldByName('data_nascimento').EditMask := '00/00/0000';
end;


procedure TfrmCadastroCria.CarregaFotosPadrao;
begin
  imgFotoCria.Picture.LoadFromFile('fotos/imgPadrao.png');
  imgFotoMae.Picture.LoadFromFile('fotos/imgPadrao.png');
  imgFotoPai.Picture.LoadFromFile('fotos/imgPadrao.png');
end;

procedure TfrmCadastroCria.edtCodigoExit(Sender: TObject);
begin
  if Trim(edtCodigo.Text) <> '' THEN
    PesquisaAnimal(True);
end;

procedure TfrmCadastroCria.edtCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesquisarClick(Self);
end;

procedure TfrmCadastroCria.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmCadastroCria.edtCodMaeExit(Sender: TObject);
begin
  if Trim(edtCodMae.Text) <> '' then
    PesquisaMae(True);
end;

procedure TfrmCadastroCria.edtCodPaiExit(Sender: TObject);
begin
  if Trim(edtCodPai.Text) <> '' then
    PesquisaPai(True);
end;

procedure TfrmCadastroCria.edtCodProprietarioExit(Sender: TObject);
begin
  if Trim(edtCodProprietario.Text) <> '' THEN
    PesquisaProprietario(True);
end;

procedure TfrmCadastroCria.edtCodProprietarioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesquProprietarioClick(Self)
end;

procedure TfrmCadastroCria.edtCodProprietarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmCadastroCria.FormActivate(Sender: TObject);
begin
  LimpaCampos;
  frmFuncoes.ExecutaSQL('Select * from CRIA where ID = ' + vID, 'Abrir', DM.qryCria);
  CarregaCampos;
  PageControl1.TabIndex := 0;
  edtCodigo.SetFocus;
  CarregaFotosPadrao;
end;

procedure TfrmCadastroCria.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TfrmCadastroCria.LimpaCampos;
begin
  vID := '0';
  edtCodigo.Clear;
  edtNome.Clear;
  edtIdentificacao.Clear;
  edtProprietario.Clear;
  edtCodProprietario.Clear;
  rdgTipo.ItemIndex := 0;
  chkSituacao.Checked := True;
  edtPelagem.Clear;
  edtCabeca.Clear;
  edtAE.Clear;
  edtAD.Clear;
  edtPE.Clear;
  edtPD.Clear;
  edtOutras.Clear;
  edtCaminhoFoto.Clear;
  imgFotoCria.picture := nil;
end;

procedure TfrmCadastroCria.PesquisaAnimal(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodigo.Text) <> '' then
    begin
      DM.qryCria.Close;
      DM.qryCria.SQL.Clear;
      DM.qryCria.SQL.Add('Select * from CRIA where ID = ' + QuotedStr(edtCodigo.Text));
      DM.qryCria.Open;

      if DM.qryCria.RecordCount > 0 then
      begin
        DM.qryCria.Edit;
        CarregaCampos;

        edtCodProprietario.Text := DM.qryCria.FieldByName('proprietario').AsString;
        if Trim(edtCodProprietario.Text) <> '' then
          PesquisaProprietario(True);

        if DM.qryCria.FieldByName('SEXO').AsString = 'F' then
          rdgTipo.ItemIndex := 0
        else
          rdgTipo.ItemIndex := 1;

          if DM.qryCria.FieldByName('FOTO').AsString <> '' then
            imgFotoCria.picture.loadfromfile(DM.qryCria.FieldByName('FOTO').AsString)
          else
            imgFotoCria.picture.loadfromfile('fotos/imgPadrao.png');

          {if DM.qryCria.FieldByName('FOTO_MAE').AsString <> '' then
            imgFotoMae.picture.loadfromfile(DM.qryCria.FieldByName('FOTO_MAE').AsString)
          else
            imgFotoMae.picture.loadfromfile('fotos/imgPadrao.png');

          if DM.qryCria.FieldByName('FOTO_PAI').AsString <> '' then
            imgFotoPai.picture.loadfromfile(DM.qryCria.FieldByName('FOTO_PAI').AsString)
          else
            imgFotoPai.picture.loadfromfile('fotos/imgPadrao.png'); }

          edtCodMae.Text := DM.qryCria.FieldByName('MAE').AsString;
          if Trim(edtCodMae.Text) <> '' then
            PesquisaMae(True);

          edtCodPai.Text := DM.qryCria.FieldByName('PAI').AsString;
          if Trim(edtCodPai.Text) <> '' then
            PesquisaPai(True);
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
      frmPesquisa.vTabela := 'CRIA';
      frmPesquisa.vTela := 'CAD_CRIA';
      frmPesquisa.vComando := 'Select ID, NOME, IDENTIFICACAO, DATA_NASCIMENTO, PROPRIETARIO from CRIA ORDER BY NOME';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmCadastroCria.PesquisaMae(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodMae.Text) <> '' then
    begin
      DM.qryMae.close;
      DM.qryMae.SQL.Clear;
      DM.qryMae.SQL.Add('Select * from ANIMAL where ID = ' + QuotedStr(edtCodMae.Text) + ' and SEXO = ' + QuotedStr('F'));
      DM.qryMae.Open;

      if DM.qryMae.RecordCount > 0 then
      begin
        if FileExists(DM.qryMae.FieldByName('FOTO').AsString) then
          imgFotoMae.picture.loadfromfile(DM.qryMae.FieldByName('FOTO').AsString)
        else
          imgFotoMae.picture.loadfromfile('fotos/imgPadrao.png');

        edtNomeMae.Text := DM.qryMae.FieldByName('NOME').AsString;
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
      frmPesquisa.vTela := 'CAD_CRIA_MAE';
      frmPesquisa.vComando := 'Select ID, NOME, IDENTIFICACAO, PROPRIETARIO from ANIMAL where SEXO = ' + QuotedStr('F') + ' ORDER BY NOME';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmCadastroCria.PesquisaPai(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodPai.Text) <> '' then
    begin
      DM.qryMae.close;
      DM.qryMae.SQL.Clear;
      DM.qryMae.SQL.Add('Select * from ANIMAL where ID = ' + QuotedStr(edtCodPai.Text) + ' and SEXO = ' + QuotedStr('M'));
      DM.qryMae.Open;

      if DM.qryMae.RecordCount > 0 then
      begin
        if FileExists(DM.qryMae.FieldByName('FOTO').AsString) then
          imgFotoPai.picture.loadfromfile(DM.qryMae.FieldByName('FOTO').AsString)
        else
          imgFotoPai.picture.loadfromfile('fotos/imgPadrao.png');

        edtNomePai.Text := DM.qryMae.FieldByName('NOME').AsString;
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
      frmPesquisa.vTela := 'CAD_CRIA_PAI';
      frmPesquisa.vComando := 'Select ID, NOME, IDENTIFICACAO, PROPRIETARIO from ANIMAL where SEXO = ' + QuotedStr('M') + ' ORDER BY NOME';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmCadastroCria.PesquisaProprietario(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodigo.Text) <> '' then
    begin
      DM.qryProprietario.Close;
      DM.qryProprietario.SQL.Clear;
      DM.qryProprietario.SQL.Add('Select * from PRODUTOR where ID = ' + QuotedStr(edtCodProprietario.Text));
      DM.qryProprietario.Open;

      if DM.qryProprietario.RecordCount > 0 then
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
      frmPesquisa.vTela := 'CAD_CRIA';
      frmPesquisa.vComando := 'Select ID, NOME, INSC_RURAL from PRODUTOR';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

function TfrmCadastroCria.ValidaCampos: Boolean;
var
  vRetorno : Boolean;
begin
  vRetorno := True;
  if trim(edtCodProprietario.Text) = '' then
  begin
    ShowMessage('Informe o proprietário!');
    edtCodProprietario.SetFocus;
    vRetorno := False;
  end;

  if trim(edtNome.Text) = '' then
  begin
    ShowMessage('Informe o nome do animal!');
    edtNome.SetFocus;
    vRetorno := False;
  end;

  if edtNascimento.Text = '  /  /    ' then
  begin
    ShowMessage('Informe a data de nascimento!');
    edtNascimento.SetFocus;
    vRetorno := False;
  end;

  Result := vRetorno;

end;

end.
