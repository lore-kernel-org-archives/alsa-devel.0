From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: CVS changes, rc4 release in H-9
Date: Tue, 22 Oct 2002 11:51:30 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0210221147430.2070-100000@cmn37.stanford.edu>
References: <Pine.LNX.4.33.0210221313250.521-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA16904
	for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2002 20:52:30 +0200
In-Reply-To: <Pine.LNX.4.33.0210221313250.521-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > > Yep, please, commit it for more wide use...
> > 
> > ok, it's now on alsa-driver/utils.
> > should it be installed to the public directory via "make install" ?
> 
> I don't think so. Perhaps, we might add a note for users to the INSTALL 
> file.

Please do, it is a very useful utility. 

On a different aspect of the upcoming release. The module options naming
has been changed, I hope that will be highlighted in the release notes. I
just managed to install the latest cvs (it worked, at least in limited
tests)  and of course the modules failed to load... I bet most users will
not do a detailed reading of the error messages :-) My first reaction (and 
I should know better) was to think, oops the module is broken...

-- Fernando



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576301;v?http://www.sun.com/javavote
