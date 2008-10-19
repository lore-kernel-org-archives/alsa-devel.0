From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Sun, 19 Oct 2008 20:07:49 +0200
Message-ID: <5501535d0810191107g5df3d71flee4c6db9a7c35b3b@mail.gmail.com>
References: <s5hy70xsl46.wl%tiwai@suse.de> <48F86293.90205@gmail.com>
	<s5hhc7bzgf4.wl%tiwai@suse.de> <48F86606.9070108@gmail.com>
	<s5h8wsnzfcu.wl%tiwai@suse.de>
	<48F9B51C.1040505@nostalgicnetworxx.org>
	<s5h3aiu2b9j.wl%tiwai@suse.de>
	<1224349819.4088.25.camel@petrie.sacredspiral.co.uk>
	<1224350224.4088.28.camel@petrie.sacredspiral.co.uk>
	<s5hej2dui9t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.246])
	by alsa0.perex.cz (Postfix) with ESMTP id F0CCB24343
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Oct 2008 20:08:08 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so1225839rvb.32
	for <alsa-devel@alsa-project.org>; Sun, 19 Oct 2008 11:07:49 -0700 (PDT)
In-Reply-To: <s5hej2dui9t.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

By the way, the frontpannel headphone does not work.
Is it supposed to work?

http://us.creative.com/products/product.asp?category=209&subcategory=669&product=16559

(I Have this frontpannel but actually no X-RAM version of the X-Fi
series, or at least I can't remember that it has X-RAM)


01:00.0 Multimedia audio controller: Creative Labs SB X-Fi
        Subsystem: Creative Labs X-Fi Platinum
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (1000ns min, 1250ns max), Cache Line Size: 16 bytes
        Interrupt: pin A routed to IRQ 21
        Region 0: I/O ports at 8c00 [size=32]
        Region 1: Memory at eb800000 (64-bit, non-prefetchable) [size=2M]
        Region 3: Memory at e4000000 (64-bit, non-prefetchable) [size=64M]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Kernel driver in use: SB-XFi



01:00.0 0401: 1102:0005
        Subsystem: 1102:0021
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (1000ns min, 1250ns max), Cache Line Size: 16 bytes
        Interrupt: pin A routed to IRQ 21
        Region 0: I/O ports at 8c00 [size=32]
        Region 1: Memory at eb800000 (64-bit, non-prefetchable) [size=2M]
        Region 3: Memory at e4000000 (64-bit, non-prefetchable) [size=64M]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Kernel driver in use: SB-XFi

Kind regards
Bjoern
