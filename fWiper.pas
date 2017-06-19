unit fWiper;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ActnList;

type
  TFormFileWiper = class(TForm)
    lblFile: TLabel;
    eFileName: TEdit;
    btnBrowse: TButton;
    eSize: TEdit;
    lblSize: TLabel;
    btnWipe: TButton;
    btnClose: TButton;
    pbWiping: TProgressBar;
    odWipe: TOpenDialog;
    ActionList1: TActionList;
    actWipe: TAction;
    Label1: TLabel;
    lblDriveSize: TLabel;
    lblFreeSpace: TLabel;
    Label3: TLabel;
    procedure btnBrowseClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure actWipeUpdate(Sender: TObject);
    procedure actWipeExecute(Sender: TObject);
    procedure actWipeHint(var HintStr: String; var CanShow: Boolean);
    procedure eFileNameChange(Sender: TObject);
  private
    { Private declarations }
    FCalcSize : int64;
  public
    { Public declarations }
    function WipeSize( AFileName : string ) : int64;
    function WipeFile( AFileName : string; ASize : int64 ) : int64;
  end;

var
  FormFileWiper: TFormFileWiper;

implementation

{$R *.DFM}

procedure TFormFileWiper.btnBrowseClick(Sender: TObject);
begin
  if odWipe.Execute then
  begin
    eFileName.Text := odWipe.FileName;
    odWipe.InitialDir := ExtractFilePath( odWipe.FileName );
    eSize.Text := IntToStr( WipeSize( eFileName.Text ) );
  end;
end;

procedure TFormFileWiper.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormFileWiper.actWipeUpdate(Sender: TObject);
var
  Size : int64;
begin
  try
    if eSize.Text <> '' then
      try
        Size := StrToInt( eSize.Text )
      except
        Size := 0;
      end
    else
      Size := 0;
    actWipe.Enabled := Size > 0;
  except
    actWipe.Enabled := False;
  end;
end;

procedure TFormFileWiper.actWipeExecute(Sender: TObject);
begin
  WipeFile( eFileName.Text, StrToInt( eSize.Text ) );
end;

procedure TFormFileWiper.actWipeHint(var HintStr: String;
  var CanShow: Boolean);
begin
  HintStr := 'Wipe ' + eFileName.Text;
end;

function TFormFileWiper.WipeFile(AFileName: string; ASize: int64): int64;
var
  FileOut : TFileStream;
  FileMode : Word;
  FilePos : longint;
  Writing,
  BlockSize : integer;
  Wipe : string;

begin
  if FileExists( AFileName ) then
    FileMode := fmOpenReadWrite
  else
    FileMode := fmCreate;
  if ASize > 16384 then
    BlockSize := 16384
  else
    BlockSize := ASize;
  pbWiping.Min := 0;
  pbWiping.Max := ASize;
  pbWiping.Position := 0;
  SetLength( Wipe, BlockSize );
  FillChar( Wipe[1], BlockSize, 0 );
  FilePos := 0;
  FileOut := TFileStream.Create(AFileName, FileMode );
  try
    while FilePos < ASize do
    begin
      if FilePos + BlockSize < ASize then
        Writing := BlockSize
      else
        Writing := ASize - FilePos + 1;
      FileOut.Write( Wipe[1], Writing );
      FilePos := FilePos + Writing;
      pbWiping.Position := FilePos;
    end;
  finally
    FileOut.Free;
  end;
  Result := FilePos;
end;

function TFormFileWiper.WipeSize(AFileName: string): int64;
var
  F : TFileStream;
  Drive : byte;
  DriveSize,
  FreeSpace : int64;

begin
  if AFileName <> '' then
  begin
    Drive := Ord( UpCase( AFileName[1] ) ) - Ord( '@' );
    DriveSize := DiskSize( Drive );
    FreeSpace := DiskFree( Drive );
    lblDriveSize.Caption := IntToStr( DriveSize );
    lblFreeSpace.Caption := IntToStr( FreeSpace );
    if FileExists( AFileName ) then
    begin
      F := TFileStream.Create( AFileName, fmOpenRead );
      try
        Result := F.Size;
      finally
        F.Free;
      end;
    end
    else
      Result := Round( FreeSpace * 0.95 );
  end
  else
    Result := 0;
end;

procedure TFormFileWiper.eFileNameChange(Sender: TObject);
begin
  FCalcSize := WipeSize( eFileName.Text );
end;

end.
