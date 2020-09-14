program MergePDFDocumentsFromURLs;

//*******************************************************************************************//
//                                                                                           //
// Download Free Evaluation Version From: https://bytescout.com/download/web-installer       //
//                                                                                           //
// Also available as Web API! Get Your Free API Key: https://app.pdf.co/signup               //
//                                                                                           //
// Copyright � 2017-2020 ByteScout, Inc. All rights reserved.                                //
// https://www.bytescout.com                                                                 //
// https://pdf.co                                                                            //
//                                                                                           //
//*******************************************************************************************//

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Classes,
  IdURI,
  ByteScoutWebApiExec in 'ByteScoutWebApiExec.pas';

const
    // The authentication key (API Key).
    // Get your own by registering at https://app.pdf.co/documentation/api
    API_KEY: string = '********************************************'
	// Destination PDF file name
	DESTINATION_FILE: string = 'result.pdf';
    // Direct URLs of PDF files to merge
	SOURCE_FILES: array [0..1] of string = (
        'https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-merge/sample1.pdf',
        'https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-merge/sample2.pdf'
    );
var
    query: string;
    file_name: string;
    waiting_any_key: char;
    files: string;
    i: integer;

begin
    try
        // Prepare URL for `Merge PDF` API call
        files := '';
        for i := 0 to High(SOURCE_FILES) do begin

            if (Length(files) > 0) then
                files := files + ',';
            files := files + SOURCE_FILES[i];
        end;
		query := TIdURI.URLEncode(Format('https://api.pdf.co/v1/pdf/merge' +
            '?name=%s&url=%s',
            [ExtractFileName(DESTINATION_FILE), files]));

        if (WebAPIExec(query, API_KEY, file_name)) then
            Writeln(Format('Generated PDF file saved as "%s" file.', [file_name]));
    finally
        Writeln('Press any key to continue...');
        Readln(waiting_any_key);
    end;
end.
