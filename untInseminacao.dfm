object frmInseminacao: TfrmInseminacao
  Left = 0
  Top = 0
  Caption = 'Cadastro Insemina'#231#227'o'
  ClientHeight = 495
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCentro: TPanel
    Left = 0
    Top = 0
    Width = 538
    Height = 447
    Align = alClient
    Color = clBtnHighlight
    ParentBackground = False
    TabOrder = 0
    object pnlTop: TPanel
      Left = 1
      Top = 1
      Width = 536
      Height = 112
      Align = alTop
      TabOrder = 0
      object lblCodigo: TLabel
        Left = 8
        Top = 16
        Width = 37
        Height = 13
        Caption = 'N'#250'mero'
      end
      object lblEmissao: TLabel
        Left = 124
        Top = 16
        Width = 38
        Height = 13
        Caption = 'Emiss'#227'o'
      end
      object lblProprietario: TLabel
        Left = 206
        Top = 16
        Width = 54
        Height = 13
        Caption = 'Propret'#225'rio'
      end
      object lblTouro: TLabel
        Left = 297
        Top = 61
        Width = 28
        Height = 13
        Caption = 'Touro'
      end
      object Label5: TLabel
        Left = 8
        Top = 61
        Width = 52
        Height = 13
        Caption = '&Veterin'#225'rio'
      end
      object btnPesqProprietario: TBitBtn
        Left = 266
        Top = 30
        Width = 25
        Height = 25
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFF614F4F
          5E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF614F4F787599A883875E5E5E8B8B8BFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF65B8F4408CDB
          7F7AA5A883875E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8294FF51B7FF408CDB7F7AA5A883875E5E5E8B8B8BFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF
          51B7FF408CDB7F7AA5B087875E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF55BBFF407DD27F7AA5A883876C
          666E6C666E6C666E6C666E6C666E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF8294FF51B7FF408CDB8B8B8B7B7B7BC49885D0AC93E3C9B1D5B4A47473
          736C666EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF8294FFB08787F5
          D2A9FFF4C7FFFCD0FFFFDBFFFFDCFDF6E2A883876C666EFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD0AC93EBCDA8FFF2BFFFF6C3FFFFD9FFFFE9FFFFF8FFFF
          FFF4EECD7561618B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5B4A4FFF1C4FF
          E4B1FFF9C6FFFFDBFFFFEDFFFFFAFFFFF7FFFFDBC39B8A6C666EFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD0AC93FFF6CDFFDDAAFFF5C2FFFFD6FFFFE5FFFFEDFFFF
          E6FFFFD9D0AC936C666EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5B4A4FFF4C7FF
          E5B8FFEFBCFFFFCCFFFFD6FFFFDBFFFFD9FFFCD0D0AC936C666EFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD5B4A4FFF6CDFFF1D6FFE3B7FFF1BEFFF5C2FFF9C6FFF6
          C3FFF8C5B68D808B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAB39BECE0C3FF
          FFFFFFFAE8FFECBFFFDFACFFE3B0FFF0BDF5D2A99E7373FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFD5B4A4F4EECDFFFAE8FFF6CDFFEEBBFFF4C7F8D1
          A5BB928AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5
          B4A4D5B4A4CAA58EE1BBA3DAB39B8B8B8BFFFFFFFFFFFFFFFFFF}
        TabOrder = 11
        TabStop = False
        OnClick = btnPesqProprietarioClick
      end
      object btnPesquisar: TBitBtn
        Left = 95
        Top = 30
        Width = 23
        Height = 25
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFF614F4F
          5E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF614F4F787599A883875E5E5E8B8B8BFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF65B8F4408CDB
          7F7AA5A883875E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8294FF51B7FF408CDB7F7AA5A883875E5E5E8B8B8BFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF
          51B7FF408CDB7F7AA5B087875E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF55BBFF407DD27F7AA5A883876C
          666E6C666E6C666E6C666E6C666E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF8294FF51B7FF408CDB8B8B8B7B7B7BC49885D0AC93E3C9B1D5B4A47473
          736C666EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF8294FFB08787F5
          D2A9FFF4C7FFFCD0FFFFDBFFFFDCFDF6E2A883876C666EFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD0AC93EBCDA8FFF2BFFFF6C3FFFFD9FFFFE9FFFFF8FFFF
          FFF4EECD7561618B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5B4A4FFF1C4FF
          E4B1FFF9C6FFFFDBFFFFEDFFFFFAFFFFF7FFFFDBC39B8A6C666EFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD0AC93FFF6CDFFDDAAFFF5C2FFFFD6FFFFE5FFFFEDFFFF
          E6FFFFD9D0AC936C666EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5B4A4FFF4C7FF
          E5B8FFEFBCFFFFCCFFFFD6FFFFDBFFFFD9FFFCD0D0AC936C666EFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD5B4A4FFF6CDFFF1D6FFE3B7FFF1BEFFF5C2FFF9C6FFF6
          C3FFF8C5B68D808B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAB39BECE0C3FF
          FFFFFFFAE8FFECBFFFDFACFFE3B0FFF0BDF5D2A99E7373FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFD5B4A4F4EECDFFFAE8FFF6CDFFEEBBFFF4C7F8D1
          A5BB928AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5
          B4A4D5B4A4CAA58EE1BBA3DAB39B8B8B8BFFFFFFFFFFFFFFFFFF}
        TabOrder = 12
        TabStop = False
        OnClick = btnPesquisarClick
      end
      object edtDescrProprietario: TEdit
        Left = 297
        Top = 32
        Width = 228
        Height = 21
        Enabled = False
        TabOrder = 8
      end
      object edtNumero: TEdit
        Left = 8
        Top = 32
        Width = 81
        Height = 21
        TabOrder = 4
        OnExit = edtNumeroExit
      end
      object btnPesqTouro: TBitBtn
        Left = 356
        Top = 75
        Width = 25
        Height = 25
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFF614F4F
          5E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF614F4F787599A883875E5E5E8B8B8BFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF65B8F4408CDB
          7F7AA5A883875E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8294FF51B7FF408CDB7F7AA5A883875E5E5E8B8B8BFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF
          51B7FF408CDB7F7AA5B087875E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF55BBFF407DD27F7AA5A883876C
          666E6C666E6C666E6C666E6C666E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF8294FF51B7FF408CDB8B8B8B7B7B7BC49885D0AC93E3C9B1D5B4A47473
          736C666EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF8294FFB08787F5
          D2A9FFF4C7FFFCD0FFFFDBFFFFDCFDF6E2A883876C666EFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD0AC93EBCDA8FFF2BFFFF6C3FFFFD9FFFFE9FFFFF8FFFF
          FFF4EECD7561618B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5B4A4FFF1C4FF
          E4B1FFF9C6FFFFDBFFFFEDFFFFFAFFFFF7FFFFDBC39B8A6C666EFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD0AC93FFF6CDFFDDAAFFF5C2FFFFD6FFFFE5FFFFEDFFFF
          E6FFFFD9D0AC936C666EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5B4A4FFF4C7FF
          E5B8FFEFBCFFFFCCFFFFD6FFFFDBFFFFD9FFFCD0D0AC936C666EFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD5B4A4FFF6CDFFF1D6FFE3B7FFF1BEFFF5C2FFF9C6FFF6
          C3FFF8C5B68D808B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAB39BECE0C3FF
          FFFFFFFAE8FFECBFFFDFACFFE3B0FFF0BDF5D2A99E7373FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFD5B4A4F4EECDFFFAE8FFF6CDFFEEBBFFF4C7F8D1
          A5BB928AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5
          B4A4D5B4A4CAA58EE1BBA3DAB39B8B8B8BFFFFFFFFFFFFFFFFFF}
        TabOrder = 10
        TabStop = False
        OnClick = btnPesqTouroClick
      end
      object edtDescrTouro: TEdit
        Left = 387
        Top = 77
        Width = 138
        Height = 21
        Enabled = False
        TabOrder = 5
      end
      object edtCodTouro: TEdit
        Left = 297
        Top = 77
        Width = 52
        Height = 21
        TabOrder = 3
        OnExit = edtCodTouroExit
      end
      object edtCodProprietario: TEdit
        Left = 206
        Top = 32
        Width = 52
        Height = 21
        TabOrder = 1
        OnExit = edtCodProprietarioExit
      end
      object edtDtEmissao: TDateTimePicker
        Left = 124
        Top = 32
        Width = 78
        Height = 21
        Date = 43039.814233217590000000
        Time = 43039.814233217590000000
        TabOrder = 0
      end
      object edtCodVet: TEdit
        Left = 8
        Top = 77
        Width = 52
        Height = 21
        TabOrder = 2
        OnExit = edtCodVetExit
      end
      object btnPesqVet: TBitBtn
        Left = 66
        Top = 75
        Width = 25
        Height = 25
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFF614F4F
          5E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF614F4F787599A883875E5E5E8B8B8BFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF65B8F4408CDB
          7F7AA5A883875E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8294FF51B7FF408CDB7F7AA5A883875E5E5E8B8B8BFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF
          51B7FF408CDB7F7AA5B087875E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF55BBFF407DD27F7AA5A883876C
          666E6C666E6C666E6C666E6C666E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF8294FF51B7FF408CDB8B8B8B7B7B7BC49885D0AC93E3C9B1D5B4A47473
          736C666EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF8294FFB08787F5
          D2A9FFF4C7FFFCD0FFFFDBFFFFDCFDF6E2A883876C666EFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD0AC93EBCDA8FFF2BFFFF6C3FFFFD9FFFFE9FFFFF8FFFF
          FFF4EECD7561618B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5B4A4FFF1C4FF
          E4B1FFF9C6FFFFDBFFFFEDFFFFFAFFFFF7FFFFDBC39B8A6C666EFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD0AC93FFF6CDFFDDAAFFF5C2FFFFD6FFFFE5FFFFEDFFFF
          E6FFFFD9D0AC936C666EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5B4A4FFF4C7FF
          E5B8FFEFBCFFFFCCFFFFD6FFFFDBFFFFD9FFFCD0D0AC936C666EFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD5B4A4FFF6CDFFF1D6FFE3B7FFF1BEFFF5C2FFF9C6FFF6
          C3FFF8C5B68D808B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAB39BECE0C3FF
          FFFFFFFAE8FFECBFFFDFACFFE3B0FFF0BDF5D2A99E7373FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFD5B4A4F4EECDFFFAE8FFF6CDFFEEBBFFF4C7F8D1
          A5BB928AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5
          B4A4D5B4A4CAA58EE1BBA3DAB39B8B8B8BFFFFFFFFFFFFFFFFFF}
        TabOrder = 9
        TabStop = False
        OnClick = btnPesqVetClick
      end
      object edtDescrVeterinario: TEdit
        Left = 97
        Top = 77
        Width = 194
        Height = 21
        Enabled = False
        TabOrder = 6
      end
      object edtID: TEdit
        Left = 51
        Top = 5
        Width = 67
        Height = 21
        TabOrder = 7
        Visible = False
      end
    end
    object pnlDados: TPanel
      Left = 1
      Top = 113
      Width = 536
      Height = 132
      Align = alClient
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 47
        Width = 31
        Height = 13
        Caption = 'Animal'
      end
      object Label2: TLabel
        Left = 8
        Top = 6
        Width = 35
        Height = 13
        Caption = 'Servi'#231'o'
      end
      object Label3: TLabel
        Left = 297
        Top = 6
        Width = 56
        Height = 13
        Caption = 'Vlr. Unit'#225'rio'
      end
      object btnPesqAnimal: TBitBtn
        Left = 66
        Top = 62
        Width = 25
        Height = 25
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFF614F4F
          5E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF614F4F787599A883875E5E5E8B8B8BFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF65B8F4408CDB
          7F7AA5A883875E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8294FF51B7FF408CDB7F7AA5A883875E5E5E8B8B8BFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF
          51B7FF408CDB7F7AA5B087875E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF55BBFF407DD27F7AA5A883876C
          666E6C666E6C666E6C666E6C666E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF8294FF51B7FF408CDB8B8B8B7B7B7BC49885D0AC93E3C9B1D5B4A47473
          736C666EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF8294FFB08787F5
          D2A9FFF4C7FFFCD0FFFFDBFFFFDCFDF6E2A883876C666EFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD0AC93EBCDA8FFF2BFFFF6C3FFFFD9FFFFE9FFFFF8FFFF
          FFF4EECD7561618B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5B4A4FFF1C4FF
          E4B1FFF9C6FFFFDBFFFFEDFFFFFAFFFFF7FFFFDBC39B8A6C666EFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD0AC93FFF6CDFFDDAAFFF5C2FFFFD6FFFFE5FFFFEDFFFF
          E6FFFFD9D0AC936C666EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5B4A4FFF4C7FF
          E5B8FFEFBCFFFFCCFFFFD6FFFFDBFFFFD9FFFCD0D0AC936C666EFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD5B4A4FFF6CDFFF1D6FFE3B7FFF1BEFFF5C2FFF9C6FFF6
          C3FFF8C5B68D808B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAB39BECE0C3FF
          FFFFFFFAE8FFECBFFFDFACFFE3B0FFF0BDF5D2A99E7373FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFD5B4A4F4EECDFFFAE8FFF6CDFFEEBBFFF4C7F8D1
          A5BB928AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5
          B4A4D5B4A4CAA58EE1BBA3DAB39B8B8B8BFFFFFFFFFFFFFFFFFF}
        TabOrder = 8
        TabStop = False
        OnClick = btnPesqAnimalClick
      end
      object edtDescrAnimal: TEdit
        Left = 97
        Top = 64
        Width = 194
        Height = 21
        Enabled = False
        TabOrder = 4
      end
      object btnPesqServico: TBitBtn
        Left = 66
        Top = 19
        Width = 25
        Height = 25
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FFFFFF614F4F
          5E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF614F4F787599A883875E5E5E8B8B8BFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF65B8F4408CDB
          7F7AA5A883875E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF8294FF51B7FF408CDB7F7AA5A883875E5E5E8B8B8BFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF
          51B7FF408CDB7F7AA5B087875E5E5E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF55BBFF407DD27F7AA5A883876C
          666E6C666E6C666E6C666E6C666E8B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF8294FF51B7FF408CDB8B8B8B7B7B7BC49885D0AC93E3C9B1D5B4A47473
          736C666EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8294FF8294FFB08787F5
          D2A9FFF4C7FFFCD0FFFFDBFFFFDCFDF6E2A883876C666EFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD0AC93EBCDA8FFF2BFFFF6C3FFFFD9FFFFE9FFFFF8FFFF
          FFF4EECD7561618B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5B4A4FFF1C4FF
          E4B1FFF9C6FFFFDBFFFFEDFFFFFAFFFFF7FFFFDBC39B8A6C666EFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD0AC93FFF6CDFFDDAAFFF5C2FFFFD6FFFFE5FFFFEDFFFF
          E6FFFFD9D0AC936C666EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5B4A4FFF4C7FF
          E5B8FFEFBCFFFFCCFFFFD6FFFFDBFFFFD9FFFCD0D0AC936C666EFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD5B4A4FFF6CDFFF1D6FFE3B7FFF1BEFFF5C2FFF9C6FFF6
          C3FFF8C5B68D808B8B8BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAB39BECE0C3FF
          FFFFFFFAE8FFECBFFFDFACFFE3B0FFF0BDF5D2A99E7373FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFD5B4A4F4EECDFFFAE8FFF6CDFFEEBBFFF4C7F8D1
          A5BB928AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5
          B4A4D5B4A4CAA58EE1BBA3DAB39B8B8B8BFFFFFFFFFFFFFFFFFF}
        TabOrder = 6
        TabStop = False
        OnClick = btnPesqServicoClick
      end
      object edtDescrServico: TEdit
        Left = 97
        Top = 20
        Width = 194
        Height = 21
        Enabled = False
        TabOrder = 5
      end
      object edtVlrUnit: TEdit
        Left = 297
        Top = 20
        Width = 90
        Height = 21
        TabOrder = 1
        Text = '0,00'
      end
      object edtCodAnimal: TEdit
        Left = 8
        Top = 64
        Width = 52
        Height = 21
        TabOrder = 2
        OnExit = edtCodAnimalExit
      end
      object edtCodServico: TEdit
        Left = 8
        Top = 20
        Width = 52
        Height = 21
        TabOrder = 0
        OnExit = edtCodServicoExit
      end
      object btnAdd: TBitBtn
        Left = 8
        Top = 91
        Width = 85
        Height = 32
        Caption = 'Confirmar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0EEE08FBF913A8C3E24
          79282476283A843E8FB991E0EBE0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFB5D9B6308E34419F5186CA999AD3AA9AD2AA82C7953C964B307B33B4D0
          B6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB5DBBA248E296CBD82A7DBB486CC9765
          BB7C63B97B85CB97A4D9B365B67C237126B4D0B6FFFFFFFFFFFFFFFFFFE1F2E4
          32A04371C186A7DBB15FBB765BB97258B76F58B46E57B46E5AB673A4D9B268B7
          7E307F34E0ECE1FFFFFFFFFFFF8FD29F4BAF63A9DDB363C0785EBD7074C484D4
          ECD989CD9855B56B57B46D5BB673A5DAB3409A4D8EBB90FFFFFFFFFFFF3EB45C
          90D29E8CD49963C27378C986F2FAF4FFFFFFFDFEFD85CB9556B66C5AB87184CC
          9686C7993A8A3EFFFFFFFFFFFF26AF48A5DCAE6FCA7E72CA7FF0F9F1FFFFFFEB
          F7EDFFFFFFFBFDFC87CD955AB87066BD7C9FD7AE227E25FFFFFFFFFFFF2DB650
          A6DDB071CC7F65C772AFE1B6D2EED662C06FB7E3BEFFFFFFFBFDFC8BD09868C0
          7DA0D7AD228325FFFFFFFFFFFF4AC46B94D7A090D79A68C97563C56E60C36D60
          C26E60C16EB8E4BFFFFFFFE3F4E68AD1988ACE9C3B983FFFFFFFFFFFFF9ADEAC
          56BE6FAEE1B66CCC7967C87164C76F62C46D61C36D62C370B5E3BD6EC77DABDF
          B447A85D8EC793FFFFFFFFFFFFE4F7E948C4657ECE8FADE1B46CCC7969CA7567
          C87167C87367C8746AC978ABDFB375C38832A042E1F1E3FFFFFFFFFFFFFFFFFF
          BFECCA3CC25B7ECE8FAEE1B691D89C76CE8276CE8291D89CADE1B477C88A26A0
          3AB5DFBDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0EDCB49C76858C17395D7A2A4
          DCADA4DCAD94D6A04FB86934B254B6E3C1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFE5F8E99EE2B054CA713ABF5B36BD5948C26A97DBAAE1F5E7FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        TabOrder = 3
        OnClick = btnAddClick
      end
      object btnDelete: TBitBtn
        Left = 99
        Top = 91
        Width = 88
        Height = 32
        Caption = 'Excluir'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5E7F79EA9E1536AC63E
          58BF3953BE4B66C197A7DBE1E6F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFC2C8ED5465CB3B51CC7479E88E91EE8E91EE7077E4324CC03F5BBDB9C4
          E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC5C9EF505FCD5B64E0A0A5F57D85EF5A
          62E9585CE77C83EE9D9FF4505CD73351B9B9C4E7FFFFFFFFFFFFFFFFFFE8EAF9
          6470D4606AE3A0ABF5535EEC4F5BEA4C58E94D58E64B55E64F55E69DA1F4535F
          D63F5CBEE2E7F5FFFFFFFFFFFFACB0EA4A55DBA1AAF65563F05165EE4C58E94C
          58E94C58E94C58E94B57E65159E69EA2F5334FC395A5DBFFFFFFFFFFFF7277DD
          808BEE7D90F75C72F34C58E94C58E94C58E94C58E94C58E94C58E94E5AE97A82
          F0747AE24B64C3FFFFFFFFFFFF6468DBA0AAF76F85F86781F6FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF4C58E95B65EA959BF13855BDFFFFFFFFFFFF696DDC
          AEB8F97E92FA6F84F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4C58E95D69
          EE959CF13C54BFFFFFFFFFFFFF7C7EE3A4AEF59CAAFA768BF0535EEC535EEC53
          5EEC535EEC535EEC535EEC6276F2808DF4777EE9556AC8FFFFFFFFFFFFB5B4F0
          7C82EACDD4FC8A9CFA7D92F77489EE6B83F66B83F66B83F66B83F66278F3A3AE
          F83D4ED09FAAE0FFFFFFFFFFFFEBEBFB7877E3A2A6F3D4DBFD8699FA7E90F079
          8DF17E93F87D91F9758BF8A7B5F8626DE35767CDE6E8F7FFFFFFFFFFFFFFFFFF
          CFCFF66F6FE1A9ACF2D8DCFDADB9FA90A2FA8A9CFA9BA8FBB9C7FC6F7AE95361
          CEC3C8EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFF67878E28D92EDBDC2F8CC
          D3F9C3CBF9A9B3F4656FE2636DD6C6CAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFEBEBFBB6B5F07C7EE2696ADE676ADC7378DEAEB2EBE8E9F9FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        TabOrder = 7
        TabStop = False
      end
    end
    object pgctrlDados: TPageControl
      Left = 1
      Top = 245
      Width = 536
      Height = 201
      ActivePage = TabSheet1
      Align = alBottom
      TabOrder = 2
      object TabSheet1: TTabSheet
        Caption = 'Dados'
        object dbgDados: TDBGrid
          Left = 0
          Top = 0
          Width = 528
          Height = 173
          Align = alClient
          DataSource = dtsCadInseminacao
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = dbgDadosDrawColumnCell
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Observa'#231#227'o'
        ImageIndex = 1
        object Label4: TLabel
          Left = 8
          Top = 11
          Width = 58
          Height = 13
          Caption = 'Observa'#231#227'o'
        end
        object edtObs: TMemo
          Left = 8
          Top = 30
          Width = 500
          Height = 140
          Lines.Strings = (
            'Memo1')
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 447
    Width = 538
    Height = 48
    Align = alBottom
    TabOrder = 1
    object btnNovo: TBitBtn
      Left = 8
      Top = 5
      Width = 75
      Height = 37
      Caption = '&Novo'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FBFBFBF9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9
        F9FAFAFAFFFFFFFFFFFFFFFFFFFDFDFDBFBFBFD3D3D3D5D5D5D5D5D5D6D6D6D7
        D7D7D8D8D8D9D9D9D9D9D9D9D9D9D9D9D9BFBFBFF8F8F8FFFFFFFFFFFFFFFFFF
        D2D2D2E8E8E8EAEAEAECECECEFEFEFF1F1F1F3F3F3F5F5F5F7F7F7F7F7F7F5F5
        F5D6D6D6FFFFFFFFFFFFFFFFFFFFFFFFD3D3D3E8E8E8EBEBEBEDEDEDEFEFEFF1
        F1F1F4F4F4F6F6F6F8F8F8F8F8F8F6F6F6D7D7D7FFFFFFFFFFFFFFFFFFFFFFFF
        D4D4D4E8E8E8EAEAEAECECECEFEFEFF1F1F1F3F3F3F5F5F5F7F7F7F7F7F7F5F5
        F5D6D6D6FFFFFFFFFFFFFFFFFFFFFFFFD4D4D4E8E8E8EAEAEAECECECEEEEEEF0
        F0F0F2F2F2F4F4F4F5F5F5F5F5F5F4F4F4D6D6D6FFFFFFFFFFFFFFFFFFFFFFFF
        D5D5D5E7E7E7E9E9E9EBEBEBEDEDEDEFEFEFF1F1F1F2F2F2F3F3F3F3F3F3F2F2
        F2D5D5D5FFFFFFFFFFFFFFFFFFFFFFFFD5D5D5E6E6E6E8E8E8EAEAEAECECECEE
        EEEEEFEFEFF0F0F0F1F1F1F1F1F1F0F0F0D5D5D5FFFFFFFFFFFFFFFFFFFFFFFF
        D5D5D5DBDCDC5A90B2E8E8E9E7E7E75A8FB0EDEDEDEEEEEEEFEFEFEFEFEFEEEE
        EED5D5D5FFFFFFFFFFFFFFFFFFFFFFFFD6D6D6D7D8D967A3C890B3C989ABC065
        A2C7EBEBEBECECECDBEDEDAEEEEF9DEEEFA5D9DAFBFEFEFFFFFFFFFFFFFFFFFF
        D6D6D6D8D8D860A2CA70AFD670AFD55FA1C9E9E9E9DCEAEB8BEEEF97F6F763F4
        F588ECEDAEF9FAFEFFFFFFFFFFFFFFFFD6D6D6D8D8D7519AC75AAADB5AAADB50
        99C6E7E7E7BBEAEA54EDEFEAFDFDFFFFFFAEF8F96FF6F8E9FDFDFFFFFFFFFFFF
        D6D6D6D7D6D64B97C551A6D951A6D94B97C5E5E5E5B4E9E9A1F5F5FEFFFFFFFF
        FFF4FEFE7EF7F8E4FDFDFFFFFFFFFFFFD5D5D5D5D5D44B97C551A6D951A6D94B
        97C5E3E3E3CBE5E675E6E778F3F5E4FDFD60F5F795F9F9F7FEFFFFFFFFFFFFFF
        CCCCCCC4C9CC78AFD18FC6E78FC6E76DA7CBD6D6D6D3D5D59AC4C47CE5E792F8
        F9A2F9FAE5FDFDFFFFFFFFFFFFFFFFFFFFFFFFCCDDE7BED5E3BBD3E3BBD3E3D5
        E4EDFFFFFFFFFFFFFFFFFFF7FEFEF0FEFEFAFFFFFFFFFFFFFFFF}
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnGravar: TBitBtn
      Left = 89
      Top = 6
      Width = 75
      Height = 37
      Caption = '&Gravar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
        FDFEFEFEFFFFFFFFFFFFFFFFFFF9F9F8E4E4E4DBDBDBDADADADADADADADADADA
        DADADADADADADADADADADADADADADADADADDDDDDEBEAEAFDFDFDFEFEFEE1E1E1
        9A8474BE8F6A979B99B5B9B7ABB0ADA0A6A3A1A6A4A7ACA9858A87B9875EBB8B
        63B582589E8777F0F0F0FEFEFEB6ADA6D2A984CF9E71ABB1AE9A9387A485669B
        A29EB7BFBBC7CDCAA7ABA9CE9C6FD0A279C79568A0856FF2F1F1FFFFFFD4C4B8
        D6AD87CF9E71A3ABA79B8E7CC38F619EA4A2B9C1BDBCC3BFA7ACA9CB996CCD9D
        72C49264B49680FEFEFDFFFFFFDDCBBED6AE88CF9E719BA4A0898375957151A9
        AFACC3CAC7B7BEBAA3A8A6C99668C9986CC18E60C5A48AFFFFFFFFFFFFDFCDBF
        D7AE89CF9E71A2917BAA9D8DAEA08FB1A292AFA090AB9D8D9F8A75BE8A5DBE8A
        5DC18D5FC7A58BFFFFFFFFFFFFDFCDBFD7AF8AC39A76C7A588C6A487C5A386C5
        A285C4A184C3A183C3A082C29F81C09B7CBC8759C8A68CFFFFFFFFFFFFDFCCBF
        D7AF8AD7C5B6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F5
        F5B27C4EC7A68CFFFFFFFFFFFFDFCCBFD5AD88D0C1B2EFF1F0EFF1F0EFF1F0EF
        F1F0EFF1F0EFF1F0EFF1F0EFF1F0E7EBE9B1794BC7A68DFFFFFFFFFFFFDFCCBE
        D3AB86D5C3B4FBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF1F2
        F2AF7648C7A68EFFFFFFFFFFFFDECCBED1A883D3C1B2F5F6F6F5F6F6F5F6F6F5
        F6F6F5F6F6F5F6F6F5F6F6F5F6F6EEEFEFAD7446C7A68EFFFFFFFFFFFFDECCBE
        CFA581CCBCADE5E8E7E5E8E7E5E8E7E5E8E7E5E8E7E5E8E7E5E8E7E5E8E7E1E5
        E3AB7143C6A68EFFFFFFFFFFFFDECBBECAA280D0BEAFECEEEEECEEEEECEEEEEC
        EEEEECEEEEECEEEEECEEEEECEEEEE7EAEAAA7449C6A68FFFFFFFFFFFFFE8DBD2
        BD93724C82C21D7EE91D7EE91D7EE91D7EE91D7EE91D7EE91D7EE91D7EE91D7E
        E9AB7851C9AE9BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 1
      OnClick = btnGravarClick
    end
    object btnCancelar: TBitBtn
      Left = 170
      Top = 6
      Width = 75
      Height = 37
      Caption = '&Cancelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFCFCFCF6F6F8EFEFF2ECECF0ECECF0F0F0F3F6F6F8FDFDFDFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5F6DBDBDCADADB45B5B992929A70D
        0DB20D0DB22828A75B5B99ADADB5DCDCDDF6F6F7FFFFFFFFFFFFFFFFFFF9F9FA
        D7D7D770709A1010B40404BB0000BA0000BA0000BA0000BA0404BB1111B56D6D
        9BD8D8D8FAFAFBFFFFFFFFFFFFFEFEFE8484B30B0BBC0000BC0000BC0000BC00
        00BC0000BC0000BC0000BC0000BC0C0CBC8181B6FEFEFEFFFFFFFFFFFFD3D3EC
        1313BE0000BF0000BF0000BE0000BE0000BE0000BE0000BE0000BE0000BE0000
        BE1313BECFCFEBFFFFFFFFFFFF5C5CCC0303C20000C10000C10000C10000C000
        00C00000C00000C00000C00000C00000C00303C05858CBFFFFFFF6F6FC1818BF
        0202C40404C40808C50C0CC61111C71515C81919C91C1CCA1C1CC91818C91212
        C70707C41818BFF2F2FBD0D0F12828CB1F1FCD3F3FD46464DC6565DC6565DC65
        65DC6565DC6565DC6565DC6464DC3737D21F1FCC2828CBCACAEFC7C7EF2B2BCF
        2020CF8686E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6C6C
        DF2020CE2E2ECFC1C1ECDFDFF62B2BCC2020D22222D22424D22525D22626D227
        27D22727D22626D22525D22424D12222D12020D12D2DCCDADAF4FFFFFF3D3DC8
        2121D32323D32424D32626D42727D42828D42828D42727D42626D42424D32323
        D22121D23A3AC8FEFEFFFFFFFF9292DE2E2ED42323D32525D32626D42828D429
        29D42929D42828D42626D42525D32323D32D2DD48E8EDDFFFFFFFFFFFFF9F9FD
        4747CA2929D42525D42727D42828D42A2AD52A2AD52828D42727D42525D42828
        D44646CBF7F7FDFFFFFFFFFFFFFFFFFFE2E2F74444CA3030D52727D42828D42A
        2AD42A2AD42828D42727D42F2FD54242CADFDFF6FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFEEEEFA7474D53434CB3939D63434D63333D63939D73333CC7272D4EDED
        FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBEBF9ABABE58D
        8DDD8D8DDDAAAAE5E9E9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 2
    end
    object btnExcluir: TBitBtn
      Left = 251
      Top = 6
      Width = 75
      Height = 37
      Caption = '&Excluir'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFCFCFCF5F5F5F0F0F0E9E9E9E8E8E8EDEDEDF3F3F3FAFAFAFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAD5D5D5949595989B99A9ADABB0
        B5B2A6ABA8979B99888B8A8C8D8DCFCFCFF5F5F5FFFFFFFFFFFFFFFFFFFFFFFF
        E9E9E9939593B7BBB9B7BDB9D0D6D3C1C8C4C5CBC8A3A9A69DA3A0919794787B
        79E1E1E1FCFCFCFFFFFFFFFFFFFFFFFFFBFBFBA3A6A5B1B5B3C5C9C7D8DCDAB3
        B9B6C9CECC8C918E919693818683757A77F7F7F7FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFA8ABAAB0B4B2C5C9C7D6DAD8B3B9B6C6CBC88B908D8E93907D82806C70
        6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA6A8A7AFB4B1C3C8C5D5D9D7B3
        B9B6C2C7C48A8F8C8E93907D8280696D6BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFA5A8A7AFB3B1C2C6C4D5D9D7B3B9B6C0C5C2898E8B8D92907D8280696D
        6BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA6A9A7AEB2B0C0C5C2D5D9D7B3
        B9B6BFC5C2888D8A8D928F7D8280696D6BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFA5A8A7A7ABA9A7ABA89EA2A07F8481858A876B6F6D787D7A777B79686C
        6AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8B8E8DA0A3A2BBBEBDDCDFDEDC
        DFDECED1D0B9BCBA9B9F9D818583646766FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        E5E6E6B5B8B7CACECDE2E4E3EAECECE6E8E7DBDEDDCCD0CEBABEBDA2A7A58A8D
        8CE0E1E1FFFFFFFFFFFFFFFFFFFFFFFFD3D5D4EBECEBF3F4F3EBECECE3E5E4D4
        D7D5C7CCCABEC3C1B5BCB9B6BDBAAEB3B1CED0CFFFFFFFFFFFFFFFFFFFFFFFFF
        F4F5F4CACACAEAECEBDCDFDED4D6D5909492858A88BDC1BFAEB4B2B8BEBB9BA0
        9EF1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9CFD0CFBCBEBDB9BCBBDC
        DDDDCED1D0A2A7A5ACAFAEC3C5C4F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF3F3F3B5B8B6ADB0B0F0F1F1FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 3
      OnClick = btnExcluirClick
    end
    object btnFechar: TBitBtn
      Left = 438
      Top = 6
      Width = 75
      Height = 37
      Caption = '&Fechar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFEFEFEFCFCFCFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFCFC
        FCFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F6F6AFAFAE93939193939193
        9391939391939391939391939391949492ADACABF1F2F1FFFFFFFFFFFFFFFFFF
        FFFFFFF2F2F37D867F6CA2843381552E7F522E7F522E7F522E7F522E7F522E7F
        525C7967EEEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7DB2E3E4ECCDD5D176
        99853A755330724C30724C30724C30724C6E8D7AFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF6666CB4544CBD0D2E2DCDFDFBFC4C179908336674A2C67452C67
        4570927DFFFFFFFFFFFFC9C8EF6565D66565D66767D73D3CCE0707D93333CCAF
        B2CFC4CAC8B9BFBC75897E275C3D275C3D6F907CFFFFFFFFFFFFB0B0E71515DC
        0101D90101D90101D90101D90404DA2626D08D90BEB3BAB775877D2250352250
        356E8C7AFFFFFFFFFFFFB1B1E82222EF1C1CEE2727EF2C2CEF2B2BEF2424EF25
        25EC4D4EC0B2B9B773837A1D452E1D452E6D8977FFFFFFFFFFFFB1B1E84B4BFE
        4B4BFE4B4BFE4B4BFE3C3CFE4747F96B6CCDC0C6C7757977727F771839261839
        266B8675FFFFFFFFFFFFE5E5F8B2B2E9B3B2E9B5B4EA5857D33D3DF67D7DD3D6
        D9D9C4CAC88F9492717C76132E1E132E1E6A8373FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF6E6DD28D8DD7E8EAEAD7DBDAC4CAC8B3BAB77079740F23170F23
        17698071FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9A9CB8ECEEEEE8EBEAD7
        DBDAC4CAC8B3BAB76E75710A17100A1710677C6FFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFADAFAFECEEEEE8EBEAD7DBDAC2C7C5A9B0AD666A68050C08050C
        0866796DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADAEABECEEEEDEE0E0A8
        ABAA848886777C7A42444300010100020166776CFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC1C2C0A6A7A49292908B8C8A8485847C7D7C7272716869676667
        659A9D9AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 4
      OnClick = btnFecharClick
    end
  end
  object qryCadInseminacao: TFDQuery
    CachedUpdates = True
    Connection = DM.FDConnection1
    Left = 416
    Top = 128
  end
  object dtsCadInseminacao: TDataSource
    DataSet = qryCadInseminacao
    Left = 472
    Top = 128
  end
end
