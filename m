From: Warren Turkal <wturkal@cbu.edu>
Subject: Fwd: RE: To ESS Tech Support
Date: Wed, 11 Jun 2003 20:54:07 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306110058.09727.wturkal@cbu.edu>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/095+LD0J6pbHJo"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_/095+LD0J6pbHJo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear ALSA developers,

Here is a message from ESS regarding getting some information for the 
ESS1988/Allegro-1 series cards in order to get better support for them in 
linux. I hope that some others will help me badger the ESS people in order to 
(A) release info needed to make the Linux driver or (B) release the Windows 
driver source so that it can be used for ideas for the Linux driver.

If you choose to reply to this, please CC me as I am not subscribed to this 
list.

Thanks, Warren Turkal
-- 
Treasurer, GOLUM, Inc.
http://www.golum.org



--Boundary-00=_/095+LD0J6pbHJo
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 7bit
Content-Description: TECHINFO <Techinfo@esstech.com>: RE: To ESS Tech Support

Received: from polaris.cbu.edu (polaris.cbu.edu [192.168.10.34])
	by cbu.edu (8.11.7+Sun/8.11.7) with SMTP id h5ANTLM02443
	for <wturkal@cbu.edu>; Tue, 10 Jun 2003 18:29:22 -0500 (CDT)
Received: from [209.172.108.133] ([209.172.108.133])
 by polaris.cbu.edu (SAVSMTP 3.1.1.32) with SMTP id M2003061018290804765
 for <wturkal@cbu.edu>; Tue, 10 Jun 2003 18:29:18 -0500
Received: from essmail.esstech.com by [209.172.108.133]
          via smtpd (for polaris.cbu.edu [66.192.88.32]) with SMTP; Tue, 10 Jun 2003 16:29:08 -0700
Received: by essmail.esstech.com with Internet Mail Service (5.5.2653.19)
	id <LCVN4B43>; Tue, 10 Jun 2003 16:24:49 -0700
Message-ID: <02B8E281442ED6118527000103D16BFB01CA0CC7@essmail.esstech.com>
From: TECHINFO <Techinfo@esstech.com>
To: wturkal@cbu.edu
Subject: RE: To ESS Tech Support
Date: Tue, 10 Jun 2003 16:24:48 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Length: 1869
X-Spam-Status: No, hits=0.0 required=5.0
	tests=none
	version=2.55
X-Spam-Level: 
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)
Status: R 
X-Status: N
X-KMail-EncryptionState: 
X-KMail-SignatureState: 

Sorry, we don't have Linux driver to share with you.
Regards,


 -----Original Message-----
From: 	wturkal@cbu.edu [mailto:wturkal@cbu.edu] 
Sent:	Friday, May 30, 2003 2:00 AM
To:	techinfo@esstech.com
Subject:	To ESS Tech Support

Tech Support Contact Form
---------------------------------------
PERSONAL INFORMATION:
First Name    : Warren
Last Name     : Turkal
Country    : USA
Phone Number  : 901-372-3416
Email Address : wturkal@cbu.edu

ESS Chip ID       : es1988

Windows Version?  : Linux

Product Brand & Model of PC/Notebook or Add-in Board?  : Gateway 600ygr

Current ESS Driver Version?  : Linux 2.5.70

Contacted Product Manufacturer?   : yes

Updated Driver?   : yes

Read FAQ?         : yes

Did FAQ Help?     : no

SPECIFIC PROBLEM:
Simple dsp audio i/o is supported in your es1988 under Linux, but I would
like to add full support for the card.

02:03.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev
12)
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 5000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

I have a technical document describing the es1988 with its registers. Do
you have a document that has help for writing a driver for the es1988 in
it? Source code to your driver would probably also make this easier, even
if the driver is for a different OS.

Please do not hesitate to email me with any questions.

Thanks, Warren

--Boundary-00=_/095+LD0J6pbHJo--



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
