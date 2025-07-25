<%@include file="/WEB-INF/jsp/controllers/BrokerControllerJSP.jsp" %>

<%
BrokerControllerJSP broker = new BrokerControllerJSP();
String id = request.getParameter("id");

String profile_data = broker.viewOneProfile(id);

String major_stock_holder_data = broker.viewMajorStockHolderByProfileId(id);

String major_client_data = broker.viewMajorClientByProfileId(id);
%>

<script src="/cprs/assets/js/lib/jsPDF/jspdf.debug.js"></script>
<script src="/cprs/assets/js/lib/Blob/Blob.js"></script>
<script src="/cprs/assets/js/lib/FileSaver/src/FileSaver.js"></script>

<script>
class BrokerClass {
	constructor(doc, profile_data, major_stock_holder_data, major_client_data) {
		this.doc                     = doc;
		this.profile_data            = profile_data;
		this.major_stock_holder_data = major_stock_holder_data;
		this.major_client_data       = major_client_data;
		this.stockholder_with_client = 0;
		this.client_with_lastpage    = 0;
		this.client_with_lastpage2   = 0;
		this.pages_y                 = 0;
		this.boc_logo = "data:image/jpeg;base64,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";
		this.e2m_logo = "data:image/jpeg;base64,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";
	}
	
	firstPageLayout() {
		// header
		this.doc.addImage(this.boc_logo, 'JPEG', 10, 7, 15, 15);
		this.doc.addImage(this.e2m_logo, 'JPEG', 183, 6, 15, 15);

		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.setFontSize(10);
		this.doc.text("CLIENT PROFILE REGISTRATION SHEET (BROKER)", 26, 10);
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(7);
		this.doc.text("INSTRUCTION: Please provide the following required information according to your client type by filling out table cells or ticking off appropriate", 26, 13);
		this.doc.text("boxes in the 2nd column. Mandatory fields are written in bold type and marked with asterisks ( *). Items in the 2nd column with asterisks ( *) ", 26, 16);
		this.doc.text("and not in bold type are optional but become mandatory when one of them in the same optional group is being filled out. Figures in ", 26, 19);
		this.doc.text("parentheses indicate the exact/maximum number of characters allowed for the corresponding field.", 26, 22);

		// color
		this.doc.setFillColor(204,255,255);
		this.doc.rect(51, 23, 147, 7, 'F');

		this.doc.setFillColor(153,204,255);
		this.doc.rect(51, 23, 124, 7, 'F');

		this.doc.setFillColor(204,255,255);
		this.doc.rect(12, 30, 186, 86, 'F');
		this.doc.rect(12, 128, 186, 12, 'F');
		this.doc.rect(51, 146, 147, 6, 'F');
		this.doc.rect(12, 152, 186, 6, 'F');
		this.doc.rect(12, 158, 39, 12, 'F');

		// outer layout
		this.doc.setLineDash([2, 0], 2);  // straight line
		this.doc.line(12, 23, 198, 23);   // border top   (x2 = 198
		this.doc.line(12, 23, 12, 196);   // border left  (y2 = 196)
		this.doc.line(198, 23, 198, 196); // border right (y2 = 196)

		// inner layout
		this.doc.setLineDash([2, 1], 2);  // broken line
		this.doc.line(51, 23, 51, 196);   // inner layout separator (y2 = 196)

		// picture layout
		this.doc.setLineDash([2, 0], 2);  // straight line
		this.doc.line(175, 23, 175, 46);
		this.doc.line(175, 46, 198, 46);

		this.doc.setLineDash([2, 1], 2);  // broken line
		this.doc.line(12, 30, 175, 30);   // 1. CLIENT TYPE: 
		this.doc.line(12, 36, 175, 36);   // 2. NATURE OF BUSINESS*
		this.doc.line(12, 42, 175, 42);   // 3. BUSINESS ENTITY*
		this.doc.line(12, 48, 198, 48);   // 4. BUSINESS NAME*

		this.doc.line(12, 62, 198, 62);   // INDIVIDUAL 
		this.doc.line(73, 47, 73, 62);    // 

		this.doc.line(12, 68, 198, 68);   // 5. CITIZENSHIP*

		this.doc.line(12, 82, 198, 82);   // 6. BUSINESS ADDRESS*
		this.doc.line(12, 104, 198, 104); // 7. CONTACT INFORMATION
		this.doc.line(73, 68, 73, 104);   //

		this.doc.line(12, 110, 198, 110); // 8. TAX IDENTIFICATION .
		this.doc.line(12, 116, 198, 116); // 9. SOCIAL SECURITY No.* (12)
		this.doc.line(12, 122, 198, 122); // 10. PASSPORT No. (17)
		this.doc.line(12, 128, 198, 128); // 11. DRIVER'S LICENSE No.(17)
		this.doc.line(12, 134, 198, 134); // 12. PRC ID No.* (17) 
		this.doc.line(12, 140, 198, 140); // 13. PRIMARY VASP CCN No.*(12)
		this.doc.line(12, 146, 198, 146); // 14. SECONDARY VASP CCN No.

		this.doc.line(12, 152, 198, 152); // 15. PEZA-BOI Registration Number (if
									 // applicable)/ CARR Code * (17)
									 
		this.doc.line(12, 158, 198, 158); // 16.	SEC REGISTRATION No./ DTI
									 // REFERENCE No. * (17)

		this.doc.line(12, 164, 198, 164); // 17.	AMOUNT OF AUTHORIZED
									 // CAPITAL STOCK *
									 
		this.doc.line(12, 170, 198, 170); // 18. AMOUNT OF PAID-UP CAPITAL*
									 // (16).
									 
		this.doc.line(12, 184, 198, 184); // 19. RELATED DOMESTIC/FOREIGN
									 // COMPANIES (related to operator of
									 //	company)
									 
		this.doc.line(12, 190, 198, 190); // Importer TIN
		this.doc.line(12, 196, 198, 196); // Exporter TIN
		
		this.firstPageLabel();
		this.firstPageData();
	}
	
	majorStockHolderLayout() {
		if (this.major_stock_holder_data.length != 0) {
			let count = 0;
			for (let i = 0; i < this.major_stock_holder_data.length; i++) {
				count++;
				if (count == 1) {
					this.doc.addPage();
					
					// outer layout
					this.doc.setLineDash([2, 0], 2);   // straight line
					this.doc.line(12, 10, 12, 109);    // border left 
					this.doc.line(198, 10, 198, 109);  // border right

					// inner layout
					this.doc.setLineDash([2, 1], 2);   // broken line
					this.doc.line(51, 10, 51, 109);    // inner layout separator

					// picture layout
					this.doc.setLineDash([2, 0], 2);  // straight line
					this.doc.line(175, 10, 175, 33);
					this.doc.line(175, 33, 198, 33);
					
					this.doc.setLineDash([2, 1], 2);  // broken line
					this.doc.line(51, 17, 175, 17);   // FIRST NAME*(35)
					this.doc.line(51, 23, 175, 23);   // MIDDLE NAME*(35)
					this.doc.line(51, 29, 175, 29);   // LAST NAME*(35)
					this.doc.line(51, 35, 198, 35);   // CITIZENSHIP(17)
					this.doc.line(51, 41, 198, 41);   // TIN*(12)
					this.doc.line(51, 63, 198, 63);
					this.doc.line(51, 69, 198, 69);   // PHONE*(15)
					this.doc.line(51, 75, 198, 75);   // ALT PHONE(15)
					this.doc.line(51, 81, 198, 81);   // MOBILE(15)
					this.doc.line(51, 87, 198, 87);   // FAX(15)
					this.doc.line(51, 93, 198, 93);   // EMAIL*(88)
					this.doc.line(12, 109, 198, 109); // SIGNATURE
					
					this.singleMajorStockHolderLabel(i);
					this.singleMajorStockHolderData(this.major_stock_holder_data[i])
					this.stockholder_with_client = 1;

				} else {
					// second layout
					// outer layout
					this.doc.setLineDash([2, 0], 2);   // straight line
					this.doc.line(12, 109, 12, 208);   // border left 
					this.doc.line(198, 109, 198, 208); // border right

					// inner layout
					this.doc.setLineDash([2, 1], 2);   // broken line
					this.doc.line(51, 109, 51, 208);   // inner layout separator
					
					// picture layout
					this.doc.setLineDash([2, 0], 2);   // straight line
					this.doc.line(175, 109, 175, 132);
					this.doc.line(175, 132, 198, 132);
					
					this.doc.setLineDash([2, 1], 2);   // broken line
					this.doc.line(51, 116, 175, 116);  // FIRST NAME*(35)
					this.doc.line(51, 122, 175, 122);  // MIDDLE NAME*(35)
					this.doc.line(51, 128, 175, 128);  // LAST NAME*(35)
					this.doc.line(51, 134, 198, 134);  // CITIZENSHIP(17)
					this.doc.line(51, 140, 198, 140);  // TIN*(12)
					this.doc.line(51, 162, 198, 162);
					this.doc.line(51, 168, 198, 168);  // PHONE*(15)
					this.doc.line(51, 174, 198, 174);  // ALT PHONE(15)
					this.doc.line(51, 180, 198, 180);  // MOBILE(15)
					this.doc.line(51, 186, 198, 186);  // FAX(15)
					this.doc.line(51, 192, 198, 192);  // EMAIL*(88)
					this.doc.line(12, 208, 198, 208);  // SIGNATURE
					
					this.multiMajorStockHolderLabel(i);
					this.multiMajorStockHolderData(this.major_stock_holder_data[i]);
					this.stockholder_with_client = 0;
					count = 0;
				}
			}
		}
	}
	
	majorClientLayout() {
		if (this.major_client_data.length != 0) {
			let count = 0;
			for (let i = 0; i < this.major_client_data.length; i++) {
				count++;
				if (count == 1) {
					if (this.stockholder_with_client == 1) {
						// outer layout
						this.doc.setLineDash([2, 0], 2);   // straight line
						this.doc.line(12, 109, 12, 171);   // border left 
						this.doc.line(198, 109, 198, 171); // border right

						// inner layout
						this.doc.setLineDash([2, 1], 2);   // broken line
						this.doc.line(51, 109, 51, 171);   // inner layout separator
						
						this.doc.line(51, 115, 198, 115);  // CLIENT TYPE*
						this.doc.line(51, 121, 198, 121);  // COMPANY*
						this.doc.line(51, 127, 198, 127);  // TIN*
						this.doc.line(51, 133, 198, 133);  // ADDRESS*(70)
						this.doc.line(51, 147, 198, 147);  //
						this.doc.line(51, 153, 198, 153);  // PHONE*(15)
						this.doc.line(51, 159, 198, 159);  // ALT PHONE(15)
						this.doc.line(51, 165, 198, 165);  // FAX(15
						this.doc.line(12, 171, 198, 171);  // EMAIL*(88)
						
						this.withMajorClientLabel(i);
						this.withMajorClientData(this.major_client_data[i]);
						this.stockholder_with_client = 0;
						count = 0;
					} else {
						this.doc.addPage();
					
						// outer layout
						this.doc.setLineDash([2, 0], 2);  // straight line
						this.doc.line(12, 10, 12, 73);    // border left 
						this.doc.line(198, 10, 198, 73);  // border right

						// inner layout
						this.doc.setLineDash([2, 1], 2);  // broken line
						this.doc.line(51, 10, 51, 73);    // inner layout separator
						
						this.doc.line(51, 17, 198, 17);   // CLIENT TYPE*
						this.doc.line(51, 23, 198, 23);   // COMPANY*
						this.doc.line(51, 29, 198, 29);	  // TIN*
						this.doc.line(51, 35, 198, 35);   // ADDRESS*(70)
						this.doc.line(51, 49, 198, 49);   //
						this.doc.line(51, 55, 198, 55);   // PHONE*(15)
						this.doc.line(51, 61, 198, 61);   // ALT PHONE(15)
						this.doc.line(51, 67, 198, 67);   // FAX(15
						this.doc.line(12, 73, 198, 73);   // EMAIL*(88)
						
						this.singleMajorClientLabel(i);
						this.singleMajorClientData(this.major_client_data[i]);
						this.client_with_lastpage = 1;
					}
				} else if (count == 2) {
					// second layout
					// outer layout
					this.doc.setLineDash([2, 0], 2);  // straight line
					this.doc.line(12, 73, 12, 135);   // border left 
					this.doc.line(198, 73, 198, 135); // border right
					
					// inner layout
					this.doc.setLineDash([2, 1], 2);  // broken line
					this.doc.line(51, 73, 51, 135);   // inner layout separator
					
					this.doc.line(51, 79, 198, 79);   // CLIENT TYPE*
					this.doc.line(51, 85, 198, 85);   // COMPANY*
					this.doc.line(51, 91, 198, 91);	  // TIN*
					this.doc.line(51, 97, 198, 97);   // ADDRESS*(70)
					this.doc.line(51, 111, 198, 111); //
					this.doc.line(51, 117, 198, 117); // PHONE*(15)
					this.doc.line(51, 123, 198, 123); // ALT PHONE(15)
					this.doc.line(51, 129, 198, 129); // FAX(15
					this.doc.line(12, 135, 198, 135); // EMAIL*(88)
					
					this.multiMajorClientLabel1(i);
					this.multiMajorClientData1(this.major_client_data[i]);
					this.client_with_lastpage2 = 1;
					this.client_with_lastpage = 0;
				} else {
					// third layout
					// outer layout
					this.doc.setLineDash([2, 0], 2);   // straight line
					this.doc.line(12, 135, 12, 197);   // border left 
					this.doc.line(198, 135, 198, 197); // border right
					
					// inner layout
					this.doc.setLineDash([2, 1], 2);   // broken line
					this.doc.line(51, 135, 51, 197);   // inner layout separator
					
					this.doc.line(51, 141, 198, 141);  // CLIENT TYPE*
					this.doc.line(51, 147, 198, 147);  // COMPANY*
					this.doc.line(51, 153, 198, 153);  // TIN*
					this.doc.line(51, 159, 198, 159);  // ADDRESS*(70)
					this.doc.line(51, 173, 198, 173);  //
					this.doc.line(51, 179, 198, 179);  // PHONE*(15)
					this.doc.line(51, 185, 198, 185);  // ALT PHONE(15)
					this.doc.line(51, 191, 198, 191);  // FAX(15
					this.doc.line(12, 197, 198, 197);  // EMAIL*(88)
					
					count = 0;
					this.multiMajorClientLabel2(i);
					this.multiMajorClientData2(this.major_client_data[i])
					this.client_with_lastpage  = 0;
					this.client_with_lastpage2 = 0;
				}
			}	
		}
	}
	
	lastPageLayout() {
		if (this.client_with_lastpage == 1) {
			this.doc.setFont("helvetica", "normal", "normal");
			this.doc.setFontSize(8);

			this.doc.text("I certify that the foregoing information are true and correct to the best of my knowledge.", 12, 113);

			this.doc.text("_________________________", 12, 120);
			this.doc.text("(Signature over Printed Name)", 12, 124);
			this.doc.text("Date Signed:", 12, 128);
			this.doc.text("_______________", 29, 128);

			this.doc.text("REPUBLIC OF THE PHILIPPINES)", 12, 136);
			this.doc.text("CITY OF MANILA   ) S.S.", 12, 140);

			this.doc.text("Before me, a Notary Public for and in the City of Manila this ___ day of ________, 2022 personally appeared the following:", 12, 148);

			this.doc.text("NAME", 39, 156);
			this.doc.text("COMMUNITY TAX CERT. NO.", 90, 156);
			this.doc.text("DATE/PLACE ISSUED", 155, 156);

			this.doc.text("_____________________________", 21, 161);
			this.doc.text("_____________________________", 86, 161);
			this.doc.text("_____________________________", 147, 161);

			this.doc.text("_____________________________", 21, 166);
			this.doc.text("_____________________________", 86, 166);
			this.doc.text("_____________________________", 147, 166);

			this.doc.text("known to me to be the same persons who executed the foregoing instrument and they acknowledged to me that the same are their free and voluntary", 12, 173);
			this.doc.text("acts and deeds.", 12, 177);
			
			this.pages_y = 184;
			this.doc.text("This client profile registration form consisting of _____ pages, including the page on which this Acknowledgement is written and the Nature of", 12, this.pages_y);
			this.doc.text("Business attachment of ____ pages, has been signed on the left margin of each and every page and at the bottom of this instrument by the parties", 12, 188);
			this.doc.text("and their respective witnesses.", 12, 192);

			this.doc.text("WITNESS MY HAND AND NOTARIAL SEAL ON THE DAY, YEAR AND PLACE ABOVE-WRITTEN.", 12, 199);

			this.doc.text("Doc. No.", 12, 206);
			this.doc.text("_______;", 24, 206);

			this.doc.text("Page No.", 12, 210);
			this.doc.text("_______;", 25, 210);

			this.doc.text("Book No.", 12, 214);
			this.doc.text("_______;", 25, 214);

			this.doc.text("Series of", 12, 218);
			this.doc.text("_______.", 24, 218);

			this.client_with_lastpage = 0;
		} else if (this.client_with_lastpage2 == 1) {
			this.doc.setFont("helvetica", "normal", "normal");
			this.doc.setFontSize(8);

			this.doc.text("I certify that the foregoing information are true and correct to the best of my knowledge.", 12, 150);

			this.doc.text("_________________________", 12, 157);
			this.doc.text("(Signature over Printed Name)", 12, 161);
			this.doc.text("Date Signed:", 12, 165);
			this.doc.text("_______________", 29, 165);

			this.doc.text("REPUBLIC OF THE PHILIPPINES)", 12, 173);
			this.doc.text("CITY OF MANILA   ) S.S.", 12, 177);

			this.doc.text("Before me, a Notary Public for and in the City of Manila this ___ day of ________, 2022 personally appeared the following:", 12, 185);

			this.doc.text("NAME", 39, 193);
			this.doc.text("COMMUNITY TAX CERT. NO.", 90, 193);
			this.doc.text("DATE/PLACE ISSUED", 155, 193);

			this.doc.text("_____________________________", 21, 198);
			this.doc.text("_____________________________", 86, 198);
			this.doc.text("_____________________________", 147, 198);

			this.doc.text("_____________________________", 21, 203);
			this.doc.text("_____________________________", 86, 203);
			this.doc.text("_____________________________", 147, 203);

			this.doc.text("known to me to be the same persons who executed the foregoing instrument and they acknowledged to me that the same are their free and voluntary", 12, 210);
			this.doc.text("acts and deeds.", 12, 214);
			
			this.pages_y = 221;
			this.doc.text("This client profile registration form consisting of _____ pages, including the page on which this Acknowledgement is written and the Nature of", 12, this.pages_y);
			this.doc.text("Business attachment of ____ pages, has been signed on the left margin of each and every page and at the bottom of this instrument by the parties", 12, 225);
			this.doc.text("and their respective witnesses.", 12, 229);

			this.doc.text("WITNESS MY HAND AND NOTARIAL SEAL ON THE DAY, YEAR AND PLACE ABOVE-WRITTEN.", 12, 236);

			this.doc.text("Doc. No.", 12, 243);
			this.doc.text("_______;", 24, 243);

			this.doc.text("Page No.", 12, 247);
			this.doc.text("_______;", 25, 247);

			this.doc.text("Book No.", 12, 251);
			this.doc.text("_______;", 25, 251);

			this.doc.text("Series of", 12, 255);
			this.doc.text("_______.", 24, 255);

			this.client_with_lastpage2 = 0;
		} else {
			this.doc.addPage();
			this.doc.setFont("helvetica", "normal", "normal");
			this.doc.setFontSize(8);

			this.doc.text("I certify that the foregoing information are true and correct to the best of my knowledge.", 12, 13);

			this.doc.text("_________________________", 12, 20);
			this.doc.text("(Signature over Printed Name)", 12, 24);
			this.doc.text("Date Signed:", 12, 28);
			this.doc.text("_______________", 29, 28);

			this.doc.text("REPUBLIC OF THE PHILIPPINES)", 12, 36);
			this.doc.text("CITY OF MANILA   ) S.S.", 12, 40);

			this.doc.text("Before me, a Notary Public for and in the City of Manila this ___ day of ________, 2022 personally appeared the following:", 12, 48);

			this.doc.text("NAME", 39, 56);
			this.doc.text("COMMUNITY TAX CERT. NO.", 90, 56);
			this.doc.text("DATE/PLACE ISSUED", 155, 56);

			this.doc.text("_____________________________", 21, 61);
			this.doc.text("_____________________________", 86, 61);
			this.doc.text("_____________________________", 147, 61);

			this.doc.text("_____________________________", 21, 66);
			this.doc.text("_____________________________", 86, 66);
			this.doc.text("_____________________________", 147, 66);

			this.doc.text("known to me to be the same persons who executed the foregoing instrument and they acknowledged to me that the same are their free and voluntary", 12, 73);
			this.doc.text("acts and deeds.", 12, 77);
			
			this.pages_y = 84;
			this.doc.text("This client profile registration form consisting of _____ pages, including the page on which this Acknowledgement is written and the Nature of", 12, this.pages_y);
			this.doc.text("Business attachment of ____ pages, has been signed on the left margin of each and every page and at the bottom of this instrument by the parties", 12, 88);
			this.doc.text("and their respective witnesses.", 12, 92);

			this.doc.text("WITNESS MY HAND AND NOTARIAL SEAL ON THE DAY, YEAR AND PLACE ABOVE-WRITTEN.", 12, 99);

			this.doc.text("Doc. No.", 12, 106);
			this.doc.text("_______;", 24, 106);

			this.doc.text("Page No.", 12, 110);
			this.doc.text("_______;", 25, 110);

			this.doc.text("Book No.", 12, 114);
			this.doc.text("_______;", 25, 114);

			this.doc.text("Series of", 12, 118);
			this.doc.text("_______.", 24, 118);
		}
	}
	
	download() {
		let page_count = this.doc.internal.getNumberOfPages();

		this.doc.setFontSize(7);
		this.doc.text(String(page_count), String(page_count).length == 1 ? 75 : 74, (this.pages_y - 0.5)); // consisting of

		for (let i = 1; i <= page_count; i++) {
			this.doc.setPage(i);
			this.doc.addImage(this.e2m_logo, 'JPEG', 12, 285, 6, 6);
			this.doc.text("CLIENT PROFILE REGISTRATION FORM (Broker)______________________________________________________________________\t\t\t"+String(i) + ' of ' + String(page_count), 19, 290);
		}
		
		let data   = doc.output();
		let buffer = new ArrayBuffer(data.length);
		let array  = new Uint8Array(buffer);

		for (let i = 0; i < data.length; i++) {
			array[i] = data.charCodeAt(i);
		}
		
		// from Blob.js
		let blob = new Blob(
			[array],
			{type: 'application/pdf', encoding: 'raw'}
		);
		
		// from FileSaver.js
		saveAs(blob, "Client_Profile_Information_Sheet_Broker");
		
		setTimeout(() => {
		  window.history.back();
		}, "5000");
	}
	
	firstPageLabel() {
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.setFontSize(8);
		this.doc.text("1. CLIENT TYPE:", 13, 28);
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(10);
		this.doc.text("BROKER", 52, 28);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.setFontSize(8);
		this.doc.text("2. NATURE OF BUSINESS*", 13, 34);
		
		this.doc.text("3. BUSINESS ENTITY*", 13, 40);
		
		this.doc.text("4. BUSINESS NAME*", 13, 46);
		
		this.doc.text("INDIVIDUAL NAME", 16, 56);
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.text("FIRST NAME", 52, 51);
		this.doc.text("MIDDLE NAME", 52, 56);
		this.doc.text("LAST NAME", 52, 61);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.text("5. CITIZENSHIP*", 13, 66);
		
		this.doc.text("6. BUSINESS ADDRESS*", 13, 76);
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.setFontSize(6);
		this.doc.text("ADDRESS*(70)", 52, 71);
		this.doc.text("CITY*(25)", 52, 76);
		this.doc.text("ZIPCODE*(9)", 130, 76);
		this.doc.text("COUNTRY*(2)", 52, 81);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.setFontSize(7.8); // 8
		this.doc.text("7. CONTACT INFORMATION", 13, 94);
		this.doc.setFontSize(6);
		this.doc.text("PHONE*(7-15)", 52, 85);
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.text("FAX(7-15)", 52, 90);
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.text("EMAIL*(88)", 52, 95);
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.text("WEBSITE(100)", 52, 102);
		this.doc.text("ALT.PHONE(7-15)", 130, 85);
		this.doc.text("MOBILE(10-15)", 130, 90);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.setFontSize(7);
		this.doc.text("8. TAX IDENTIFICATION", 13, 108);
		
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.text("9. SOCIAL SECURITY No.* (12)", 13, 114);
		
		this.doc.text("10. PASSPORT No. (17)", 13, 120);
		
		this.doc.text("11. DRIVER'S LICENSE No.(17)", 13, 126);
		
		this.doc.text("12. PRC ID No.* (17)", 13, 132);
		
		this.doc.setFontSize(6.7); // 7
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.text("13. PRIMARY VASP CCN No.*(12)", 13, 138);
		
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(7);
		this.doc.text("14. SECONDARY VASP CCN No.", 13, 144);
		
		this.doc.setFontSize(6);
		this.doc.text("15. PEZA-BOI Registration Number (if", 13, 149);
		this.doc.text("applicable)/ CARR Code * (17)", 13, 151.7);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.text("16. SEC REGISTRATION No./ DTI", 13, 154.7);
		this.doc.text("REFERENCE No. * (17)", 13, 157.5);
		
		this.doc.text("17. AMOUNT OF AUTHORIZED", 13, 160.5);
		this.doc.text("CAPITAL STOCK *", 13, 163.5);
		
		this.doc.text("18. AMOUNT OF PAID-UP CAPITAL*", 13, 166.5);
		this.doc.text("(16)", 13, 169.5);
		
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.text("19. RELATED DOMESTIC/FOREIGN", 13, 173.5);
		this.doc.text("COMPANIES (related to operator of", 13, 176);
		this.doc.text("company)", 13, 178);
		
		this.doc.setFontSize(8);
		this.doc.text("IMPORTER TIN", 13, 188);
		
		this.doc.text("EXPORTER TIN", 13, 194);
	}
	
	singleMajorStockHolderLabel(number) {
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(8);
		this.doc.text("MAJOR STOCKHOLDER* "+(number+1), 13, 15);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.setFontSize(7);
		this.doc.text("FIRST NAME*(35)", 52, 15.5);
		this.doc.text("MIDDLE NAME*(35)", 52, 21);
		this.doc.text("LAST NAME*(35)", 52, 27);
		this.doc.text("CITIZENSHIP(17)", 52, 33);
		this.doc.text("TIN*(12)", 52, 39);
		
		this.doc.text("ADDRESS*(70)", 52, 44);
		this.doc.text("CITY*(25)", 52, 49);
		this.doc.text("ZIPCODE*(9)", 52, 55);
		this.doc.text("COUNTRY*(2)", 52, 61);
		
		this.doc.text("PHONE*(15)", 52, 67);
		
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.text("ALT PHONE(15)", 52, 73);
		this.doc.text("MOBILE(15)", 52, 79);
		this.doc.text("FAX(15)", 52, 85);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.text("EMAIL*(88)", 52, 91);
		this.doc.text("SIGNATURE", 52, 102);
	}
	
	multiMajorStockHolderLabel(number) {
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(8);
		this.doc.text("MAJOR STOCKHOLDER* "+(number+1), 13, 114);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.setFontSize(7);
		this.doc.text("FIRST NAME*(35)", 52, 114.5);
		this.doc.text("MIDDLE NAME*(35)", 52, 120);
		this.doc.text("LAST NAME*(35)", 52, 126);
		this.doc.text("CITIZENSHIP(17)", 52, 132);
		this.doc.text("TIN*(12)", 52, 138);
		
		this.doc.text("ADDRESS*(70)", 52, 143);
		this.doc.text("CITY*(25)", 52, 148);
		this.doc.text("ZIPCODE*(9)", 52, 154);
		this.doc.text("COUNTRY*(2)", 52, 160);
		
		this.doc.text("PHONE*(15)", 52, 166);
		
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.text("ALT PHONE(15)", 52, 172);
		this.doc.text("MOBILE(15)", 52, 178);
		this.doc.text("FAX(15)", 52, 184);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.text("EMAIL*(88)", 52, 190);
		this.doc.text("SIGNATURE", 52, 201);
	}
	
	singleMajorClientLabel(number) {
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(10);
		this.doc.text("MAJOR CLIENT    "+(number+1), 13, 15);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.setFontSize(7);
		this.doc.text("CLIENT TYPE*", 52, 15.5);
		this.doc.text("COMPANY", 52, 21);
		this.doc.text("TIN*", 52, 27);
		this.doc.text("ADDRESS*(70)", 52, 33);
		
		this.doc.text("CITY*(25)", 52, 38);
		this.doc.text("ZIPCODE*(9)", 52, 43);
		this.doc.text("COUNTRY*(2)", 52, 48);
		
		this.doc.text("PHONE*(15)", 52, 53);
		
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.text("ALT PHONE(15)", 52, 59);
		this.doc.text("FAX(15)", 52, 65);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.text("EMAIL*(88)", 52, 71);
	}
	
	multiMajorClientLabel1(number) {
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(10);
		this.doc.text("MAJOR CLIENT    "+(number+1), 13, 77);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.setFontSize(7);
		this.doc.text("CLIENT TYPE*", 52, 77.5);
		this.doc.text("COMPANY", 52, 83);
		this.doc.text("TIN*", 52, 89);
		this.doc.text("ADDRESS*(70)", 52, 95);
		
		this.doc.text("CITY*(25)", 52, 100);
		this.doc.text("ZIPCODE*(9)", 52, 105);
		this.doc.text("COUNTRY*(2)", 52, 110);
		
		this.doc.text("PHONE*(15)", 52, 115);
		
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.text("ALT PHONE(15)", 52, 121);
		this.doc.text("FAX(15)", 52, 127);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.text("EMAIL*(88)", 52, 133);
	}
	
	multiMajorClientLabel2(number) {
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(10);
		this.doc.text("MAJOR CLIENT    "+(number+1), 13, 139);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.setFontSize(7);
		this.doc.text("CLIENT TYPE*", 52, 139.5);
		this.doc.text("COMPANY", 52, 145);
		this.doc.text("TIN*", 52, 151);
		this.doc.text("ADDRESS*(70)", 52, 157);
		
		this.doc.text("CITY*(25)", 52, 162);
		this.doc.text("ZIPCODE*(9)", 52, 167);
		this.doc.text("COUNTRY*(2)", 52, 172);
		
		this.doc.text("PHONE*(15)", 52, 177);
		
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.text("ALT PHONE(15)", 52, 183);
		this.doc.text("FAX(15)", 52, 189);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.text("EMAIL*(88)", 52, 195);
	}
	
	withMajorClientLabel(number) {
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(10);
		this.doc.text("MAJOR CLIENT    "+(number+1), 13, 113);
		
		this.doc.setFont("helvetica", "bold", "normal");5
		this.doc.setFontSize(7);
		this.doc.text("CLIENT TYPE*", 52, 113.5);
		this.doc.text("COMPANY", 52, 119); 
		this.doc.text("TIN*", 52, 125);
		this.doc.text("ADDRESS*(70)", 52, 131);
		
		this.doc.text("CITY*(25)", 52, 136);
		this.doc.text("ZIPCODE*(9)", 52, 141);
		this.doc.text("COUNTRY*(2)", 52, 146);
		
		this.doc.text("PHONE*(15)", 52, 151);
		
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.text("ALT PHONE(15)", 52, 157);
		this.doc.text("FAX(15)", 52, 163);
		
		this.doc.setFont("helvetica", "bold", "normal");
		this.doc.text("EMAIL*(88)", 52, 169);
	}
	
	firstPageData() {
		if (this.getProfileData('picture') == "data:image/jpeg;base64," || this.getProfileData('picture') == "") {
			window.history.back();
		}
		
		let img = this.doc.getImageProperties(this.getProfileData('picture'));
		
		let profile = this.imageProfile(22.6, 22.6, img);
		
		this.doc.addImage(this.getProfileData('picture'), 'JPEG', 175.1, 23.2, profile.width, profile.height);
		//22.6, 22.5);

		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(8);
		this.doc.text(this.getProfileData('natureofbusiness'), 52, 34);
		
		this.doc.text(this.getProfileData('businesstype'), 52, 40);
		
		this.doc.text(this.getProfileData('company'), 52, 46);
		
		this.doc.setFontSize(7);
		this.doc.text(this.getProfileData('firstname'), 74, 51);
		
		this.doc.text(this.getProfileData('middlename'), 74, 56);
		
		this.doc.text(this.getProfileData('lastname'), 74, 61);
		
		this.doc.setFontSize(8);
		this.doc.text(this.getProfileData('citizenship'), 52, 66);
		
		// business address
		this.doc.setFontSize(7);
		this.doc.text(this.getProfileData('address'), 74, 71);
		
		this.doc.text(this.getProfileData('city'), 74, 76);
		
		this.doc.text(this.getProfileData('zipcode'), 150, 76);
		
		this.doc.text(this.getProfileData('country'), 74, 81);
		// end business address
		
		// contact information
		this.doc.text(this.getProfileData('telephone'), 74, 85);
		
		this.doc.text(this.getProfileData('fax'), 74, 90);
		
		this.doc.text(this.getProfileData('email'), 74, 95);
		
		this.doc.text(this.getProfileData('website'), 74, 102);
		
		this.doc.text(this.getProfileData('alttelephone'), 150, 85);
		
		this.doc.text(this.getProfileData('mobile'), 150, 90);
		// end of contact information
		
		this.doc.setFontSize(8);
		this.doc.text(this.getProfileData('tinno'), 52, 108);
		
		this.doc.text(this.getProfileData('sssidno'), 52, 114);
		
		this.doc.text(this.getProfileData('passportidno'), 52, 120);
		
		this.doc.text(this.getProfileData('driverlicenseidno'), 52, 126);
		
		this.doc.text(this.getProfileData('prcidno'), 52, 132);
		
		this.doc.text(this.getProfileData('vaspprimaryccn'), 52, 138);
		
		this.doc.text(this.getProfileData('vaspsecondaryccn'), 52, 144);
		
		this.doc.text(this.getProfileData('pezaidno'), 52, 150);
		
		this.doc.text(this.getProfileData('secidno'), 52, 156);
		
		this.doc.text(this.getProfileData('capitalstockamount'), 52, 162);
		
		this.doc.text(this.getProfileData('paidupcapitalqmount'), 52, 168);
		
		// COMPANIES (related to operator of company)
		this.doc.setFontSize(6);
		this.doc.text(this.getProfileData('relatedcompanyname1'), 52, 173);
		
		this.doc.text(this.getProfileData('relatedcompanyname2'), 52, 177.5);
		
		this.doc.text(this.getProfileData('relatedcompanyname3'), 52, 182);
		// end of COMPANIES
		
		this.doc.setFontSize(8);
		this.doc.text(this.getProfileData('importertin'), 52, 188);
		
		this.doc.text(this.getProfileData('exportertin'), 52, 194);
	}
	
	getProfileData(property) {
		return this.profile_data.hasOwnProperty(property) ? this.profile_data[property] : "";
	}
	
	getMajorStockHolderData(object, property) {
		return object.hasOwnProperty(property) ? object[property] : "";
	}
	
	getMajorClientData(object, property) {
		return object.hasOwnProperty(property) ? object[property] : "";
	}
	
	singleMajorStockHolderData(major_stockholder) {
		if (this.getMajorStockHolderData(major_stockholder, 'picture') == "data:image/jpeg;base64," || this.getMajorStockHolderData(major_stockholder, 'picture') == "") {
			window.history.back();
		}
		
		if (this.getMajorStockHolderData(major_stockholder, 'signature') == "data:image/jpeg;base64," || this.getMajorStockHolderData(major_stockholder, 'signature') == "") {
			window.history.back();
		}
		
		let imgp = this.doc.getImageProperties(this.getMajorStockHolderData(major_stockholder, 'picture'));
		
		let profile = this.imageProfile(22.6, 22.6, imgp);
		
		this.doc.addImage(this.getMajorStockHolderData(major_stockholder, 'picture'), 'JPEG', 175.1, 10.2, profile.width, profile.height);
		//22.6, 22.5);
		
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(7);
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'firstname'), 76, 15.5);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'middlename'), 76, 21);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'lastname'), 76, 27);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'citizenship'), 76, 33);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'tinno'), 76, 39);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'address'), 76, 44);
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'city'), 76, 49);
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'zipcode'), 76, 55);
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'country'), 76, 61);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'telephone'), 76, 67);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'alttelephone'), 76, 73);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'mobile'), 76, 79);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'fax'), 76, 85);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'email'), 76, 91);
		
		let img = this.doc.getImageProperties(this.getMajorStockHolderData(major_stockholder, 'signature'));
		
		let signature = this.imageSignature(47, 13, img);
		
		this.doc.addImage(this.getMajorStockHolderData(major_stockholder, 'signature'), 'JPEG', 76, 95, signature.width, signature.height);
	}
	
	imageSignature(MAX_WIDTH, MAX_HEIGHT, img) {
		let res = {};
		
		let width = img.width;
		let height = img.height;
		
		if (width >= 100) {
			// use same value
		} else {
			width = 100;
			height = 100;
		}

		// Change the resizing logic
		if (width > height) {
			if (width > MAX_WIDTH) {
				height = height * (MAX_WIDTH / width);
				width = MAX_WIDTH;
			}
		} else {
			if (height > MAX_HEIGHT) {
				width = width * (MAX_HEIGHT / height);
				height = MAX_HEIGHT;
			}
		}
		
		res.width = width;
		res.height = height;
		
		return res;
	}
	
	imageProfile(MAX_WIDTH, MAX_HEIGHT, img) {
		let res = {};
		
		let width = img.width;
		let height = img.height;

		// Change the resizing logic
		if (width > height) {
			if (width > MAX_WIDTH) {
				height = height * (MAX_WIDTH / width);
				width = MAX_WIDTH;
			}
		} else {
			if (height > MAX_HEIGHT) {
				width = width * (MAX_HEIGHT / height);
				height = MAX_HEIGHT;
			}
		}
		
		res.width = width;
		res.height = height;
		
		return res;
	}
	
	multiMajorStockHolderData(major_stockholder) {
		if (this.getMajorStockHolderData(major_stockholder, 'picture') == "data:image/jpeg;base64," || this.getMajorStockHolderData(major_stockholder, 'picture') == "") {
			window.history.back();
		}
		
		if (this.getMajorStockHolderData(major_stockholder, 'signature') == "data:image/jpeg;base64," || this.getMajorStockHolderData(major_stockholder, 'signature') == "") {
			window.history.back();
		}
		
		let imgp = this.doc.getImageProperties(this.getMajorStockHolderData(major_stockholder, 'picture'));
		
		let profile = this.imageProfile(22.6, 22.6, imgp);
		
		this.doc.addImage(this.getMajorStockHolderData(major_stockholder, 'picture'), 'JPEG', 175.1, 111, profile.width, profile.height);
		
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(7);
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'firstname'), 76, 114.5);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'middlename'), 76, 120);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'lastname'), 76, 126);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'citizenship'), 76, 132);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'tinno'), 76, 138);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'address'), 76, 143);
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'city'), 76, 148);
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'zipcode'), 76, 154);
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'country'), 76, 160);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'telephone'), 76, 166);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'alttelephone'), 76, 172);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'mobile'), 76, 178);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'fax'), 76, 184);
		
		this.doc.text(this.getMajorStockHolderData(major_stockholder, 'email'), 76, 190);
		
		let img = this.doc.getImageProperties(this.getMajorStockHolderData(major_stockholder, 'signature'));
		
		let signature = this.imageSignature(47, 13, img);
		
		this.doc.addImage(this.getMajorStockHolderData(major_stockholder, 'signature'), 'JPEG', 76, 194, signature.width, signature.height);
	}
	
	singleMajorClientData(major_client) {
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(7);
		this.doc.text(this.getMajorClientData(major_client, 'clienttype'), 76, 15.5);
		this.doc.text(this.getMajorClientData(major_client, 'company'), 76, 21);
		this.doc.text(this.getMajorClientData(major_client, 'tin'), 76, 27);
		this.doc.text(this.getMajorClientData(major_client, 'address'), 76, 33);
		
		this.doc.text(this.getMajorClientData(major_client, 'city'), 76, 38);
		this.doc.text(this.getMajorClientData(major_client, 'zipcode'), 76, 43);
		this.doc.text(this.getMajorClientData(major_client, 'country'), 76, 48);
		
		this.doc.text(this.getMajorClientData(major_client, 'telephone'), 76, 53);
		
		this.doc.text(this.getMajorClientData(major_client, 'alttelephone'), 76, 59);
		this.doc.text(this.getMajorClientData(major_client, 'fax'), 76, 65);
		this.doc.text(this.getMajorClientData(major_client, 'email'), 76, 71);
	}
	
	multiMajorClientData1(major_client) {
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(7);
		this.doc.text(this.getMajorClientData(major_client, 'clienttype'), 76, 77.5);
		this.doc.text(this.getMajorClientData(major_client, 'company'), 76, 83);
		this.doc.text(this.getMajorClientData(major_client, 'tin'), 76, 89);
		this.doc.text(this.getMajorClientData(major_client, 'address'), 76, 95);
		
		this.doc.text(this.getMajorClientData(major_client, 'city'), 76, 100);
		this.doc.text(this.getMajorClientData(major_client, 'zipcode'), 76, 105);
		this.doc.text(this.getMajorClientData(major_client, 'country'), 76, 110);
		
		this.doc.text(this.getMajorClientData(major_client, 'telephone'), 76, 115);
		
		this.doc.text(this.getMajorClientData(major_client, 'alttelephone'), 76, 121);
		this.doc.text(this.getMajorClientData(major_client, 'fax'), 76, 127);
		this.doc.text(this.getMajorClientData(major_client, 'email'), 76, 133);
	}
	
	multiMajorClientData2(major_client) {
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(7);
		this.doc.text(this.getMajorClientData(major_client, 'clienttype'), 76, 139.5);
		this.doc.text(this.getMajorClientData(major_client, 'company'), 76, 145);
		this.doc.text(this.getMajorClientData(major_client, 'tin'), 76, 151);
		this.doc.text(this.getMajorClientData(major_client, 'address'), 76, 157);
		
		this.doc.text(this.getMajorClientData(major_client, 'city'), 76, 162);
		this.doc.text(this.getMajorClientData(major_client, 'zipcode'), 76, 167);
		this.doc.text(this.getMajorClientData(major_client, 'country'), 76, 172);
		
		this.doc.text(this.getMajorClientData(major_client, 'telephone'), 76, 177);
		
		this.doc.text(this.getMajorClientData(major_client, 'alttelephone'), 76, 183);
		this.doc.text(this.getMajorClientData(major_client, 'fax'), 76, 189);
		this.doc.text(this.getMajorClientData(major_client, 'email'), 76, 195);
	}
	
	withMajorClientData(major_client) {
		this.doc.setFont("helvetica", "normal", "normal");
		this.doc.setFontSize(7);
		this.doc.text(this.getMajorClientData(major_client, 'clienttype'), 76, 113.5);
		this.doc.text(this.getMajorClientData(major_client, 'company'), 76, 119); 
		this.doc.text(this.getMajorClientData(major_client, 'tin'), 76, 125);
		this.doc.text(this.getMajorClientData(major_client, 'address'), 76, 131);
		
		this.doc.text(this.getMajorClientData(major_client, 'city'), 76, 136);
		this.doc.text(this.getMajorClientData(major_client, 'zipcode'), 76, 141);
		this.doc.text(this.getMajorClientData(major_client, 'country'), 76, 146);
		
		this.doc.text(this.getMajorClientData(major_client, 'telephone'), 76, 151);
		
		this.doc.text(this.getMajorClientData(major_client, 'alttelephone'), 76, 157);
		this.doc.text(this.getMajorClientData(major_client, 'fax'), 76, 163);
		this.doc.text(this.getMajorClientData(major_client, 'email'), 76, 169);
	}
}

let doc = new jsPDF();
let profile_data = <%= profile_data %>;
let major_stock_holder_data = <%= major_stock_holder_data %>;
let major_client_data = <%= major_client_data %>;

let broker_class = new BrokerClass(doc, profile_data, major_stock_holder_data, major_client_data);

broker_class.firstPageLayout();
broker_class.majorStockHolderLayout();
broker_class.majorClientLayout();
broker_class.lastPageLayout();
broker_class.download();
</script>