From: Brian Hall <brihall@pcisys.net>
Subject: Re: support for CS4630 2nd AC97 codec?
Date: Fri, 8 Feb 2002 08:10:21 -0700 (MST)
Message-ID: <Pine.SOL.4.05.10202080808290.21185-100000@babu.pcisys.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from babu.pcisys.net (brihall@babu.pcisys.net [207.76.102.243])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA08587
	for <alsa-devel@alsa-project.org>; Fri, 8 Feb 2002 16:10:45 +0100
In-Reply-To: <Pine.LNX.4.31.0202080843150.514-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hmmm. Would it be possible (in theory, at least) to use the Windows
DLLs/drivers to access this stuff, in the same way that MPlayer uses a
thin Wine layer to use Win32 video codecs?

On Fri, 8 Feb 2002, Jaroslav Kysela wrote:

> yOn Thu, 7 Feb 2002, Brian Hall wrote:
> 
> >
> > I saw this question on the alsa-devel list, I thought I would forward the
> > information the the datasheet for the 2nd codec (the cs4294) is
> > downloadable from the cirrus website at:
> >
> > http://www.cirrus.com/pubs/pubs_current/cs4294.pdf
> >
> > If this is useful you may want to forward it to the alsa-devel list- I am
> > not currently subscribed; I just bought a Santa Cruz and I've been
> > "Cruz-ing" for information on getting more of its features working under
> > Linux (I am aware of the cs46xx driver).
> 
> We have datasheets for AC97 codecs. We need an updated firmware for
> CS46xx chips to support 2nd codec. Unfortunately, Cirrus Logic denies to
> release firmware and updated specifications or a DSP description with
> instruction set and memory organization to develop full support for CS46xx
> chips.
> 
> 						Jaroslav


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
