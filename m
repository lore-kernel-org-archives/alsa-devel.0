From: Matt Flax <flatmax@ieee.org>
Subject: Re: Release method?
Date: Thu, 24 Oct 2002 02:51:12 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021023165112.GA3423@ee.unsw.edu.au>
References: <20021023170553.3511839f.matthias@rpmforge.net> <s5helah18iq.wl@alsa2.suse.de> <20021023175446.7acdf7eb.matthias@rpmforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.unsw.edu.au (smtp3.unsw.EDU.AU [149.171.96.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA19566
	for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2002 18:23:08 +0200
Content-Disposition: inline
In-Reply-To: <20021023175446.7acdf7eb.matthias@rpmforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matthias Saou <matthias@rpmforge.net>
Cc: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I disagree for the moment here Matthias.
In my case I have waited to see what the response was from several 
people b4 thinking about installing RC4 ... the 0.9 series is after all 
the 'development release'. I noticed that there were problems and so I 
tried it to simply help out - to see if I had different errors with my 
OS / hardware.

One of the more beautiful things about ALSA is the fact that it is not 
ready to settle ... it is progressive ... that in my opinion is why  the 
API changes, along with other things like module names, etc.
I'm sure though that it will and is mature enough to start settling 
naturally ....

Matt

On Wed, Oct 23, 2002 at 05:54:46PM +0200, Matthias Saou wrote:
> Once upon a time, Takashi wrote :
> 
> > but, unfortuantely, we are in the stage of rc - that is, basically,
> > each release could be the final one (what an ironical situation...)
> > so, the test for the rc makes no sense from its definition.
> 
> Ironical indeed since this has been lasting for some time now :-/ I don't
> mean to criticize your good work on ALSA or anything else, but "release
> candidates" represent for me something that all developers agree as what
> should already be the actual release, but that they're releasing to the
> public as a "candidate" just to iron out bugs they could have missed. This
> is not what the latest 0.9.0rc releases seem to me, as ALSA is still
> evolving much.
> 
> I think that these release candidates should have been versioned 0.8.90,
> 0.8.91 etc. as this is trivial for string comparison.
> For developers and some users, all the strings "rc", "pl", "alpha", "beta"
> seem obvious, but for regular users they're not, nor are they for any type
> of automated version comparaison.
> 
> > anyway, i myself would love to release 0.9.0 final once if most of
> > obvious bugs on rc5 are fixed.  but, it's the decision by Jaroslav.
> 
> When that will happen, what next? Will be have 1.0alphaX, then 1.0betaX,
> then 1.0rcX... until 1.0? That is what I dislike, as it's really not harder
> to use 0.9.X instead, as long as you mention that it's the development
> branch that will lead to 1.0 and that the current suggested release is
> 0.9.0.
> 
> I'm just suggesting something that I think would make life easier for
> everyone, and trying to argument my opinion, not trying to force you into
> deciding something you've probably already thought about. I think I'm just
> mostly wondering.
> 
> Matthias
> 
> -- 
> Clean custom Red Hat Linux rpm packages : http://freshrpms.net/
> Red Hat Linux release 7.3 (Valhalla) running Linux kernel 2.4.18-10acpi
> Load : 0.02 0.21 0.27
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: Influence the future 
> of Java(TM) technology. Join the Java Community 
> Process(SM) (JCP(SM)) program now. 
> http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
http://mffm.darktech.org

WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
Vector Bass                : http://mffmvectorbass.sourceforge.net/
Multimedia Time Code       : http://mffmtimecode.sourceforge.net/


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
