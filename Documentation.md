

# PDF.co Web API (Application Programming Interface)

## Benefits:

- **Security**: API runs on the secure Amazon AWS infrastructure. All data transfers are encrypted by SSL/TLS encryption;
- **Zapier plugin** [is available](https://pdf.co/zapier/) 
- **Offline** on-premise SDKs [are available too](https://pdf.co/offline-download) for running on your own servers
- **Asynchronous mode** is supported so you can process large files and documents with 100+ pages in the cloud
- **API** uses so called *credits* from your account which are reduced for every call and for every page. For example, processing/generating document with 2 pages requires 2 credits. Separate methods like uploading, background job check require 1 credit. You may always see how may credits are left using `remainingCredits` property in the returned result.

## How to use API with URL as input

- Generate a *temporary* public link to your document or file on your side
- Call any API method with `url` param set to your file's url
- It will return JSON with a temporary URL to new generated file. Some endpoints like `pdf/to/text` have `inline` property to return generated content inside `body` property of the response.

## How to use API with file as input

- Upload your file using `file` input param available in many API methods
- API methods will return JSON with a temporary URL to new generated file. Some endpoints like `pdf/to/text` have `inline` property to return generated content inside `body` property of the response.

## How to use API with large files and with 100+ pages documents

We've designed this mode to be scalable and support large files and documents with hundreds of pages. 

- Default timeout for all API calls is around `25` seconds. If your call to API (for example, if you run text recognition on 100+ pages scanned document) takes more time then you should use *async* mode. 
- Enable `async` mode by setting `async` input parameter to `true`. This will tell API method to run processing and background and method will immediately return unique id of new background job (as `jobId` property). 
- Check status of background job status using `/job/check` and wait until it returns `status` as `success`

**Asynchronious mode workflow: step by step**

1. Request a temporary URL for upload using `/file/upload/get-presigned-url`
2. Upload your file using `POST` to this temporary URL using any 3rd party way or use `/file/upload` API method
3. Call API method with this temporary URL as input in `url` param. Set `async` param to `true` so API method will return immediately and will send you output URL (or set of URLs) along with `jobId` immediately. `jobId` is the unique identificator of the background job that will be running on the server.
4. Now check `status` of this background job using `/job/check` API method with `jobId` param. It will return execution `status`. 
5. Once `/job/check` returns `status` param as `success` you may use the previously generated output URL (or set of URLs) to download generated data.

## Source Code Samples

We have hundreds of ready to copy Explore [Source Code Samples on Github](https://github.com/bytescout/pdf-co-api-samples) available for Javascript, Node.js, PHP, Java, C# and Visual Basic NET.

## Contact our Customer API Support 

Our **dedicated**  API support team is happy to help with integrations and with proof of concept projects! Please [click here to send request](https://bytescout.zendesk.com/hc/en-us/requests/new?subject=PDF.co%20API) (recommended) or send email to [pdfco@bytescout.zendesk.com](mailto:pdfco@bytescout.zendesk.com?subject=PDF.co%20API%20support) 

### [Get your free PDF.co API key](https://app.pdf.co/signup)

# PDF.co API v.1.0 Documentation

- [E-Signatures and Forms](#e-signatures-and-forms)
  * [Manage Fillable Templates](#manage-fillable-templates)
    + [https://api.pdf.co/v1/templates](#https---apipdfco-v1-templates)
    + [https://api.pdf.co/v1/templates/:id](#https---apipdfco-v1-templates--id)
  * [Send E-Signature Request](#send-e-signature-request)
    + [https://api.pdf.co/v1/templates/:id/use](#https---apipdfco-v1-templates--id-use)
  * [Manage Documents](#manage-documents)
    + [https://api.pdf.co/v1/documents](#https---apipdfco-v1-documents)
    + [https://api.pdf.co/v1/documents/:id](#https---apipdfco-v1-documents--id)
  * [Add E-Signature and Text To PDF](#add-e-signature-and-text-to-pdf)
    + [https://api.pdf.co/v1/pdf/sign](#https---apipdfco-v1-pdf-sign)
- [Extract Data](#extract-data)
  * [Template Based Extraction](#template-based-extraction)
    + [https://api.pdf.co/v1/pdf/documentparser](#https---apipdfco-v1-pdf-documentparser)
  * [Invoice Parser](#invoice-parser)
    + [https://api.pdf.co/v1/pdf/invoiceparser](#https---apipdfco-v1-pdf-invoiceparser)
  * [Read PDF Information](#read-pdf-information)
    + [https://api.pdf.co/v1/pdf/info](#https---apipdfco-v1-pdf-info)
  * [Search inside PDF and Images](#search-inside-pdf-and-images)
    + [https://api.pdf.co/v1/pdf/find](#https---apipdfco-v1-pdf-find)
  * [Extract as CSV, XML, JSON, HTML](#extract-as-csv--xml--json--html)
    + [https://api.pdf.co/v1/pdf/convert/to/csv](#https---apipdfco-v1-pdf-convert-to-csv)
    + [https://api.pdf.co/v1/pdf/convert/to/json](#https---apipdfco-v1-pdf-convert-to-json)
    + [https://api.pdf.co/v1/pdf/convert/to/text](#https---apipdfco-v1-pdf-convert-to-text)
    + [https://api.pdf.co/v1/pdf/convert/to/xls](#https---apipdfco-v1-pdf-convert-to-xls)
    + [https://api.pdf.co/v1/pdf/convert/to/xlsx](#https---apipdfco-v1-pdf-convert-to-xlsx)
    + [https://api.pdf.co/v1/pdf/convert/to/xml](#https---apipdfco-v1-pdf-convert-to-xml)
  * [Convert PDF to HTML](#convert-pdf-to-html)
    + [https://api.pdf.co/v1/pdf/convert/to/html](#https---apipdfco-v1-pdf-convert-to-html)
- [Extract Data From Spreadsheets](#extract-data-from-spreadsheets)
  * [Convert XLS/XLSX to JSON](#convert-xls-xlsx-to-json)
    + [https://api.pdf.co/v1/xls/convert/to/json](#https---apipdfco-v1-xls-convert-to-json)
  * [Convert XLS/XLSX to CSV](#convert-xls-xlsx-to-csv)
    + [https://api.pdf.co/v1/xls/convert/to/csv](#https---apipdfco-v1-xls-convert-to-csv)
  * [Convert XLS/XLSX to HTML](#convert-xls-xlsx-to-html)
    + [https://api.pdf.co/v1/xls/convert/to/html](#https---apipdfco-v1-xls-convert-to-html)
- [Create PDF](#create-pdf)
  * [PDF from CSV](#pdf-from-csv)
    + [https://api.pdf.co/v1/pdf/convert/from/csv](#https---apipdfco-v1-pdf-convert-from-csv)
  * [PDF from Doc, DocX, RTF, TXT, XPS](#pdf-from-doc--docx--rtf--txt--xps)
    + [https://api.pdf.co/v1/pdf/convert/from/doc](#https---apipdfco-v1-pdf-convert-from-doc)
  * [PDF from HTML](#pdf-from-html)
    + [https://api.pdf.co/v1/pdf/convert/from/html](#https---apipdfco-v1-pdf-convert-from-html)
  * [PDF from Website URL](#pdf-from-website-url)
    + [https://api.pdf.co/v1/pdf/convert/from/url](#https---apipdfco-v1-pdf-convert-from-url)
  * [PDF from Image](#pdf-from-image)
    + [https://api.pdf.co/v1/pdf/convert/from/image](#https---apipdfco-v1-pdf-convert-from-image)
  * [PDF from XLS or XLSX](#pdf-from-xls-or-xlsx)
    + [https://api.pdf.co/v1/xls/convert/to/pdf](#https---apipdfco-v1-xls-convert-to-pdf)
- [PDF Tools](#pdf-tools)
  * [Merge and Split PDF](#merge-and-split-pdf)
    + [https://api.pdf.co/v1/pdf/merge](#https---apipdfco-v1-pdf-merge)
    + [https://api.pdf.co/v1/pdf/split](#https---apipdfco-v1-pdf-split)
  * [Edit and Modify PDF](#edit-and-modify-pdf)
    + [https://api.pdf.co/v1/pdf/makesearchable](#https---apipdfco-v1-pdf-makesearchable)
  * [Optimize PDF File Size](#optimize-pdf-file-size)
    + [https://api.pdf.co/v1/pdf/optimize](#https---apipdfco-v1-pdf-optimize)
  * [Add Text and Images to PDF](#add-text-and-images-to-pdf)
    + [https://api.pdf.co/v1/pdf/edit/add](#https---apipdfco-v1-pdf-edit-add)
  * [Render PDF to JPG](#render-pdf-to-jpg)
    + [https://api.pdf.co/v1/pdf/convert/to/jpg](#https---apipdfco-v1-pdf-convert-to-jpg)
  * [Render PDF to PNG](#render-pdf-to-png)
    + [https://api.pdf.co/v1/pdf/convert/to/png](#https---apipdfco-v1-pdf-convert-to-png)
  * [Render PDF to TIFF](#render-pdf-to-tiff)
    + [https://api.pdf.co/v1/pdf/convert/to/tiff](#https---apipdfco-v1-pdf-convert-to-tiff)
- [Barcodes](#barcodes)
  * [Generate Barcodes](#generate-barcodes)
      - [https://api.pdf.co/v1/barcode/generate](#https---apipdfco-v1-barcode-generate)
  * [Read Barcodes From URL or file](#read-barcodes-from-url-or-file)
      - [https://api.pdf.co/v1/barcode/read/from/url](#https---apipdfco-v1-barcode-read-from-url)
- [Web Tools](#web-tools)
  * [URL to JPG](#url-to-jpg)
    + [https://api.pdf.co/v1/url/convert/to/jpg](#https---apipdfco-v1-url-convert-to-jpg)
  * [URL to PNG](#url-to-png)
    + [https://api.pdf.co/v1/url/convert/to/png](#https---apipdfco-v1-url-convert-to-png)
- [Manage Files and Jobs](#manage-files-and-jobs)
  * [Upload Files](#upload-files)
    + [https://api.pdf.co/v1/file/upload/get-presigned-url](#https---apipdfco-v1-file-upload-get-presigned-url)
    + [https://api.pdf.co/v1/file/upload/url](#https---apipdfco-v1-file-upload-url)
    + [https://api.pdf.co/v1/file/upload/url](#https---apipdfco-v1-file-upload-url-1)
    + [https://api.pdf.co/v1/file/upload/base64](#https---apipdfco-v1-file-upload-base64)
    + [https://api.pdf.co/v1/file/hash](#https---apipdfco-v1-file-hash)
  * [Manage Background Jobs](#manage-background-jobs)
    + [https://api.pdf.co/v1/job/check](#https---apipdfco-v1-job-check)



# E-Signatures and Forms

## Manage Fillable Templates 

### https://api.pdf.co/v1/templates

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Returns list of existing document templates list for the current user. You should use PDF.co web-interface for end-users to create, edit templates, assign fields and manage list of parties for the document. Please use `GET` request.



**Status Errors**

| Code	| Description|
|-- |--
|`401`|	unauthorized|

**Examples**

```
GET /api/v1/templates
200
[
  {
    "id": "c57f79aa",
    "title": "IT Services Agreement - for our group",
    "description": "IT Services Agreement - template for our group",
    "mode": "unlisted",
    "created_at": "2017-12-02T15:35:59.565Z",
    "updated_at": "2017-12-02T15:36:52.643Z",
    "url": "http://pdf.co/t/information-tec-c57f79aa",
    "url_public": "http://pdf.co/t/information-tec-c57f79aa?secret_token=e12d74d076694e6b97c1"
  },
  {
    "id": "cd70e9e0",
    "title": "Information Technology Professional Services Agreement",
    "description": "Information Technology Professional Services Agreement template",
    "mode": "private",
    "created_at": "2017-12-02T15:29:09.362Z",
    "updated_at": "2017-12-02T15:34:34.934Z",
    "url": "http://pdf.co/t/information-tec-cd70e9e0",
    "url_public": null
  },
  {
    "id": "17a998ec",
    "title": "Non-Disclosure Agreement Template",
    "description": "Non-Disclosure Agreement template",
    "mode": "unlisted_notify",
    "created_at": "2017-11-24T13:05:58.697Z",
    "updated_at": "2017-12-02T15:33:28.720Z",
    "url": "http://pdf.co/t/contract-nda-17a998ec",
    "url_public": "http://pdf.co/t/contract-nda-17a998ec?secret_token=6c93ce3c39dfefecc82e"
  }
]
```    

### https://api.pdf.co/v1/templates/:id

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Document template information. `GET` request.



**Input Parameters**

|Param|	Description|
|-- |--
|`id`| required.	Document template id. Must be a String. |

**Status Errors**

| Code	| Description|
|-- |--
|`401`|	unauthorized|
|`404`|	record not found|

**Examples**

```
GET /api/v1/templates/cd70e9e0
200
{
  "id": "cd70e9e0",
  "title": "Information Technology Professional Services Agreement",
  "mode": "private",
  "fields": [
    {
      "role": "Client",
      "height": 63.33262935586062,
      "width": 130.5427666314678,
      "x": 46.853220696937704,
      "y": 725.4171066525871,
      "page": 1,
      "type": "signature",
      "name": "s1_s1",
      "transparent": true,
      "party_name": null,
      "party_email": null
    },
    {
      "role": "Contractor",
      "height": 63.33262935586062,
      "width": 130.5427666314678,
      "x": 416.5089757127772,
      "y": 717.9852164730729,
      "page": 1,
      "type": "signature",
      "name": "s2_s1",
      "transparent": true,
      "party_name": null,
      "party_email": null
    },
    {
      "role": "Client",
      "height": 21.972544878563887,
      "width": 344.4519535374868,
      "x": 75.28827877507919,
      "y": 179.3347412882788,
      "page": 0,
      "type": "text",
      "name": "s1_t1",
      "transparent": true,
      "party_name": null,
      "party_email": null
    },
    {
      "role": "Contractor",
      "height": 10.986272439281944,
      "width": 355.4382259767687,
      "x": 77.22703273495249,
      "y": 202.92291446673707,
      "page": 0,
      "type": "text",
      "name": "s2_t1",
      "transparent": true,
      "party_name": null,
      "party_email": null
    },
    {
      "role": "Client",
      "height": 10.986272439281944,
      "width": 102.75395987328406,
      "x": 342.8363252375924,
      "y": 402.2914466737065,
      "page": 0,
      "type": "date",
      "name": "s1_d1",
      "transparent": true,
      "party_name": null,
      "party_email": null
    },
    {
      "role": "Client",
      "height": 10.986272439281944,
      "width": 113.74023231256601,
      "x": 68.17951425554382,
      "y": 414.24709609292506,
      "page": 0,
      "type": "date",
      "name": "s1_d2",
      "transparent": true,
      "party_name": null,
      "party_email": null
    }
  ],
  "slug": "information-tec-cd70e9e0",
  "created_at": "2017-12-02T15:29:09.362Z",
  "updated_at": "2017-12-02T15:34:34.934Z",
  "url": "http://pdf.co/t/information-tec-cd70e9e0",
  "roles": [
    "Client",
    "Contractor"
  ],
  "url_public": null,
  "sign_by_owner": false,
  "sign_by_owner_as": ""
}
```

## Send E-Signature Request

### https://api.pdf.co/v1/templates/:id/use

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** This method creates new document from existing template and sends new e-signature request to fill and e-sign (if need to) new document to parties via email. Please use `GET` request.



**Input Parameters**

|Param|	Description|
|-- |--
|`id`| required.	Document template id. Must be a String.|
|`title`| optional.	Document template id. Must be a String.|
|`roles`| required.	Roles data. Must be an Array of nested elements.|
|`roles[role]`| required.	Role name. Must be a String.|
|`roles[name]`| required.	Signer name. Must be a String.|
|`roles[email]`| required.	Signer email. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`401`|	unauthorized|
|`404`|	record not found|

**Examples**

```
POST /api/v1/templates/726b835a/use
{
  "roles": [
    {
      "role": "Client",
      "name": "Super Company, Inc.",
      "email": "contracts@example.com"
    },
    {
      "role": "Contractor",
      "name": "Alyssa French",
      "email": "alyssa@example.com"
    }
  ],
  "fields": [
    {
      "s1_t1": "Brett Wheeler (CEO)"
    }
  ]
}
200
{
  "document": {
    "id": "bd2a126ae563e95827045a5faf040595cb09791db49400b125",
    "title": "Information_Technology_Professional_Services_Agreement.pdf",
    "created_at": "2017-12-02T15:44:26.463Z",
    "updated_at": "2017-12-02T15:44:26.537Z",
    "executed_document_url": null,
    "executed_document_hash": null,
    "fields": [
      {
        "role": "Client",
        "height": 63.33262935586062,
        "width": 130.5427666314678,
        "x": 46.853220696937704,
        "y": 725.4171066525871,
        "page": 1,
        "type": "signature",
        "name": "s1_s1",
        "transparent": true,
        "user_id": null
      },
      {
        "role": "Contractor",
        "height": 63.33262935586062,
        "width": 130.5427666314678,
        "x": 416.5089757127772,
        "y": 717.9852164730729,
        "page": 1,
        "type": "signature",
        "name": "s2_s1",
        "transparent": true,
        "user_id": null
      },
      {
        "role": "Client",
        "height": 21.972544878563887,
        "width": 344.4519535374868,
        "x": 75.28827877507919,
        "y": 179.3347412882788,
        "page": 0,
        "type": "text",
        "name": "s1_t1",
        "transparent": true,
        "prefilled": "Brett Wheeler (CEO)",
        "user_id": null
      },
      {
        "role": "Contractor",
        "height": 10.986272439281944,
        "width": 355.4382259767687,
        "x": 77.22703273495249,
        "y": 202.92291446673707,
        "page": 0,
        "type": "text",
        "name": "s2_t1",
        "transparent": true,
        "user_id": null
      },
      {
        "role": "Client",
        "height": 10.986272439281944,
        "width": 102.75395987328406,
        "x": 342.8363252375924,
        "y": 402.2914466737065,
        "page": 0,
        "type": "date",
        "name": "s1_d1",
        "transparent": true,
        "user_id": null
      },
      {
        "role": "Client",
        "height": 10.986272439281944,
        "width": 113.74023231256601,
        "x": 68.17951425554382,
        "y": 414.24709609292506,
        "page": 0,
        "type": "date",
        "name": "s1_d2",
        "transparent": true,
        "user_id": null
      }
    ],
    "include_certificate": true,
    "created_from": "api",
    "executed_at": null,
    "created_from_id": null,
    "sender": {
      "id": "6b4de21ebd4db5cd",
      "name": "Brett Wheeler",
      "email": "contracts@example.com"
    },
    "recipients": [
      {
        "name": "Super Company, Inc.",
        "email": "contracts@example.com",
        "invitation_url": "http://pdf.co/invite/2b12ad972c5238d6f9705d80f03131e38aa4572adcc4473cca",
        "status": "pending",
        "id": null
      },
      {
        "name": "Alyssa French",
        "email": "alyssa@example.com",
        "invitation_url": "http://pdf.co/invite/71b90355552d29bc332f0bf2e24c90c32f54a6c1f9605dcfe2",
        "status": "pending",
        "id": null
      }
    ],
    "status": "pending"
  }
}
```

## Manage Documents 

### https://api.pdf.co/v1/documents

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** ‰eturns list of all current user's documents data. You may check *status* of each document and get additional information. Please use `GET` request.


**Status Errors**

| Code	| Description|
|-- |--
|`401`|	unauthorized|

**Examples**

```
GET /api/v1/documents
200
{
  "documents": [
    {
      "id": "bd2a126ae563e95827045a5faf040595cb09791db49400b125",
      "title": "Information_Technology_Professional_Services_Agreement.pdf",
      "created_at": "2017-12-02T15:44:26.463Z",
      "updated_at": "2017-12-03T15:52:39.892Z",
      "sender": {
        "id": "6b4de21ebd4db5cd",
        "name": "Brett Wheeler",
        "email": "brett@gmail.com"
      },
      "recipients": [
        {
          "name": "Alyssa French",
          "email": "alyssa@example.com",
          "invitation_url": "http://pdf.co/invite/71b90355552d29bc332f0bf2e24c90c32f54a6c1f9605dcfe2",
          "status": "completed",
          "id": "cb2dc3edd0a34a36"
        },
        {
          "name": "Super Company, Inc.",
          "email": "contracts@example.com",
          "invitation_url": "http://pdf.co/invite/2b12ad972c5238d6f9705d80f03131e38aa4572adcc4473cca",
          "status": "completed",
          "id": "2b45ecfa01363c9e"
        }
      ],
      "status": "completed"
    },
    {
      "id": "18371109fed2731366937e243792192846d4ea9485738303a9",
      "title": "contract-nda.pdf",
      "created_at": "2017-11-23T14:22:48.474Z",
      "updated_at": "2017-11-23T14:40:16.225Z",
      "sender": {
        "id": "6b4de21ebd4db5cd",
        "name": "Brett Wheeler",
        "email": "brett@example.com"
      },
      "recipients": [
        {
          "name": "Disclosing Party",
          "email": "client@example.com",
          "invitation_url": "http://pdf.co/invite/097a04d11d56f03f16b52254314a62fe08acefe752ee2280dc",
          "status": "completed",
          "id": "6b4de21ebd4db5cd"
        },
        {
          "name": "Receiving Party",
          "email": "freelancer@example.com",
          "invitation_url": "http://pdf.co/invite/64316ba3fb93e0c34225d7ff9a0bfd7b338d94155750fdd269",
          "status": "completed",
          "id": "c7b634b1ffac3308"
        }
      ],
      "status": "completed"
    },
    {
      "id": "ee0a44ff610c24cbb546d5904d642132979eff94e36591d34f",
      "title": "founders_agreement.docx",
      "created_at": "2017-10-13T18:06:48.789Z",
      "updated_at": "2017-10-13T21:51:15.878Z",
      "sender": {
        "id": "6b4de21ebd4db5cd",
        "name": "Disclosing Party",
        "email": "client@example.com"
      },
      "recipients": [
        {
          "name": "Kevin",
          "email": "kevin@example.com",
          "invitation_url": "http://pdf.co/invite/8a57f8870824948b77b2dc990af44c3bb10c5a14ab3a7ef614",
          "status": "completed",
          "id": "cf374b2c7e5c41ce"
        },
        {
          "name": "Wendy",
          "email": "wendy@example.com",
          "invitation_url": "http://pdf.co/invite/f69c50b7689fa9491283e36d1a994a096e8efbd1d32cc23a39",
          "status": "completed",
          "id": "5034ac41ce4532ab"
        },
        {
          "name": "Salvador",
          "email": "salvador@example.com",
          "invitation_url": "http://pdf.co/invite/34ad51c59e2acbbcf339159885860e88fb750f67b1a39f9787",
          "status": "completed",
          "id": "1dc654d2a7ab55c3"
        }
      ],
      "status": "completed"
    }
  ]
}
```

### https://api.pdf.co/v1/documents/:id

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Returns detailed information about document by document's id: meta information, information about parties, document status, audit log. Please use `GET` request.


**Input Parameters**

|Param|	Description|
|-- |--
|`id`| required.	Document id. Must be a String. |

**Status Errors**

| Code	| Description|
|-- |--
|`401`|	unauthorized|
|`404`|	record not found|

**Examples**

```
GET /api/v1/documents/b9d00ce740789717b3fa588684234d0e4ce8c667ad813945d9
200
{
  "document": {
    "id": "bd2a126ae563e95827045a5faf040595cb09791db49400b125",
    "title": "Information_Technology_Professional_Services_Agreement.pdf",
    "created_at": "2017-12-02T15:44:26.463Z",
    "updated_at": "2017-12-03T15:52:39.892Z",
    "executed_document_url": "https://pdf-user-files.s3-us-west-2.amazonaws.com/7b5dfd74b1f8e79073d95d17321f980583ab56803b24e1f6d2/206e227e0f8e45dcaa9aa5de7115197d/Information_Technology_Professional_Services_Agreement-signed-by-Alyssa%20Frenc...pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJIIQVJKEFIER2WHA%2F20171203%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20171203T155704Z&X-Amz-Expires=1200&X-Amz-SignedHeaders=host&X-Amz-Signature=113c6d7f71b9355bf13146e6da57895cd031e544d27a4bd5453f668b818f3779",
    "executed_document_hash": "cbc6e14e2b955ace22f2ef34ae3e96bd8147812aea376ae7c0219ae8859c3ea5",
    "fields": [
      {
        "role": "Client",
        "height": 63.33262935586062,
        "width": 130.5427666314678,
        "x": 46.853220696937704,
        "y": 725.4171066525871,
        "page": 1,
        "type": "signature",
        "name": "s1_s1",
        "transparent": true,
        "user_id": "2b45ecfa01363c9e"
      },
      {
        "role": "Contractor",
        "height": 63.33262935586062,
        "width": 130.5427666314678,
        "x": 416.5089757127772,
        "y": 717.9852164730729,
        "page": 1,
        "type": "signature",
        "name": "s2_s1",
        "transparent": true,
        "user_id": "cb2dc3edd0a34a36"
      },
      {
        "role": "Client",
        "height": 21.972544878563887,
        "width": 344.4519535374868,
        "x": 75.28827877507919,
        "y": 179.3347412882788,
        "page": 0,
        "type": "text",
        "name": "s1_t1",
        "transparent": true,
        "prefilled": "Brett Wheeler (CEO)",
        "user_id": "2b45ecfa01363c9e"
      },
      {
        "role": "Contractor",
        "height": 10.986272439281944,
        "width": 355.4382259767687,
        "x": 77.22703273495249,
        "y": 202.92291446673707,
        "page": 0,
        "type": "text",
        "name": "s2_t1",
        "transparent": true,
        "user_id": "cb2dc3edd0a34a36"
      },
      {
        "role": "Client",
        "height": 10.986272439281944,
        "width": 102.75395987328406,
        "x": 342.8363252375924,
        "y": 402.2914466737065,
        "page": 0,
        "type": "date",
        "name": "s1_d1",
        "transparent": true,
        "user_id": "2b45ecfa01363c9e"
      },
      {
        "role": "Client",
        "height": 10.986272439281944,
        "width": 113.74023231256601,
        "x": 68.17951425554382,
        "y": 414.24709609292506,
        "page": 0,
        "type": "date",
        "name": "s1_d2",
        "transparent": true,
        "user_id": "2b45ecfa01363c9e"
      }
    ],
    "include_certificate": true,
    "created_from": "api",
    "executed_at": "2017-12-03T15:52:39.871Z",
    "created_from_id": null,
    "sender": {
      "id": "6b4de21ebd4db5cd",
      "name": "Brett Wheeler (CEO)",
      "email": "brett@example.com"
    },
    "recipients": [
      {
        "name": "Alyssa French",
        "email": "alyssa@example.com",
        "invitation_url": "http://pdf.co/invite/71b90355552d29bc332f0bf2e24c90c32f54a6c1f9605dcfe2",
        "status": "completed",
        "id": "cb2dc3edd0a34a36"
      },
      {
        "name": "Super Company, Inc.",
        "email": "contracts@example.com",
        "invitation_url": "http://pdf.co/invite/2b12ad972c5238d6f9705d80f03131e38aa4572adcc4473cca",
        "status": "completed",
        "id": "2b45ecfa01363c9e"
      }
    ],
    "status": "completed",
    "audits": [
      {
        "user_id_from": "6b4de21ebd4db5cd",
        "user_id_to": null,
        "user_ip": null,
        "device_type": null,
        "browser": null,
        "browser_version": null,
        "os": null,
        "event_type": "document_created",
        "timestamp": "2017-12-02T15:44:26.000+00:00",
        "message": "Created the document"
      },
      {
        "user_id_from": "6b4de21ebd4db5cd",
        "user_id_to": null,
        "user_ip": null,
        "device_type": null,
        "browser": null,
        "browser_version": null,
        "os": null,
        "event_type": "invitation_created",
        "timestamp": "2017-12-02T15:44:26.000+00:00",
        "message": "Created the invitation for Alyssa French <alyssa@example.com>"
      },
      {
        "user_id_from": "6b4de21ebd4db5cd",
        "user_id_to": null,
        "user_ip": null,
        "device_type": null,
        "browser": null,
        "browser_version": null,
        "os": null,
        "event_type": "invitation_created",
        "timestamp": "2017-12-02T15:44:26.000+00:00",
        "message": "Created the invitation for Super Company, Inc. <contracts@example.com>"
      },
      {
        "user_id_from": "6b4de21ebd4db5cd",
        "user_id_to": null,
        "user_ip": null,
        "device_type": null,
        "browser": null,
        "browser_version": null,
        "os": null,
        "event_type": "invitation_sent",
        "timestamp": "2017-12-02T15:44:26.000+00:00",
        "message": "Invitation was sent to Super Company, Inc. <contracts@example.com>"
      },
      {
        "user_id_from": "6b4de21ebd4db5cd",
        "user_id_to": null,
        "user_ip": null,
        "device_type": null,
        "browser": null,
        "browser_version": null,
        "os": null,
        "event_type": "invitation_sent",
        "timestamp": "2017-12-02T15:44:27.000+00:00",
        "message": "Invitation was sent to Alyssa French <alyssa@example.com>"
      },
      {
        "user_id_from": "cb2dc3edd0a34a36",
        "user_id_to": null,
        "user_ip": "22.11.33.44",
        "device_type": "desktop",
        "browser": "Chrome",
        "browser_version": "62.0.3202.94",
        "os": "Mac",
        "event_type": "viewed",
        "timestamp": "2017-12-03T10:52:40.000+00:00",
        "message": "Document was viewed by Alyssa French <alyssa@example.com> from IP address 22.11.33.44 in Chrome 62.0.3202.94 browser for Mac 10.12.0 running on desktop"
      },
      {
        "user_id_from": "cb2dc3edd0a34a36",
        "user_id_to": null,
        "user_ip": "22.11.33.44",
        "device_type": "desktop",
        "browser": "Chrome",
        "browser_version": "62.0.3202.94",
        "os": "Mac",
        "event_type": "viewed",
        "timestamp": "2017-12-03T10:53:46.000+00:00",
        "message": "Document was viewed by Alyssa French <alyssa@example.com> from IP address 22.11.33.44 in Chrome 62.0.3202.94 browser for Mac 10.12.0 running on desktop"
      },
      {
        "user_id_from": "cb2dc3edd0a34a36",
        "user_id_to": null,
        "user_ip": "22.11.33.44",
        "device_type": "desktop",
        "browser": "Chrome",
        "browser_version": "62.0.3202.94",
        "os": "Mac",
        "event_type": "signed",
        "timestamp": "2017-12-03T10:56:39.000+00:00",
        "message": "Document was signed by Alyssa French <alyssa@example.com> from IP address 22.11.33.44 in Chrome 62.0.3202.94 browser for Mac 10.12.0 running on desktop"
      },
      {
        "user_id_from": "2b45ecfa01363c9e",
        "user_id_to": null,
        "user_ip": "44.44.22.11",
        "device_type": "smartphone",
        "browser": "Mobile Safari",
        "browser_version": "11.0",
        "os": "iOS",
        "event_type": "viewed",
        "timestamp": "2017-12-03T11:05:23.000+00:00",
        "message": "Document was viewed by Super Company, Inc. <contracts@example.com> from IP address 44.44.22.11 in Mobile Safari 11.0 browser for iOS 11.2 running on smartphone"
      },
      {
        "user_id_from": "2b45ecfa01363c9e",
        "user_id_to": null,
        "user_ip": "44.44.22.11",
        "device_type": "smartphone",
        "browser": "Mobile Safari",
        "browser_version": "11.0",
        "os": "iOS",
        "event_type": "viewed",
        "timestamp": "2017-12-03T15:51:46.000+00:00",
        "message": "Document was viewed by Super Company, Inc. <contracts@example.com> from IP address 44.44.22.11 in Mobile Safari 11.0 browser for iOS 11.2 running on smartphone"
      },
      {
        "user_id_from": "2b45ecfa01363c9e",
        "user_id_to": null,
        "user_ip": "44.44.22.11",
        "device_type": "smartphone",
        "browser": "Mobile Safari",
        "browser_version": "11.0",
        "os": "iOS",
        "event_type": "signed",
        "timestamp": "2017-12-03T15:52:26.000+00:00",
        "message": "Document was signed by Super Company, Inc. <contracts@example.com> from IP address 44.44.22.11 in Mobile Safari 11.0 browser for iOS 11.2 running on smartphone"
      },
      {
        "user_id_from": null,
        "user_id_to": null,
        "user_ip": null,
        "device_type": null,
        "browser": null,
        "browser_version": null,
        "os": null,
        "event_type": "document_completed",
        "timestamp": "2017-12-03T15:52:39.000+00:00",
        "message": "Finalized the document"
      }
    ]
  }
}
```


## Add E-Signature and Text To PDF

### https://api.pdf.co/v1/pdf/sign

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** This method e-signs PDF document by adding scanned or drawn signature from image file or image data, adds text for fields to fill and add. 
Also can generate e-signature certificate to be appended at the end of document. 

Please use `GET` request.

**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`images`| optional. Image signatures to add. Must be an Array of nested elements.|
|`images[width]`| optional.  Must be a Integer.|
|`images[height]`| optional.  Must be a Integer.|
|`images[y]`| optional.  Must be a Integer.|
|`images[x]`| optional.  Must be a Integer.|
|`images[pages]`| optional.  Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|
|`annotations`| optional. Annotation (textual) signatures to add. Must be an Array of nested elements.|
|`annotations[text]`| optional. Annotation text. Must be a String.|
|`annotations[size]`| optional. Font size. Must be a String.|
|`annotations[color]`| optional. Font color. Must be a String.|
|`annotations[fontName]`| optional. Font name. Must be a String.|
|`annotations[transparent]`| optional. Set background to transparent or not. Must be one of: `true`, `false`.|
|`annotations[width]`| optional. Width of the signature in PDF Points (1/72 in.). Must be a Integer.|
|`annotations[height]`| optional. Height of the signature in PDF Points (1/72 in.). Must be a Integer.|
|`annotations[y]`| optional. Y coordinate of the signature in PDF Points (1/72 in.). Must be a Integer.|
|`annotations[x]`| optional. X coordinate of the signature in PDF Points (1/72 in.). Must be a Integer.|
|`annotations[pages]`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|
|`certificate`| optional. Must be a Hash.|
|`certificate[title]`| optional. Must be a String.|
|`certificate[documentReference]`| optional. Must be a String.|
|`certificate[parties]`| optional. Must be an Array of nested elements.|
|`certificate[parties][partyId]`| optional. Must be a String.|
|`certificate[parties][name]`| optional. Must be a String.|
|`certificate[parties][emails]`| optional. Must be a String.|
|`certificate[parties][ipAddress]`| optional. Must be a String.|
|`certificate[parties][timestamp]`| optional. Must be a Integer.|
|`certificate[parties][role]`| optional. Must be a String.|
|`certificate[parties]`| optional. Must be an Array of nested elements.|
|`certificate[parties][timestamp]`| optional. Must be a Integer.|
|`certificate[parties][message]`| optional. Must be a String.|

**Input Model**

```
{
  "name": "string",
  "url": "string",
  "async": true,
  "encrypt": true,
  "images": [
    {
      "url": "string",
      "x": 0,
      "y": 0,
      "width": 0,
      "height": 0,
      "pages": "string"
    }
  ],
  "annotations": [
    {
      "text": "string",
      "x": 0,
      "y": 0,
      "width": 0,
      "height": 0,
      "size": 0,
      "color": "string",
      "fontName": "string",
      "transparent": true,
      "pages": "string"
    }
  ],
  "certificate": {
    "title": "string",
    "documentReference": "string",
    "parties": [
      {
        "partyId": "string",
        "name": "string",
        "email": "string",
        "ipAddress": "string",
        "timestamp": 0,
        "role": "string"
      }
    ],
    "audit": [
      {
        "timestamp": 0,
        "message": "string"
      }
    ]
  }
}
```

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
    "async": false,
    "name": "newDocument",
    "url": "https://www.ets.org/Media/Tests/GRE/pdf/gre_research_validity_data.pdf"
}
```
**Response**

```
200
{
    "hash": "e981402c53887825cbf2f2ffe659724440fe360297662039a077115b747d976c",
    "url": "https://pdf-temp-files.s3.amazonaws.com/f0626b8547f542238b52d0e30d3f54fb/newDocument.pdf",
    "pageCount": 0,
    "error": false,
    "status": 200,
    "name": "newDocument"
}
```





# Extract Data

## Template Based Extraction

### https://api.pdf.co/v1/pdf/documentparser

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Parses and gets data from documents using previously prepared custom data extraction template. With this API method you may extract data from custom areas, by search, form fields, tables, multiple pages and more!
Please use `GET` or `POST` request.  

To create and prepare new document parsing template, please download and use [Document Parser Template Editor (for Windows)](https://cdn.bytescout.com/TemplateEditor.zip)

**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional.Enable encryption for output file. Must be one of: `true`, `false`.|
|`inline`| optional. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`profiles`| optional. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|
|`unwrap`| optional. Unwrap lines into a single line within table cells when `lineGrouping` is enabled. Must be a String.|
|`pages`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|
|`template`| optional. Must be a String.|
|`lineGrouping`| optional. Line grouping within table cells. Add Use `lineGrouping=1` to enable the grouping. Must be a String.|


**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
 TBD
}
```
**Response**

```
200
{
    TBD
}
```

## Invoice Parser

### https://api.pdf.co/v1/pdf/invoiceparser

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** This method automatically extracts data from incvoices. Thousands of invoice types and vendors are supported.

Supports invoices in PDF, PNG, JPG format. Extracts and returns the following information for every invoice:

- `company name`
- `invoice date`
- `invoice due date`
- `invoice number`
- `invoice total`

For custom data extraction based on templates, please use Document Parser endpoint instead that is capable of extracting data based on custom extraction templates.

Please use `GET` or `POST` request.  

**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional.Enable encryption for output file. Must be one of: `true`, `false`.|
|`inline`| optional. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|


**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"async": false,
	"inline" : "true",
        "name": "newDocument",
        "password" : "",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf"
}
```

**Response**

```
200
{
    "body": {
        "sourceId": "Generic Invoice [en]",
        "fields": {
            "companyName": {
                "value": "Good Vendor",
                "pageIndex": 0
            },
            "dateIssued": {
                "value": "back",
                "pageIndex": 0
            }            
        }
    },
    "pageCount": 4,
    "error": false,
    "status": 200,
    "name": "newDocument",
    "remainingCredits": 9882
}
```



## Read PDF Information

### https://api.pdf.co/v1/pdf/info

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Gets PDF document information. `GET` or `POST` request.  

**Input Parameters**

|Param|	Description|
|-- |--
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-info/sample.pdf"
}
```

**Response**

```
200
{
    "info": {
        "PageCount": 1,
        "Author": "Alice V. Knox",
        "Title": "Kid's News 1",
        "Producer": "Acrobat Distiller 4.0 for Windows",
        "Subject": "Kid's News 1",
        "CreationDate": "8/15/2001 2:50:36 PM",
        "Bookmarks": null,
        "Keywords": "",
        "Creator": "Adobe PageMaker 6.52",
        "EmbeddedFileCount": 0,
        "Encrypted": false
    },
    "error": false,
    "status": 200,
    "name": null
}
```

## Search inside PDF and Images

### https://api.pdf.co/v1/pdf/find

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Finds text in pdf and returns coordinates. `GET` or `POST` request.  

**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`searchString`| required. Source PDF file.|
|`name`| optional. File name for generated output. Must be a String.|
|`pages`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|
|`inline`| optional. Must be one of: `true`, `false`.|
|`wordMatchingMode`| optional. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|
|`regexSearch`| optional. Must be one of: `true`, `false`.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"password" : "",
	"pages" : "",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample.pdf",
	"searchString" : "Invoice Date \d+/\d+/\d+",
	"regexSearch" : "true"
}
```

**Response**

```
200
{
  "body": [
      {
          "text": "Invoice Date 01/01/2016",
          "left": 436.5400085449219,
          "top": 130.4599995137751,
          "width": 122.85311957550027,
          "height": 11.040000486224898,
          "pageIndex": 0,
          "bounds": {
              "location": {
                  "isEmpty": false,
                  "x": 436.54,
                  "y": 130.46
              },
              "size": "122.853119, 11.0400009",
              "x": 436.54,
              "y": 130.46,
              "width": 122.853119,
              "height": 11.0400009,
              "left": 436.54,
              "top": 130.46,
              "right": 559.3931,
              "bottom": 141.5,
              "isEmpty": false
          },
          "elementCount": 1,
          "elements": [
              {
                  "index": 0,
                  "left": 436.5400085449219,
                  "top": 130.4599995137751,
                  "width": 122.85311957550027,
                  "height": 11.040000486224898,
                  "angle": 0,
                  "text": "Invoice Date 01/01/2016",
                  "isNewLine": true,
                  "fontIsBold": true,
                  "fontIsItalic": false,
                  "fontName": "Arial",
                  "fontSize": 11,
                  "fontColor": "0, 0, 0",
                  "fontColorAsOleColor": 0,
                  "fontColorAsHtmlColor": "#000000",
                  "bounds": {
                      "location": {
                          "isEmpty": false,
                          "x": 436.54,
                          "y": 130.46
                      },
                      "size": "122.853119, 11.0400009",
                      "x": 436.54,
                      "y": 130.46,
                      "width": 122.853119,
                      "height": 11.0400009,
                      "left": 436.54,
                      "top": 130.46,
                      "right": 559.3931,
                      "bottom": 141.5,
                      "isEmpty": false
                  }
              }
          ]
      }
  ],
  "pageCount": 1,
  "error": false,
  "status": 200,
  "name": "sample.json",
  "remainingCredits": 998
}
```

## Extract as CSV, XML, JSON, HTML

### https://api.pdf.co/v1/pdf/convert/to/csv

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Extracts data from PDF, PNG, JPG in a form of formatted CSV. Automatically preserves the original layout of tables, rows, columns. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`inline`| optional. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`profiles`| optional. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|
|`rect`| optional. Must be a String.|
|`unwrap`| optional. Unwrap lines into a single line within table cells when `lineGrouping` is enabled. Must be a String.|
|`pages`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|
|`lineGrouping`| optional. Line grouping within table cells. Add Use `lineGrouping=1` to enable the grouping. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"name" : "result.csv",
	"pages" : "",
	"password" : "",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-csv/sample.pdf"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/48ebcc5cf0e043e790a5ae6a2500057d/result.csv",
    "pageCount": 1,
    "error": false,
    "status": 200,
    "name": "result.csv"
}
```
result.csv
```
"Your Company Name","","","",
"Your Address","","","",
"City, State Zip","","","",
"","","","Invoice No. 123456",
"","","","Invoice Date 01/01/2016",
"Client Name","","","",
"Address","","","",
"City, State Zip","","","",
"Notes","","","",
"Item","Quantity","Price","Total",
"Item 1","1","40.00","40.00",
"Item 2","2","30.00","60.00",
"Item 3","3","20.00","60.00",
"Item 4","4","10.00","40.00",
"","","TOTAL","200.00",
```



### https://api.pdf.co/v1/pdf/convert/to/json

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Extracts data from PDF, JPG, PNG and scanned documents into structured JSON. Automatically preserves the original layout of tables, rows, columns. Includes information about coordinates, fonts, font size and styles. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`inline`| optional. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`profiles`| optional. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|
|`rect`| optional. Must be a String.|
|`unwrap`| optional. Unwrap lines into a single line within table cells when `lineGrouping` is enabled. Must be a String.|
|`pages`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|
|`lineGrouping`| optional. Line grouping within table cells. Add Use `lineGrouping=1` to enable the grouping. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"name" : "result.json",
	"pages" : "",
	"password" : "",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-json/sample.pdf"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/417bcb2c094d44deb12738e4eb79cec9/result.json",
    "pageCount": 1,
    "error": false,
    "status": 200,
    "name": "result.json"
}
```
result.json
```
{
  "document": {
    "page": {
      "@index": "0",
      "row": [
        {
          "column": [
            {
              "text": {
                "@fontName": "Arial",
                "@fontSize": "11.0",
                "@fontStyle": "Bold",
                "@x": "36.00",
                "@y": "316.25",
                "@width": "22.58",
                "@height": "11.04",
                "#text": "Item"
              }
            },
            {
              "text": {
                "@fontName": "Arial",
                "@fontSize": "11.0",
                "@fontStyle": "Bold",
                "@x": "247.61",
                "@y": "316.25",
                "@width": "44.64",
                "@height": "11.04",
                "#text": "Quantity"
              }
            },
            {
              "text": {
                "@fontName": "Arial",
                "@fontSize": "11.0",
                "@fontStyle": "Bold",
                "@x": "398.95",
                "@y": "316.25",
                "@width": "26.91",
                "@height": "11.04",
                "#text": "Price"
              }
            },
            {
              "text": {
                "@fontName": "Arial",
                "@fontSize": "11.0",
                "@fontStyle": "Bold",
                "@x": "533.14",
                "@y": "316.25",
                "@width": "26.30",
                "@height": "11.04",
                "#text": "Total"
              }
            }
          ]
        },
        {
          "column": [
            {
              "text": {
                "@fontName": "Arial",
                "@fontSize": "11.0",
                "@x": "36.00",
                "@y": "341.33",
                "@width": "30.62",
                "@height": "11.04",
                "#text": "Item 1"
              }
            },
            {
              "text": {
                "@fontName": "Arial",
                "@fontSize": "11.0",
                "@x": "286.13",
                "@y": "341.33",
                "@width": "6.12",
                "@height": "11.04",
                "#text": "1"
              }
            },
            {
              "text": {
                "@fontName": "Arial",
                "@fontSize": "11.0",
                "@x": "398.35",
                "@y": "341.33",
                "@width": "27.51",
                "@height": "11.04",
                "#text": "40.00"
              }
            },
            {
              "text": {
                "@fontName": "Arial",
                "@fontSize": "11.0",
                "@x": "531.94",
                "@y": "341.33",
                "@width": "27.50",
                "@height": "11.04",
                "#text": "40.00"
              }
            }
          ]
        },
      ]
    }
  }
}
```
### https://api.pdf.co/v1/pdf/convert/to/text

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Extracts plain text from PDF, PNG, JPG documents. Automatically preserves the original text layout. Restores damaged and scanned text. `GET` or `POST` request.  


**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`inline`| optional. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`profiles`| optional. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|
|`rect`| optional. Must be a String.|
|`unwrap`| optional. Unwrap lines into a single line within table cells when `lineGrouping` is enabled. Must be a String.|
|`pages`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|
|`lineGrouping`| optional. Line grouping within table cells. Add Use `lineGrouping=1` to enable the grouping. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"name" : "result.txt",
	"pages" : "",
	"password" : "",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-text/sample.pdf"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/d6fbd25870a94c8cb0f268e5619d6b21/result.txt",
    "pageCount": 1,
    "error": false,
    "status": 200,
    "name": "result.txt"
}
```
result.txt
```
Your Company Name 
    Your Address 
    City, State Zip 
                                                                                  Invoice No. 123456 
                                                                                Invoice Date 01/01/2016 
  Client Name 
    Address 
    City, State Zip 

    Notes 


    Item                                     Quantity                     Price                     Total 
    Item 1                                              1                      40.00                      40.00 
    Item 2                                              2                      30.00                      60.00 
    Item 3                                              3                      20.00                      60.00 
    Item 4                                              4                      10.00                      40.00 
                                                        TOTAL                200.00
```
### https://api.pdf.co/v1/pdf/convert/to/xls

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** PDF, PNG, JPG to XLS conversion. Automatically preserves the original layout of tables, rows, columns, font styles, font size, colors. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`profiles`| optional. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|
|`rect`| optional. Must be a String.|
|`unwrap`| optional. Unwrap lines into a single line within table cells when `lineGrouping` is enabled. Must be a String.|
|`pages`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|
|`lineGrouping`| optional. Line grouping within table cells. Add Use `lineGrouping=1` to enable the grouping. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"name" : "result.xls",
	"pages" : "",
	"password" : "",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-excel/sample.pdf"
}
```

**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/854fef60b4b84c9b9921f841836b183b/result.xls",
    "pageCount": 1,
    "error": false,
    "status": 200,
    "name": "result.xls"
}
```
result.xls
```
Your Company Name			
Your Address			
City, State Zip			
			Invoice No. 123456
			Invoice Date 01/01/2016
Client Name			
Address			
City, State Zip			
Notes			
Item	Quantity	Price	Total
Item 1	1	40	40
Item 2	2	30	60
Item 3	3	20	60
Item 4	4	10	40
		TOTAL	200

```
### https://api.pdf.co/v1/pdf/convert/to/xlsx

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** PDF, PNG, JPG to XLSX conversion. Automatically preserves the original layout of tables, rows, columns, font styles, font size, colors. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`profiles`| optional. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|
|`rect`| optional. Must be a String.|
|`unwrap`| optional. Unwrap lines into a single line within table cells when `lineGrouping` is enabled. Must be a String.|
|`pages`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|
|`lineGrouping`| optional. Line grouping within table cells. Add Use `lineGrouping=1` to enable the grouping. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"name" : "result.xlsx",
	"pages" : "",
	"password" : "",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-excel/sample.pdf"
}
```

**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/d063c51ae0e54b5485bc146293e82312/result.xlsx",
    "pageCount": 1,
    "error": false,
    "status": 200,
    "name": "result.xlsx"
}
```
result.xlsx
```
Your Company Name			
Your Address			
City, State Zip			
			Invoice No. 123456
			Invoice Date 01/01/2016
Client Name			
Address			
City, State Zip			
Notes			
Item	Quantity	Price	Total
Item 1	1	40	40
Item 2	2	30	60
Item 3	3	20	60
Item 4	4	10	40
		TOTAL	200

```
### https://api.pdf.co/v1/pdf/convert/to/xml

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** PDF, PNG, JPG to XML conversion. Automatically preserves the original layout of tables, rows, columns. Includes information about coordinates, fonts, font size and styles. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`inline`| optional. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`profiles`| optional. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|
|`rect`| optional. Must be a String.|
|`unwrap`| optional. Unwrap lines into a single line within table cells when `lineGrouping` is enabled. Must be a String.|
|`pages`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|
|`lineGrouping`| optional. Line grouping within table cells. Add Use `lineGrouping=1` to enable the grouping. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"name" : "result.xml",
	"pages" : "",
	"password" : "",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-xml/sample.pdf"
}
```

**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/9fbce0f9b8e249469c387d505e7a7325/result.xml",
    "pageCount": 1,
    "error": false,
    "status": 200,
    "name": "result.xml"
}
```
result.xml
```
<document>
<page index="0">
<row>
<column>
<text fontName="Arial" fontSize="24.0" fontStyle="Bold" color="#538DD3" x="36.00" y="34.44" width="242.81" height="24.00">Your Company Name</text>
</column>
</row>
<row>
<column>
<text fontName="Arial" fontSize="11.0" fontStyle="Bold" x="436.54" y="130.46" width="122.90" height="11.04">Invoice Date 01/01/2016</text>
</column>
</row>
<row>
<column>
<text fontName="Arial" fontSize="11.0" fontStyle="Bold" x="36.00" y="154.94" width="63.62" height="11.04">Client Name</text>
</column>
</row>
<row>
<column>
<text fontName="Arial" fontSize="11.0" x="36.00" y="169.70" width="40.34" height="11.04">Address</text>
</column>
</row>
<row>
<column>
<text fontName="Arial" fontSize="11.0" x="36.00" y="184.22" width="69.14" height="11.04">City, State Zip</text>
</column>
</row>
<row>
<column>
<text fontName="Arial" fontSize="11.0" x="36.00" y="233.30" width="28.70" height="11.04">Notes</text>
</column>
</row>
<row>
<column>
<text fontName="Arial" fontSize="11.0" fontStyle="Bold" x="36.00" y="316.25" width="22.58" height="11.04">Item</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" fontStyle="Bold" x="247.61" y="316.25" width="44.64" height="11.04">Quantity</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" fontStyle="Bold" x="398.95" y="316.25" width="26.91" height="11.04">Price</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" fontStyle="Bold" x="533.14" y="316.25" width="26.30" height="11.04">Total</text>
</column>
</row>
<row>
<column>
<text fontName="Arial" fontSize="11.0" x="36.00" y="341.33" width="30.62" height="11.04">Item 1</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" x="286.13" y="341.33" width="6.12" height="11.04">1</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" x="398.35" y="341.33" width="27.51" height="11.04">40.00</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" x="531.94" y="341.33" width="27.50" height="11.04">40.00</text>
</column>
</row>
<row>
<column>
<text fontName="Arial" fontSize="11.0" x="36.00" y="362.45" width="30.62" height="11.04">Item 2</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" x="286.13" y="362.45" width="6.12" height="11.04">2</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" x="398.35" y="362.45" width="27.51" height="11.04">30.00</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" x="531.94" y="362.45" width="27.50" height="11.04">60.00</text>
</column>
</row>
<row>
<column>
<text fontName="Arial" fontSize="11.0" x="36.00" y="383.57" width="30.62" height="11.04">Item 3</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" x="286.13" y="383.57" width="6.12" height="11.04">3</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" x="398.35" y="383.57" width="27.51" height="11.04">20.00</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" x="531.94" y="383.57" width="27.50" height="11.04">60.00</text>
</column>
</row>
<row>
<column>
<text fontName="Arial" fontSize="11.0" x="36.00" y="404.93" width="30.62" height="11.04">Item 4</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" x="286.13" y="404.93" width="6.12" height="11.04">4</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" x="398.35" y="404.93" width="27.51" height="11.04">10.00</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" x="531.94" y="404.93" width="27.50" height="11.04">40.00</text>
</column>
</row>
<row>
<column>
<text fontName="Arial" fontSize="11.0" fontStyle="Bold" x="389.11" y="425.83" width="36.75" height="11.04">TOTAL</text>
</column>
<column>
<text fontName="Arial" fontSize="11.0" fontStyle="Bold" x="525.82" y="425.83" width="33.62" height="11.04">200.00</text>
</column>
</row>
</page>
</document>
```

## Convert PDF to HTML 

### https://api.pdf.co/v1/pdf/convert/to/html

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** This method converts PDF, PNG, JPG documents into HTML. Automatically preserves the original visual layout, vectors, images, formatting. `GET` or `POST` request.  


**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|
|`simple`| optional. Set `true` to convert to a plain HTML format. Default is the rich HTML & CSS format keeping the document design. Must be one of: `true`, `false`.|
|`columns`| optional. Set `true` if the PDF document is arranged in columns like a newspaper. Default is `false`. Must be one of: `true`, `false`.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"name" : "result.html",
	"pages" : "",
	"password" : "",
	"simple" : "false",
	"columns" : "false",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-html/sample.pdf"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/7fc6c335b5f34ad8981b8dba6bc5919f/index.html",
    "pageCount": 1,
    "error": false,
    "status": 200,
    "name": "result.html"
}
```
result.html
```
<!DOCTYPE html PUBLIC " -//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
<title></title>
<style>
.page { background-color:white; position:relative; z-index:0; }
.vector { position:absolute; z-index:1; }
.image { position:absolute; z-index:2; }
.text { position:absolute; z-index:3; opacity:inherit; white-space:nowrap; }
.annotation { position:absolute; z-index:5; }
.control { position:absolute; z-index:10; }
.annotation2 { position:absolute; z-index:7; }
.dummyimg { vertical-align: top; border: none; }
</style>
</head>
<body style="background-color:#999999;color:#000000;">
<div align="center">

<!-- page begin -->
<div class="page" style="width:1024.0px;height:1448.2px;">

<span style="color:#538DD3;font-size:41px;font-family:'Arial';font-weight:bold;">
<span class="text" style="left:61.9px;top:59.2px;">Your Company Name</span>
</span>
<span style="font-size:19px;font-family:'Arial';">
<span class="text" style="left:61.9px;top:132.3px;">Your Address</span>
<span class="text" style="left:61.9px;top:157.3px;">City, State Zip</span>
</span>
<span style="font-size:19px;font-family:'Arial';font-weight:bold;">
<span class="text" style="left:793.0px;top:199.4px;">Invoice No. 123456</span>
<span class="text" style="left:750.9px;top:224.4px;">Invoice Date 01/01/2016</span>
<span class="text" style="left:61.9px;top:266.5px;">Client Name</span>
</span>
<span style="font-size:19px;font-family:'Arial';">
<span class="text" style="left:61.9px;top:291.9px;">Address</span>
<span class="text" style="left:61.9px;top:316.9px;">City, State Zip</span>
<span class="text" style="left:61.9px;top:401.3px;">Notes</span>
</span>
<span style="font-size:19px;font-family:'Arial';font-weight:bold;">
<span class="text" style="left:61.9px;top:544.0px;">Item</span>
<span class="text" style="left:425.9px;top:544.0px;">Quantity</span>
<span class="text" style="left:686.2px;top:544.0px;">Price</span>
<span class="text" style="left:917.0px;top:544.0px;">Total</span>
</span>
<span style="font-size:19px;font-family:'Arial';">
<span class="text" style="left:61.9px;top:587.1px;">Item 1</span>
<span class="text" style="left:492.2px;top:587.1px;">1</span>
<span class="text" style="left:685.2px;top:587.1px;">40.00</span>
<span class="text" style="left:915.0px;top:587.1px;">40.00</span>
<span class="text" style="left:61.9px;top:623.4px;">Item 2</span>
<span class="text" style="left:492.2px;top:623.4px;">2</span>
<span class="text" style="left:685.2px;top:623.4px;">30.00</span>
<span class="text" style="left:915.0px;top:623.4px;">60.00</span>
<span class="text" style="left:61.9px;top:659.8px;">Item 3</span>
<span class="text" style="left:492.2px;top:659.8px;">3</span>
<span class="text" style="left:685.2px;top:659.8px;">20.00</span>
<span class="text" style="left:915.0px;top:659.8px;">60.00</span>
<span class="text" style="left:61.9px;top:696.5px;">Item 4</span>
<span class="text" style="left:492.2px;top:696.5px;">4</span>
<span class="text" style="left:685.2px;top:696.5px;">10.00</span>
<span class="text" style="left:915.0px;top:696.5px;">40.00</span>
</span>
<span style="font-size:19px;font-family:'Arial';font-weight:bold;">
<span class="text" style="left:669.3px;top:732.5px;">TOTAL</span>
<span class="text" style="left:904.5px;top:732.5px;">200.00</span>
</span>
<div class="vector" style="left:52.0px;top:472.0px;"><img width="921" height="292" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA5kAAAEkCAYAAAClnfWkAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAA7hSURBVHhe7duxq1b3Hcfx+zc4Cxn8GwQHIQ46Z+keoX9Am3ZwjMOdSrZuSge54E2WpgmXYkhRyGqbMaiDQ/6R5Hce5VIOB/pcKue8T3i94EP0e8FMB3w/5/Hkf/h87BczMzMzMzOzsbdjAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA8Fv0n7F/jj03s8z+vnAzs+32t7HHs5uZbbsvxs5mNzPbdj+NHTx/+fLlz69fv/7FzBJ7e/36dc+kWWhPnjz54fT09MXSz8xsmz148ODrZ8+e/bj0MzPbZnfu3PnxfWOKTLPYRKZZbCLTrDeRadabyDTrTmSaxSYyzXoTmWa9iUyz7kSmWWwi06w3kWnWm8g0605kmsUmMs16E5lmvYlMs+5EpllsItOsN5Fp1pvINOtOZJrFJjLNehOZZr2JTLPuRKZZbCLTrDeRadabyDTrTmSaxSYyzXoTmWa9iUyz7kSmWWwi06w3kWnWm8g0605kmsUmMs16E5lmvYlMs+5EpllsItOsN5Fp1tuVI/PVq1dm9gG29HzNdnRkLv35Zna1LT1b810lMpf+H2Z2tS09W/MdG5lLf76ZXX1Lz9d83mSadXdUZB77sJvZ/79jI/PNmzeLdzP78PMm02zdHfN3T5Fp1p3INItNZJr1JjLN1p3INNv3RKZZbCLTrDeRabbuRKbZvicyzWITmWa9iUyzdScyzfY9kWkWm8g0601kmq07kWm274lMs9hEpllvItNs3YlMs31PZJrFJjLNehOZZutOZJrteyLTLDaRadabyDRbdyLTbN8TmWaxiUyz3kSm2boTmWb7nsg0i01kmvUmMs3Wncg02/dEpllsItOsN5Fptu5Eptm+JzLNYhOZZr2JTLN1JzLN9j2RaRabyDTrTWSarTuRabbviUyz2ESmWW8i02zdiUyzfU9kmsUmMs16E5lm605kmu17ItMsNpFp1pvINFt3ItNs3xOZZrGJTLPeRKbZuhOZZvueyDSLTWSa9SYyzdadyDTb90SmWWwi06w3kWm27kSm2b4nMs1iE5lmvYlMs3UnMs32PZFpFpvINOtNZJqtO5Fptu8dFZlmtt6OjUwz+zA75i+zx0amD2XN1pvINOtOZJrFJjLNevMm06w3kWnWncg0i01kmvUmMs16E5lm3YlMs9hEpllvItOsN5Fp1p3INItNZJr1JjLNehOZZt2JTLPYRKZZbyLTrDeRadadyDSLTWSa9SYyzXoTmWbdiUyz2ESmWW8i06w3kWnWncg0i01kmvUmMs16E5lm3YlMs9hEpllvItOsN5Fp1p3INItNZJr1JjLNehOZZt2JTLPYRKZZbyLTrDeRadadyDSLTWSa9SYyzXr778g8u3v37g/Twcy23+3bt/997do1z6RZaxe3bt36duFuZhvt5s2bZ/fu3ftu6Wdmts1u3Ljx3fvGPHk+9tG7XwIRb9//F2j4dOzzd78EIqZn8uN3vwQiprY8EJnQIzKhRWRCj8iEHpEJYSITWkQm9IhM6BGZECYyoUVkQo/IhB6RCWEiE1pEJvSITOgRmRAmMqFFZEKPyIQekQlhIhNaRCb0iEzoEZkQJjKhRWRCj8iEHpEJYSITWkQm9IhM6BGZECYyoUVkQo/IhB6RCWEiE1pEJvSITOgRmRAmMqFFZEKPyIQekQlhIhNaRCb0iEzoEZkQJjKhRWRCj8iEHpEJYSITWkQm9IhM6BGZECYyoUVkQo/IhB6RCWEiE1pEJvSITOgRmRAmMqFFZEKPyIQekQlhIhNaRCb0iEzoEZkQJjKhRWRCj8iEHpEJYSITWkQm9IhM6BGZECYyoUVkQo/IhB6RCWEiE1pEJvSITOgRmRAmMqFFZEKPyIQekQlhIhNaRCb0iEzoEZkQJjKhRWRCj8iEHpEJYSITWkQm9IhM6BGZECYyoUVkQo/IhB6RCWEiE1pEJvSITOgRmRAmMqFFZEKPyIQekQlhIhNaRCb0iEzoEZkQJjKhRWRCj8iEHpEJYSITWkQm9IhM6BGZECYyoUVkQo/IhB6RCWEiE1pEJvSITOgRmRAmMqFFZEKPyIQekQlhIhNaRCb0iEzouYzMs7FvxqaDmTX2YuFmZtvt6dj57GZm2+7R2Fezm5ltu4uxg+k33mRCizeZ0OJNJvR4kwk9U1seiEzoEZnQIjKhR2RCj8iEMJEJLSITekQm9IhMCBOZ0CIyoUdkQo/IhDCRCS0iE3pEJvSITAgTmdAiMqFHZEKPyIQwkQktIhN6RCb0iEwIE5nQIjKhR2RCj8iEMJEJLSITekQm9IhMCBOZ0CIyoUdkQo/IhDCRCS0iE3pEJvSITAgTmdAiMqFHZEKPyIQwkQktIhN6RCb0iEwIE5nQIjKhR2RCj8iEMJEJLSITekQm9IhMCBOZ0CIyoUdkQo/IhDCRCS0iE3pEJvSITAgTmdAiMqFHZEKPyIQwkQktIhN6RCb0iEwIE5nQIjKhR2RCj8iEMJEJLSITekQm9IhMCBOZ0CIyoUdkQo/IhDCRCS0iE3pEJvSITAgTmdAiMqFHZEKPyIQwkQktIhN6RCb0iEwIE5nQIjKhR2RCj8iEMJEJLSITekQm9IhMCBOZ0CIyoUdkQo/IhDCRCS0iE3pEJvSITAgTmdAiMqFHZEKPyIQwkQktIhN6RCb0iEwIE5nQIjKhR2RCj8iEMJEJLSITekQm9IhMCBOZ0CIyoUdkQs9lZJ6N/WNsOphZYy8Wbma23Z6Onc9uZrbtHo19ObuZ2ba7GDuYfuNNJrR4kwkt3mRCjzeZ0DO15YHIhB6RCS0iE3pEJvSITAgTmdAiMqFHZEKPyIQwkQktIhN6RCb0iEwIE5nQIjKhR2RCj8iEMJEJLSITekQm9IhMCBOZ0CIyoUdkQo/IhDCRCS0iE3pEJvSITAgTmdAiMqFHZEKPyIQwkQktIhN6RCb0iEwIE5nQIjKhR2RCj8iEMJEJLSITekQm9IhMCBOZ0CIyoUdkQo/IhDCRCS0iE3pEJvSITAgTmdAiMqFHZEKPyIQwkQktIhN6RCb0iEwIE5nQIjKhR2RCj8iEMJEJLSITekQm9IhMCBOZ0CIyoUdkQo/IhDCRCS0iE3pEJvSITAgTmdAiMqFHZEKPyIQwkQktIhN6RCb0iEwIE5nQIjKhR2RCj8iEMJEJLSITekQm9IhMCBOZ0CIyoUdkQo/IhDCRCS0iE3pEJvSITAgTmdAiMqFHZEKPyIQwkQktIhN6RCb0iEwIE5nQIjKhR2RCj8iEMJEJLSITekQm9IhMCBOZ0CIyoUdkQo/IhDCRCS0iE3pEJvSITAgTmdAiMqFHZEKPyIQwkQktIhN6RCb0iEwIE5nQIjKhR2RCj8iEMJEJLSITekQm9FxG5tnYJ2PTQ2pmjX2/cDOz7fbZ2OnsZmbb7uHY/dnNzLbdl2MHj8emh3T6NMjMGvt24WZm2+0vY3+d3cxs203P5fThz9LPzGybnY8d+Los9Pi6LLT4uiz0TM/k9OYE6PBvMiFMZEKLyIQekQk9IhPCRCa0iEzoEZnQIzIhTGRCi8iEHpEJPSITwkQmtIhM6BGZ0CMyIUxkQovIhB6RCT0iE8JEJrSITOgRmdAjMiFMZEKLyIQekQk9IhPCRCa0iEzoEZnQIzIhTGRCi8iEHpEJPSITwkQmtIhM6BGZ0CMyIUxkQovIhB6RCT0iE8JEJrSITOgRmdAjMiFMZEKLyIQekQk9IhPCRCa0iEzoEZnQIzIhTGRCi8iEHpEJPSITwkQmtIhM6BGZ0CMyIUxkQovIhB6RCT0iE8JEJrSITOgRmdAjMiFMZEKLyIQekQk9IhPCRCa0iEzoEZnQIzIhTGRCi8iEHpEJPSITwkQmtIhM6BGZ0CMyIUxkQovIhB6RCT0iE8JEJrSITOgRmdAjMiFMZEKLyIQekQk9IhPCRCa0iEzoEZnQIzIhTGRCi8iEHpEJPSITwkQmtIhM6BGZ0CMyIUxkQovIhB6RCT0iE8JEJrSITOgRmdAjMiFMZEKLyIQekQk9IhPCRCa0iEzoEZnQIzIhTGRCi8iEHpEJPZeReTb2zdh0MLPGXizczGy7PR07n93MbNs9GvtqdjOzbXcxdjBF5idj0ydBZtbYvxZuZrbd/jR2OruZ2bZ7OHZ/djOzbTd98HMwFaevy0KLr8tCi6/LQo+vy0LP1JYHIhN6RCa0iEzoEZnQIzIhTGRCi8iEHpEJPSITwkQmtIhM6BGZ0CMyIUxkQovIhB6RCT0iE8JEJrSITOgRmdAjMiFMZEKLyIQekQk9IhPCRCa0iEzoEZnQIzIhTGRCi8iEHpEJPSITwkQmtIhM6BGZ0CMyIUxkQovIhB6RCT0iE8JEJrSITOgRmdAjMiFMZEKLyIQekQk9IhPCRCa0iEzoEZnQIzIhTGRCi8iEHpEJPSITwkQmtIhM6BGZ0CMyIUxkQovIhB6RCT0iE8JEJrSITOgRmdAjMiFMZEKLyIQekQk9IhPCRCa0iEzoEZnQIzIhTGRCi8iEHpEJPSITwkQmtIhM6BGZ0CMyIUxkQovIhB6RCT0iE8JEJrSITOgRmdAjMiFMZEKLyIQekQk9IhPCRCa0iEzoEZnQIzIhTGRCi8iEHpEJPSITwkQmtIhM6BGZ0CMyIUxkQovIhB6RCT0iE8JEJrSITOgRmdAjMiFMZEKLyIQekQk9IhPCRCa0iEzoEZnQIzIhTGRCi8iEHpEJPSITwkQmtIhM6BGZ0HMZmRdjvxubHlIza+z7hZuZbbfPxk5nNzPbdg/H7s9uZrbtno0dPB6bHtLp0yAza+zBws3Mttsfx/4wu5nZtvv92J9nNzPbducnJycnvwJik4YKWnjRIQAAAABJRU5ErkJggg=="/></div>

</div>
<!-- page end -->
<p/>


</div>
</body>
</html>
```




# Extract Data From Spreadsheets

## Convert XLS/XLSX to JSON

### https://api.pdf.co/v1/xls/convert/to/json

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Convert XLS into JSON data file. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`worksheetIndex`| optional. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"url": "https://pdf-temp-files.s3-us-west-2.amazonaws.com/3ed127348fd448f487fc48cedf8fac4f/test.pdf",
	"encrypt": "true",
	"inline": "true"
}
```

**Response**

```
200
{
    "url": "https://pdf-temp-files.s3-us-west-2.amazonaws.com/3fabb587dc93440fbac88d6a812bf0f6/test.json?X-Amz-Expires=900&x-amz-security-token=FQoGZXIvYXdzEOb%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaDIHfFOU6w9zTAKZBvSKrAZoUa3hjPQtHC27ucOxm6rVYNCxu0vgFNurxRGKCmmG16ZqsHh%2FcKZ2JbOBUIpbSAmQGhFyMwTlTkZXUc5blkUv%2BoOPtp0RzQlph5zwqk1tdION233FOcUD7NTQf70FauxUjlYwVrmH0wCGBdsHRxtxi3FhE0wjo5Us2VpEIc2dQmcZupmKavFX9OdwYgWJmTOdNDcWkdtd3d80b5GMIy2MLhuPs2O8b%2FcrtYijy9rDmBQ%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4NRRSZPHLVOK2LHX/20190503/us-west-2/s3/aws4_request&X-Amz-Date=20190503T130035Z&X-Amz-SignedHeaders=host;x-amz-security-token&X-Amz-Signature=eb0463488e9c52eb6818db6c131b79e1179019e1236c0def8098a1bbb5802156",
    "error": false,
    "status": 200,
    "name": "test.json"
}
```
test.json
```
[
  {
    "Column0": "MC",
    "Column1": "What is 2+2?",
    "Column2": "4",
    "Column3": "correct",
    "Column4": "3",
    "Column5": "incorrect",
    "Column6": null,
    "Column7": null,
    "Column8": null
  },
  {
    "Column0": "MA",
    "Column1": "What C datatypes are 8 bits? (assume i386)",
    "Column2": "int",
    "Column3": null,
    "Column4": "float",
    "Column5": null,
    "Column6": "double",
    "Column7": null,
    "Column8": "char"
  },
  {
    "Column0": "TF",
    "Column1": "Bagpipes are awesome.",
    "Column2": "true",
    "Column3": null,
    "Column4": null,
    "Column5": null,
    "Column6": null,
    "Column7": null,
    "Column8": null
  },
  {
    "Column0": "ESS",
    "Column1": "How have the original Henry Hornbostel buildings influenced campus architecture and design in the last 30 years?",
    "Column2": null,
    "Column3": null,
    "Column4": null,
    "Column5": null,
    "Column6": null,
    "Column7": null,
    "Column8": null
  },
  {
    "Column0": "ORD",
    "Column1": "Rank the following in their order of operation.",
    "Column2": "Parentheses",
    "Column3": "Exponents",
    "Column4": "Division",
    "Column5": "Addition",
    "Column6": null,
    "Column7": null,
    "Column8": null
  },
  {
    "Column0": "FIB",
    "Column1": "The student activities fee is",
    "Column2": "95",
    "Column3": "dollars for students enrolled in",
    "Column4": "19",
    "Column5": "units or more,",
    "Column6": null,
    "Column7": null,
    "Column8": null
  },
  {
    "Column0": "MAT",
    "Column1": "Match the lower-case greek letter with its capital form.",
    "Column2": "λ",
    "Column3": "Λ",
    "Column4": "α",
    "Column5": "γ",
    "Column6": "Γ",
    "Column7": "φ",
    "Column8": "Φ"
  }
]

```

## Convert XLS/XLSX to CSV

### https://api.pdf.co/v1/xls/convert/to/csv

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Convert XLS into CSV comma separated values file. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`quotationSymbol`| optional. Must be a String.|
|`separatorSymbol`| optional. Must be a String.|
|`worksheetIndex`| optional. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"url": "https://pdf-temp-files.s3-us-west-2.amazonaws.com/ccba47ac2edb4a6bbf073f043ccbdaec/test.pdf",
	"encrypt": "true",
	"inline": "true"
}
```

**Response**

```
200
{
    "url": "https://pdf-temp-files.s3-us-west-2.amazonaws.com/e86688e95930415e9e961fc99794834c/test.csv?X-Amz-Expires=900&x-amz-security-token=FQoGZXIvYXdzEOX%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaDE1xTwIdrFN2HJCAWiKrAclWke02xxVGYPzp736pz11zRm6e0MMUNZrfoq1xwn%2BLEpV9R1Kh2qbOHzZ6cfyp94r9fT%2FVimkbbcG%2Bag3U0ME2dcjJjwoCpyS14F4cJbwLcmsHkDh4pr%2F%2B0Anpax7qXeNZnY%2FJJ%2BfF6PhN2epBeBkSUOKWYiJtxtn6jMNPIRMvri3btFeT0%2BBbqCQfSi5LLE8BaOi7SJiIvdV5QltUJENeB0aOqcFQtRiWYyiLyrDmBQ%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4NRRSZPHJS2SEKWE/20190503/us-west-2/s3/aws4_request&X-Amz-Date=20190503T112452Z&X-Amz-SignedHeaders=host;x-amz-security-token&X-Amz-Signature=e14219d40f3c27520a86959cb3b1ed6e73447b1e52a8921f2af35ce3bf4dd392",
    "error": false,
    "status": 200,
    "name": "test.csv"
}

```
test.csv
```
MC,What is 2+2?,4,correct,3,incorrect,,,
MA,What C datatypes are 8 bits? (assume i386),int,,float,,double,,char
TF,Bagpipes are awesome.,true,,,,,,
ESS,How have the original Henry Hornbostel buildings influenced campus architecture and design in the last 30 years?,,,,,,,
ORD,Rank the following in their order of operation.,Parentheses,Exponents,Division,Addition,,,
FIB,The student activities fee is,95,dollars for students enrolled in,19,"units or more,",,,
MAT,Match the lower-case greek letter with its capital form.,?,?,a,?,G,f,F

```

## Convert XLS/XLSX to HTML

### https://api.pdf.co/v1/xls/convert/to/html

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Convert XLS into HTML. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`worksheetIndex`| optional. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"url": "https://pdf-temp-files.s3-us-west-2.amazonaws.com/80f542b9966a4b2ea8e426825bc940b5/test.pdf",
	"encrypt": "true",
	"inline": "true"
}
```

**Response**

```
200
{
    "url": "https://pdf-temp-files.s3-us-west-2.amazonaws.com/e3bf06b1ad454c45be0f16b4936c9c21/test.html?X-Amz-Expires=900&x-amz-security-token=FQoGZXIvYXdzEOX%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaDDLm%2FhxM%2F7p35%2B3aQCKrAYikd%2FHE3esI62HnIbjD9anrfVPsXMGg%2B6cnzaqTqOewy6kAmD2oCj07egoaPMDVGXFxrDtUNgshduItWYkn5QiXoHCrRnA%2BrGYdzjLCIUAtxZhCPMkCa1C43q92%2BEJqUThhjKVXcDVhhSlo4euHodQvTr41itxcAeWBTG32E0hKvOE6yxh3%2Fnr4vLsLwJlaqtWq1UTr29STNZp2ZzSYwGFQkHiibe%2Brhhh54ijry7DmBQ%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4NRRSZPHCPND7PMR/20190503/us-west-2/s3/aws4_request&X-Amz-Date=20190503T112836Z&X-Amz-SignedHeaders=host;x-amz-security-token&X-Amz-Signature=339aff7ff71c8350615979d412289a94898ebdfe4bcda309f201969f15f6f0c0",
    "error": false,
    "status": 200,
    "name": "test.html"
}
```

**test.html**

```
<html><head><meta http-equiv="Content-Type" content="text/html; charset=Windows-1252">
<title>Example Test</title><style>.xl00{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:400;font-style:normal;font-family:Arial;vertical-align:bottom;white-space:nowrap}.xl01{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:400;font-style:normal;font-family:Arial;vertical-align:bottom;white-space:nowrap}.xl02{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:400;font-style:normal;font-family:Arial;vertical-align:bottom;white-space:nowrap}.xl03{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:400;font-style:normal;font-family:Arial;vertical-align:bottom}.xl04{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:400;font-style:normal;font-family:Arial;vertical-align:bottom;white-space:nowrap}.xl05{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:400;font-style:normal;font-family:Times New Roman;vertical-align:bottom}.xl06{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:700;font-style:normal;font-family:Arial;text-align:center;vertical-align:middle;white-space:nowrap}.xl07{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:400;font-style:normal;font-family:Arial;text-align:center;vertical-align:middle;white-space:nowrap}.xl08{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:700;font-style:normal;font-family:Arial;text-align:center;vertical-align:middle;white-space:nowrap}.xl09{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:700;font-style:normal;font-family:Arial;vertical-align:bottom;white-space:nowrap}.xl10{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:400;font-style:normal;font-family:Arial;text-align:center;vertical-align:middle;white-space:nowrap}.xl11{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:400;font-style:normal;font-family:Arial;text-align:center;vertical-align:bottom;white-space:nowrap}.xl12{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:700;font-style:normal;font-family:Arial;vertical-align:middle;white-space:nowrap}.xl13{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:700;font-style:normal;font-family:Arial;vertical-align:middle;white-space:nowrap}.xl14{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:400;font-style:normal;font-family:Arial;text-align:center;vertical-align:middle;white-space:nowrap}.xl15{padding:0 2px;color:windowtext;font-size:10.0pt;font-weight:400;font-style:normal;font-family:Arial;text-align:center;vertical-align:middle}</style>
</head>
<body>
<div style='padding:5px'>
<table border=0 cellpadding=1 cellspacing=0 style='border-collapse:collapse;table-layout:fixed'>
<col class=xl01 width=81 style='width:56pt'/>
<col class=xl01 width=318 style='width:222pt'/>
<col class=xl01 width=81 style='width:56pt'/>
<col class=xl01 width=185 style='width:129pt'/>
<col class=xl01 width=81 style='width:56pt'/>
<col class=xl01 width=90 style='width:63pt'/>
<col class=xl01 width=81 style='width:56pt'/>
<col class=xl01 width=81 style='width:56pt'/>
<col class=xl01 width=81 style='width:56pt'/>
<tr height=19 style='height:12.8pt'><td>MC</td><td>What is 2+2?</td><td>4</td><td>correct</td><td>3</td><td>incorrect</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp</td>
</tr>
<tr height=19 style='height:12.8pt'><td>MA</td><td>What C datatypes are 8 bits? (assume i386)</td><td>int</td><td>&nbsp;</td><td>float</td>
<td>&nbsp;</td><td>double</td><td>&nbsp;</td><td>char</td>
</tr>
<tr height=19 style='height:12.8pt'><td>TF</td><td>Bagpipes are awesome.</td><td class=xl02>true</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
</tr>
<tr height=51 style='height:35.1pt'><td>ESS</td><td class=xl03>How have the original Henry Hornbostel buildings influenced campus architecture and design in the last 30 years</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
<tr height=21 style='height:14.1pt'><td>ORD</td><td>Rank the following in their order of operation.</td><td>Parentheses</td><td>Exponents</td><td>Division</td><td>Addition</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
</tr>
<tr height=19 style='height:12.8pt'><td>FIB</td><td>The student activities fee is</td><td>95</td><td>dollars for students enrolled in</td><td>19</td><td class=xl04>units ormore,</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
<tr height=19 style='height:12.8pt'><td>MAT</td><td>Match the lower-case greek letter with its capital form.</td><td class=xl05>?</td><td>?</td>
<td class=xl05>a</td><td class=xl05>?</td><td class=xl05>G</td><td class=xl05>f</td><td class=xl05>F</td>
</tr>
</table>
</div>
</body>
</html>
```





# Create PDF

## PDF from CSV


### https://api.pdf.co/v1/pdf/convert/from/csv

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Convert CSV, XLS, XLSX to PDF conversion. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional.	Runs processing asynchronously. Returns Use JobId that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of:  `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST 
{
	"name" : "result.pdf",
	"pages" : "",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/csv-to-pdf/sample.csv"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/61939a1563f641ec97bb96133dbc7fda/result.pdf",
    "pageCount": 1,
    "error": false,
    "status": 200,
    "name": "result.pdf"
}
```

## PDF from Doc, DocX, RTF, TXT, XPS

### https://api.pdf.co/v1/pdf/convert/from/doc

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Convert DOC, DOCX, RTF, TXT, XPS files into PDF. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional.	Runs processing asynchronously. Returns Use JobId that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of:  `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST 
{
	"name" : "result.pdf",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/doc-to-pdf/sample.docx"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/2896686d380046379fa637408bee4cae/result.pdf",
    "pageCount": 1,
    "error": false,
    "status": 200,
    "name": "result.pdf"
}
```

## PDF from HTML

### https://api.pdf.co/v1/pdf/convert/from/html

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Convert HTML code snippet into full featured PDF. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional.	Runs processing asynchronously. Returns Use JobId that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of:  `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`templatedata`| optional. JSON model which will be used for processing HTML template. Must be a String.|
|`html`| required. HTML code. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST 
{
	"name" : "result.pdf",
	"html" : "true",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-html/sample.html"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/f26bb3e2736a49b0aca1409ceeb6d9a4/result.pdf",
    "pageCount": 1,
    "error": false,
    "status": 200,
    "name": "result.pdf"
}
```

## PDF from Website URL

### https://api.pdf.co/v1/pdf/convert/from/url

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Create a rich PDF copy of a website by passing URL link to the source. `GET` request.



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional.	Runs processing asynchronously. Returns Use JobId that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of:  `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`templatedata`| optional. JSON model which will be used for processing HTML template. Must be a String.|
|`url`| required. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST 
{
	"name" : "result.pdf",
	"url" : "https://www.wikipedia.org"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/1c660474b355433c955b0b1b27a8a9e1/result.pdf",
    "pageCount": 2,
    "error": false,
    "status": 200,
    "name": "result.pdf"
}
```

## PDF from Image

### https://api.pdf.co/v1/pdf/convert/from/image

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Create PDF file from one or more JPG, PNG, TIF images. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional.	Runs processing asynchronously. Returns Use JobId that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of:  `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| required. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST 
{
	"name" : "result.pdf",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/image-to-pdf/image1.png,https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/image-to-pdf/image1.png"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/dd39f19e88c94fdb94bb3fddc8d7d702/result.pdf",
    "pageCount": 2,
    "error": false,
    "status": 200,
    "name": "result.pdf"
}
```

## PDF from XLS or XLSX

### https://api.pdf.co/v1/xls/convert/to/pdf

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Convert XLS, XLSX, CSV spreadsheets into PDF. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional.	Runs processing asynchronously. Returns Use JobId that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of:  `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source barcodes file.|
|`url`| optional. URL of the image or pdf file to decode barcodes from. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`worksheetIndex`|optional. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST 
{
	"url": "https://pdf-temp-files.s3-us-west-2.amazonaws.com/test.xls",
	"encrypt": "true",
	"inline": "true"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3-us-west-2.amazonaws.com/2f00906c8169492383fcd798e807ebd7/test.pdf?X-Amz-Expires=900&x-amz-security-token=FQoGZXIvYXdzEOX%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaDP5RdL2ErMNg67Y%2FuyKrAb8K9VbJ5AxHBFGQ6S1CPfrVnqw0%2FCGkGtADuqVP7kTlA5emccNNPG0sOFcMxG7oZQDg3p4YAtVpX2IM8JOXs93hqh2HCd3%2BNVPgEXv1s8GeA4S7Pf6q9CvZ0BOEHKvnBWYzjdk1RpcJP2ZzdCaWpxiZK1xTVqKgMfJEUg99Y%2F4%2BgwUovoijvtjjT4K94xRW%2B8VpGlkMD0sFgkgeKr5EMsI5zpE3U3L%2Fzk8CcyjDzbDmBQ%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4NRRSZPHK7DGY775/20190503/us-west-2/s3/aws4_request&X-Amz-Date=20190503T113212Z&X-Amz-SignedHeaders=host;x-amz-security-token&X-Amz-Signature=b4ecd9b7930f3b823ef8f7f41154ce9257e01ac0c55c68d9f7a1c613e08876ed",
    "pageCount": 1,
    "error": false,
    "status": 200,
    "name": "test.pdf"
}
```

**test.pdf**

```
MC What is 2+2?
4 correct
3 incorrect
MA What C datatypes are 8 bits? (assume i386) int float double char
TF Bagpipes are awesome. true
ESS
How have the original Henry Hornbostel
buildings influenced campus architecture and
ORD Rank the following in their order of operation. ParenthesesExponents Division Addition
FIB The student activities fee is 95 dollars for students enrolled in19 units or more,
MAT Match the lower-case greek letter with its capital form.
```



# PDF Tools

## Merge and Split PDF 

### https://api.pdf.co/v1/pdf/merge

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Merges two PDF documents. `GET` or `POST` request.  

**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional.Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"name" : "result.pdf",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-merge/sample1.pdf,https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-merge/sample2.pdf"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/6770ea74efe048e4a5e8009f0d0b5e4a/result.pdf",
    "error": false,
    "status": 200,
    "name": "result.pdf"
}
```

### https://api.pdf.co/v1/pdf/split

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Split PDF document. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional.Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`pages`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"name" : "result.pdf",
	"pages" : "1-2,3-",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf"
}
```
**Response**

```
200
{
    "urls": [
        "https://pdf-temp-files.s3.amazonaws.com/bd7bbb99a8d74bbebc222bb9dd31bced/result_page1-2.pdf",
        "https://pdf-temp-files.s3.amazonaws.com/ffe034a207a044569daa675f68a825a3/result_page3-.pdf"
    ],
    "pageCount": 4,
    "error": false,
    "status": 200,
    "name": "result.pdf"
}
```

## Edit and Modify PDF 

### https://api.pdf.co/v1/pdf/makesearchable

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Turns unsearchable PDF files into searchable PDF files by extracting plain text from every page and by adding invisible text layer to every page of the PDF. 
Please use `GET` or `POST` request.  


**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`profiles`| optional. Must be a String.|
|`lang`| optional. Language of PDF file (eng, fra, spa, deu). Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|
|`rect`| optional. Must be a String.|
|`pages`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"name" : "result.pdf",
	"password" : "",
	"pages" : "",
	"lang" : "eng",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-make-searchable/sample.pdf"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/1c62ca49686a458abf7e66da801e64dd/result.pdf",
    "pageCount": 1,
    "error": false,
    "status": 200,
    "name": "result.pdf"
}
```

## Optimize PDF File Size

### https://api.pdf.co/v1/pdf/optimize

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Optimizes existing PDF file to reduce its file size. This is done by re-compressing embedded images, cleaning up internals of PDF document. For PDFs with scanned images you may decrease total file size by 3-20x times. 
Please use `GET` or `POST` request.  

**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional.Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"name" : "result.pdf",
	"password" : "",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-optimize/sample.pdf"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/a27efb3fe30548dca795dff0aa4b5eb5/result-compressed.pdf",
    "fileSize": 798473,
    "pageCount": 5,
    "error": false,
    "status": 200,
    "name": "result-compressed.pdf"
}
```
## Add Text and Images to PDF

### https://api.pdf.co/v1/pdf/edit/add

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Adds text and images to existing pdf file



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`width`| optional. Width of the signature in PDF Points (1/72 in.). Must be a Integer.|
|`height`| optional. Height of the signature in PDF Points (1/72 in.). Must be a Integer.|
|`y`| optional. Y coordinate of the signature in PDF Points (1/72 in.). Must be a Integer.|
|`x`| optional. X coordinate of the signature in PDF Points (1/72 in.). Must be a Integer.|
|`transparent`| optional. Must be one of: `true`, `false`.|
|`color`| optional. Must be a String.|
|`urlimage`| optional. URL of the signature image file. Must be a String.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`text`| optional. Must be a String.|
|`type`| optional. Must be a String.|
|`fontname`| optional. Must be a String.|
|`pages`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**
Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"async": false,
        "name": "newDocument",
	"url": "https://www.ets.org/Media/Tests/GRE/pdf/gre_research_validity_data.pdf",
	"annotations":[
		{
			"text":"Test custom text to pdf",
			"x": 10,
			"y": 10,
			"size": 12,
			"pages": '0,1,3'
		}
	],
	"images": [
		{
			"url":"http://www.catster.com/wp-content/uploads/2017/10/A-kitten-meowing-with-his-mouth-open.jpg",
			"x": 10,
			"y": 40,
			"width": 200,
			"height": 150,
			"pages": '1,2'
		}
	]
	
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/f3a554d38704482ab1ff7293f377d86d/newDocument.pdf",
    "error": false,
    "status": 200,
    "name": null
}
```



## Render PDF to JPG

### https://api.pdf.co/v1/pdf/convert/to/jpg

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** PDF to JPEG conversion. High quality rendering. Also works great for thumbnails generation and previews. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|
|`rect`| optional. Must be a String.|
|`pages`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"pages" : "",
	"password" : "",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-image/sample.pdf"
}
```

**Response**

```
200
{
    "urls": [
        "https://pdf-temp-files.s3.amazonaws.com/0291888f85734236b72afda7b512cf3f/sample.jpg",
        "https://pdf-temp-files.s3.amazonaws.com/620576910561405296072e8a84f73f7e/sample.jpg"
    ],
    "pageCount": 2,
    "error": false,
    "status": 200,
    "name": "sample.jpg"
}
```

## Render PDF to PNG

### https://api.pdf.co/v1/pdf/convert/to/png

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** PDF to PNG conversion. High quality rendering. Also works great for thumbnails generation and previews. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|
|`rect`| optional. Must be a String.|
|`pages`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

!! ! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"pages" : "",
	"password" : "",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-image/sample.pdf"
}
```
**Response**

```
200
{
    "urls": [
        "https://pdf-temp-files.s3.amazonaws.com/0c28920424a14c168c29b596c97df41a/sample.png",
        "https://pdf-temp-files.s3.amazonaws.com/16cf5a5edd594254aeea5636cd06bf2c/sample.png"
    ],
    "pageCount": 2,
    "error": false,
    "status": 200,
    "name": "sample.png"
}
```

## Render PDF to TIFF

### https://api.pdf.co/v1/pdf/convert/to/tiff

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** PDF to high quality TIFF images conversion. High quality rendering. Also works great for thumbnails generation and previews. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`password`| optional. Password of PDF file. Must be a String.|
|`rect`| optional. Must be a String.|
|`pages`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"name" : "result.tif",
	"pages" : "",
	"password" : "",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-to-image/sample.pdf"
}
```

**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/6f1e0f3a67c94c83bb9c527116753e62/result.tiff",
    "pageCount": 2,
    "error": false,
    "status": 200,
    "name": "result.tif"
}
```

# Barcodes

## Generate Barcodes 

####  https://api.pdf.co/v1/barcode/generate

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Generates high quality printable and scannable barcodes as images or PDF. All popular types are supported from Code 39, Code 128 to QR Code, Datamatrix and PDF417. `GET` or `POST` request.  


**Input Parameters**

|Param |	Description|
|-- |--
|`async`| optional.	Runs processing asynchronously. Returns Use JobId that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of:  `true`, `false`.|
|`encrypt`| optional.	Enable encryption for output file. Must be one of: `true`, `false`.|
|`name`| optional.	Filename for the generated image. Must be a String|
|`value`| optional. Value to be encoded into barcode. Must be a String|
|`type`| optional. Sets barcode type. Valid values are: `Code128`, `Code39`, `Postnet`, `UPCA`, `EAN8`, `ISBN`, `Codabar`, `I2of5`, `Code93`, `EAN13`, `JAN13`, `Bookland`, `UPCE`, `PDF417`, `PDF417Truncated`, `DataMatrix`, `QRCode`, `Aztec`, `Planet`, `EAN128`, `GS1_128`, `USPSSackLabel`, `USPSTrayLabel`, `DeutschePostIdentcode`, `DeutschePostLeitcode`, `Numly`, `PZN`, `OpticalProduct`, `SwissPostParcel`, `RoyalMail`, `DutchKix`, `SingaporePostalCode`, `EAN2`, `EAN5`, `EAN14`, `MacroPDF417`, `MicroPDF417`, `GS1_DataMatrix`, `Telepen`, `IntelligentMail`, `GS1_DataBar_Omnidirectional`, `GS1_DataBar_Truncated`, `GS1_DataBar_Stacked`, `GS1_DataBar_Stacked_Omnidirectional`, `GS1_DataBar_Limited`, `GS1_DataBar_Expanded`, `GS1_DataBar_Expanded_Stacked`, `MaxiCode`, `Plessey`, `MSI`, `ITF14`, `GTIN12`, `GTIN8`, `GTIN13`, `GTIN14`. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`200`| all is OK|
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
"name" : "barcode.png",
"type" : "Code128",
"value" : "qweasd123456"
}
```

**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/97c9b70b7ed54706ace0ea4ccb66a27d/barcode.png",
    "error": false,
    "status": 200,
    "name": "barcode.png"
}
```

## Read Barcodes From URL or file

Decode Code 39, Code 128, QR Code, Datamatrix, PDF417 and many other barcodes from jpg, png, tiff images and pdf documents  Supports almost all available barcode types. Supports reading of noisy and damaged barcodes.

#### https://api.pdf.co/v1/barcode/read/from/url

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Read barcodes from images, tiff, pdf documents, scanned documents. All popular types of barcodes are supported from Code 39, Code 128 to QR Code, Datamatrix and PDF417. Supports noisy and damaged barcodes, scans, documents. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional.	Runs processing asynchronously. Returns Use JobId that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of:  `true`, `false`.|
|`encrypt`| optional.	Enable encryption for output file. Must be one of: `true`, `false`.|
|`types`| optional. Comma-separated list of barcode types to decode. Valid types: `AustralianPostCode`, `Aztec`, `CircularI2of5`, `Codabar`, `CodablockF`, `Code128`, `Code16K`, `Code39`, `Code39Extended`, `Code39Mod43`, `Code39Mod43Extended`, `Code93`, `DataMatrix`, `EAN13`, `EAN2`, `EAN5`, `EAN8`, `GS1`, `GS1DataBarExpanded`, `GS1DataBarExpandedStacked`, `GS1DataBarLimited`, `GS1DataBarOmnidirectional`, `GS1DataBarStacked`, `GTIN12`, `GTIN13`, `GTIN14`, `GTIN8`, `IntelligentMail`, `Interleaved2of5`, `ITF14`, `MaxiCode`, `MICR`, `MicroPDF`, `MSI`, `PatchCode`, `PDF417`, `Pharmacode`, `PostNet`, `PZN`, `QRCode`, `RoyalMail`, `RoyalMailKIX`, `Trioptic`, `UPCA`, `UPCE`, `UPU`. Must be a String.|
|`file`| optional. Source barcodes file.|
|`url`| optional. URL of the image or pdf file to decode barcodes from. Must be a String.|
|`pages`| optional. Comma-separated list of page indices (or ranges) to process. IMPORTANT: the very first page starts at `0` (zero). To set a range use the dash `-`, for example: `0,2-5,7-`. To set a range from index to the last page use range like this: `2-` (from page #3 as the index starts at zero and till the of the document). For ALL pages just leave this param empty. Example: `0,2-5,7-` means first page, then 3rd page to 6th page, and then the range from 8th (index = `7`) page till the end of the document. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"types" : "Code128,Code39,Interleaved2of5,EAN13",
	"pages" : "",
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/barcode-reader/sample.pdf"
}
```

**Response**

```
200
{
    "barcodes": [
        {
            "Value": "test123",
            "RawData": null,
            "Type": 2,
            "Rect": "{X=111,Y=60,Width=255,Height=37}",
            "Page": 0,
            "File": "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/barcode-reader/sample.pdf",
            "Confidence": 0.90625155,
            "TypeName": "Code128"
        },
        {
            "Value": "123456",
            "RawData": null,
            "Type": 4,
            "Rect": "{X=111,Y=129,Width=306,Height=37}",
            "Page": 0,
            "File": "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/barcode-reader/sample.pdf",
            "Confidence": 0.7710818,
            "TypeName": "Code39"
        },
        {
            "Value": "<FNC1>0112345678901231",
            "RawData": null,
            "Type": 2,
            "Rect": "{X=111,Y=198,Width=305,Height=37}",
            "Page": 0,
            "File": "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/barcode-reader/sample.pdf",
            "Confidence": 0.9156459,
            "TypeName": "Code128"
        },
        {
            "Value": "12345670",
            "RawData": [
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                0
            ],
            "Type": 5,
            "Rect": "{X=111,Y=267,Width=182,Height=0}",
            "Page": 0,
            "File": "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/barcode-reader/sample.pdf",
            "Confidence": 1,
            "TypeName": "I2of5"
        },
        {
            "Value": "1234567890128",
            "RawData": null,
            "Type": 6,
            "Rect": "{X=102,Y=336,Width=71,Height=72}",
            "Page": 0,
            "File": "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/barcode-reader/sample.pdf",
            "Confidence": 0.895925164,
            "TypeName": "EAN13"
        }
    ],
    "pageCount": 1,
    "error": false,
    "status": 200,
    "name": null
}
```


# Web Tools

## URL to JPG

### https://api.pdf.co/v1/url/convert/to/jpg

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Create high-quality JPEG screenshot of web page using its URL. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`width`| optional. Must be a Integer.|
|`height`| optional. Must be a Integer.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"pages" : "",
	"password" : "",
	"url" : "https://www.wikipedia.org"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/cd64fc6d7f86423283cb0aa15e5f028d/www-wikipedia-org.jpg",
    "error": false,
    "status": 200,
    "name": "www-wikipedia-org.jpg"
}
```

##  URL to PNG

### https://api.pdf.co/v1/url/convert/to/png

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Create high-quality PNG screenshot of web page using its URL. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`async`| optional. Runs processing asynchronously. Returns Use `JobId` that you may use with `/job/check` to check state of the processing (possible states: `working`, `failed`, `aborted` and `success`). Must be one of: `true`, `false`.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|
|`file`| optional. Source PDF file.|
|`url`| optional. URL of the source PDF file. Must be a String.|
|`name`| optional. File name for generated output. Must be a String.|
|`width`| optional. Must be a Integer.|
|`height`| optional. Must be a Integer.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"pages" : "",
	"password" : "",
	"url" : "https://www.wikipedia.org"
}
```

**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/1a88abbb409246349a2de1b7db5905b5/www-wikipedia-org.png",
    "error": false,
    "status": 200,
    "name": "www-wikipedia-org.png"
}
```

# Manage Files and Jobs

## Upload Files 

### https://api.pdf.co/v1/file/upload/get-presigned-url

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** This method generates unique URL that you should use to upload your local file to using `POST` request. Then this url can be used as input for `url` parameter with data processing API methods.

- Get preassigned URL and it will generate unique URL that you may upload **to** withing next 30 minutes.
- Upload your file using `POST` request to this url
- Once uploading is finished you may use this unique URL with API methods as `url` input parameter. 

Note: all uploaded files are considered to be temporary files and are automatically permanently removed after 1 hour. 

Please use `GET` request.

**Input Parameters**

|Param|	Description|
|-- |--
|`name`| optional. The name the file will be stored with. Must be a String.|
|`contenttype`| required. Content-Type describing the data contained in the request body, Use `binary/octet-stream`. Must be a String.|
|`encrypt`| optional. Enable encryption for output file. Must be one of: `true`, `false`.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
GET
https://api.pdf.co/v1/file/upload/get-presigned-url?name=test.pdf&encrypt=true
```
**Response**

```
200
{
    "presignedUrl": "https://pdf-temp-files.s3-us-west-2.amazonaws.com/8e6a3f213ab14b1eaec4129266272889/test.pdf?X-Amz-Expires=900&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIZJDPLX6D7EHVCKA/20190503/us-west-2/s3/aws4_request&X-Amz-Date=20190503T104604Z&X-Amz-SignedHeaders=host&X-Amz-Signature=7fb773668fb6ac15532dfa6a9f7bab241bc1afe567a011fdb356042366d7fbaf",
    "url": "https://pdf-temp-files.s3-us-west-2.amazonaws.com/8e6a3f213ab14b1eaec4129266272889/test.pdf?X-Amz-Expires=900&x-amz-security-token=FQoGZXIvYXdzEOT%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaDKoiK2aiU1cfW33eQCKrATMQ25KoZ3Ex4wHvXMkyLzgVKaIPvZ0bdlQDgQ%2BD3mN1UrHHEakgIORVsRKouT4nFdXNTbexSyuETkdZzsJlzC4Hr5CxqRVE%2FllC1O2u3hHrteSbBpEoL7n%2BMghWyLxpc5oOjMLZbOn4N6xEiqRJWEBk3VT%2FcnSzm%2FP%2Bi0iGvGpmUw1c8jKBDLyB6acL8OMLVVF5nIpwQXsdWneYA7J83qWaPX8sob86AjTouSjzt7DmBQ%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA4NRRSZPHFYWDDTRO/20190503/us-west-2/s3/aws4_request&X-Amz-Date=20190503T104604Z&X-Amz-SignedHeaders=host;x-amz-security-token&X-Amz-Signature=8cbb8e398edca39993ebb4bffb729d25e279bf612bce523d2b73daf57e43d1c0",
    "error": false,
    "status": 200,
    "name": "test.pdf"
}
```


### https://api.pdf.co/v1/file/upload/url

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Downloads file from a source url and uploads it as a temporary file. Temporary files are automatically permanently removed after 1 hour. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`name`| optional. The name the file will be stored with. Must be a String.|
|`url`| required. URL of the file to upload. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/745a49f734524db4990ecd96bed6c32f/sample.pdf",
    "error": false,
    "status": 200,
    "name": "sample.pdf"
}
```

### https://api.pdf.co/v1/file/upload/url

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Uploads file as a temporary file. Temporary files are automatically permanently removed after 1 hour. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`name`| optional. The name the file will be stored with. Must be a String.|
|`file`| required. Source File. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/745a49f734524db4990ecd96bed6c32f/sample.pdf",
    "error": false,
    "status": 200,
    "name": "sample.pdf"
}
```

### https://api.pdf.co/v1/file/upload/base64

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Creates temporary file using base64 source data. You may use this temporary file URL with other API methods. Temporary files are automatically permanently removed after 1 hour. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`name`| optional. The name the file will be stored with. Must be a String.|
|`file`| required. Base64-encoded file bytes. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf",
	"file" : "data:image/gif;base64,R0lGODlhEAAQAPUtACIiIScnJigoJywsLDIyMjMzMzU1NTc3Nzg4ODk5OTs7Ozw8PEJCQlBQUFRUVFVVVVhYWG1tbXt7fInDRYvESYzFSo/HT5LJVJPJVJTKV5XKWJbKWZbLWpfLW5jLXJrMYaLRbaTScKXScKXScafTdIGBgYODg6alprLYhbvekr3elr3el9Dotf///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAAAAAAAIf8LSW1hZ2VNYWdpY2sNZ2FtbWE9MC40NTQ1NQAsAAAAABAAEAAABpJAFGgkKhpFIRHpw2qBLJiLdCrNTFKt0wjD2Xi/G09l1ZIwRJeNZs3uUFQtEwCCVrM1bnhJYHDU73ktJQELBH5pbW+CAQoIhn94ioMKB46HaoGTB5WPaZmMm5wOIRcekqChliIZFXqoqYYkE2SaoZuWH1gmAgsIvr8ICQUPTRIABgTJyskFAw1ZDBAO09TUDw0RQQA7"
}
```
**Response**

```
200
{
    "url": "https://pdf-temp-files.s3.amazonaws.com/5654328672ff42948699e5001653a33e/uploadfile.txt",
    "error": false,
    "status": 200,
    "name": null
}
```


### https://api.pdf.co/v1/file/hash

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** Calculate and return MD5 hash of file by url. Commonly used to control if source document has been changed or not because every little change will cause hash string to differ as well. `GET` or `POST` request.  



**Input Parameters**

|Param|	Description|
|-- |--
|`file`| optional. Source file to calculate hash.|
|`url`| optional. URL of the file to calculate hash. Must be a String.|

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`403`|	not enough credits|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"url" : "https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf",
	"file" : ""
}
```
**Response**

```
200
{
    "hash": "d942e5becdcb0386598cce15e9e56deb1ca9d893b8578a88eca4a62f02c4000b"
}
```

## Manage Background Jobs

### https://api.pdf.co/v1/job/check

*This method requires PDF.co API key. Get yours [here](https://app.pdf.co/signup)*

**Description:** This method checks status of backgroud job by their `jobId`. You may create background job by calling API methods with `async` parameter set to `true`. 
Checks and returns status of a job that is running in background. 

Available statuses are:
- `working`: this background job is still working. 
- `failed`: this background job failed to execute.
- `aborted`: this background job aborted by user.
- `success`: this background job successfully executed.

Please use `GET` or `POST` request.  


**Input Parameters**

|Param|	Description|
|-- |--
|`jobId`| required. Id of processing that was started asynchronously. Must be a String. |

**Status Errors**

| Code	| Description|
|-- |--
|`400`| bad input parameters|
|`401`|	unauthorized|
|`405`|	Timeout error. To process large documents or files please use asynchronous mode ( set `async` parameter to true) and then check the status using `/job/check` endpoint. If file contains many pages then specify a page range using pages parameter. The number of pages of the document can be obtained using the endpoint `/pdf/info`|

**Example**

Sample Request:

! Don't forget to set `x-api-key` param or header param to API key, get yours [here](https://app.pdf.co/signup)

```
POST
{
	"jobId" : "123"
}
```
**Response**

```
200
{
    "status": "working"
}
```



