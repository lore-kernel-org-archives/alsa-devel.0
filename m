From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Openchrome-users] via epia boards sound quality
Date: Tue, 29 Aug 2006 13:51:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0608291350560.5772@tm8103-a.perex-int.cz>
References: <web-171768144@cgp.dol.ru> <44E8521E.40309@superbug.co.uk>
	<m2k64sdiwv.fsf@vador.mandriva.com> <s5hfyfg7w2c.wl%tiwai@suse.de>
	<44F42786.1020203@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44F42786.1020203@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, Thierry Vignaud <tvignaud@mandriva.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 29 Aug 2006, James Courtier-Dutton wrote:

> Takashi Iwai wrote:
> > At Mon, 28 Aug 2006 16:38:56 +0200,
> > Thierry Vignaud wrote:
> >   
> >> James Courtier-Dutton <James@superbug.co.uk> writes:
> >>
> >>     
> >>> So, with the absence of the VT1617A datasheet, we effectively have
> >>> no documentation for that AC97 register touched in your patch.
> >>> Could I ask you to raise an alsa bug at
> >>> https://bugtrack.alsa-project.org/alsa-bug/
> >>>
> >>> Enter into the bug everything from your updated email, with the sign
> >>> off and attached patch.
> >>> I will then check the patch into the HG repository, but I will add a
> >>> comment next to it pointing to the bug information. That way, future
> >>> developers will know why it has been put there.
> >>>       
> >> this was added into
> >> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2381 but didn't
> >> make it into HG (or at least the BR wasn't closed)...
> >>     
> >
> > I committed now.
> >
> > Thanks,
> >
> > Takashi
> >   
> 
> For those interested, I managed to get the VT1617 datasheet from VIA. 
> (no NDAs involved.)
> One can find it here:
> http://alsa-project.org/~james/datasheets/via/
> Filename: DS_VT1617_120.pdf

Ok, the URL is 
ftp://ftp.alsa-project.org/pub/datasheets/via/DS_VT1617_120.pdf now.
I'm moving other datasheets too.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
